#!/usr/bin/env bash

set -e

if [[ ! -z $DEBUG ]]; then
  set -x
fi

DB_NAME=drupal
DB_HOST=mariadb
DB_USER=drupal
DB_PASS=drupal
DB_URL=mysql://${DB_USER}:${DB_PASS}@${DB_HOST}/${DB_NAME}

installDrupal() {
    drush si --db-url=${DB_URL} -y
}

installModules() {
    drush dl varnish redis
    drush en -y varnish redis

    composer require -d /var/www/html \
        drupal/redis:3.x \
        drupal/search_api:1.x \
        drupal/search_api_solr:1.x \
        drupal/varnish:1.x \
        drupal/features:2.x

    drush en -y redis search_api search_api_solr varnish features
}

runTests() {
    # Enable redis
    chmod 755 "${PWD}/sites/default/settings.php"
    echo "include '${PWD}/sites/default/test.settings.php';" >> "${PWD}/sites/default/settings.php"
    drush cc all

    # Test solr server connection
    drush en -y feature_search_api_solr
    drush core-requirements | grep -s "Solr servers\s\+OK"
    drush core-requirements | grep -s "The Solr server could be reached."

    drush core-requirements | grep -s "Database system\s\+Info\s\+MySQL, MariaDB"
    drush core-requirements | grep -s "Redis\s\+OK\s\+Connected, using the PhpRedis client"
    drush core-requirements | grep -s "PHP\s\+Info\s\+7.0"
    drush core-requirements | grep -s "Varnish status\s\+Info\s\+Running"

    # Test varnish cache and purge
    curl -Is varnish:6081 | grep -s "X-Varnish-Cache: MISS"
    curl -Is varnish:6081 | grep -s "X-Varnish-Cache: HIT"

    drush varnish-purge-all

    curl -Is varnish:6081 | grep -s "X-Varnish-Cache: MISS"
    curl -Is varnish:6081 | grep -s "X-Varnish-Cache: HIT"
}

cd ./web
installDrupal
installModules
runTests
