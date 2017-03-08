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
    composer require -d /var/www/html \
        drupal/redis:^1.0@beta \
        drupal/search_api:^1.0@beta \
        drupal/search_api_solr:^1.0@beta \
        drupal/purge:^3.0@beta \
        drupal/varnish_purge:1.x \
        drupal/cache_tags:^1.0@beta

    drush en -y \
        redis \
        search_api \
        search_api_solr \
        purge \
        purge_queuer_coretags \
        purge_drush \
        varnish_purger \
        varnish_purge_tags \
        cache_tags
}

runTests() {
    # Test solr server connection
    drupal cis "search_api.server.solr_6_4" search-api-solr-server.yml
    drush core-requirements | grep -s "Solr servers\s\+OK"
    drush core-requirements | grep -s "The Solr server could be reached."

    # Enable redis
    chmod 755 "${PWD}/sites/default/settings.php"
    echo "include '${PWD}/sites/default/test.settings.php';" >> "${PWD}/sites/default/settings.php"

    drush core-requirements | grep -s "Database system\s\+Info\s\+MySQL, MariaDB"
    drush core-requirements | grep -s "Image toolkit\s\+Info\s\+gd"
    drush core-requirements | grep -s "Redis\s\+OK\s\+Connected, using the PhpRedis client"
    drush core-requirements | grep -s "PHP OPcode caching\s\+Info\s\+Enabled"
    drush core-requirements | grep -s "PHP\s\+Info\s\+7.0"

    # Test varnish cache and purge
    cp varnish-purger.yml purger.yml

    drush ppa varnish
    drush cr

    # Workaround for varnish purger import https://www.drupal.org/node/2856221
    PURGER_ID="$(drush ppu | awk 'NR==2{print $1}' | tr -cd '[[:alnum:]]')"

    sed -i "s/PLUGIN_ID/${PURGER_ID}/g" purger.yml
    drupal cis "varnish_purger.settings.${PURGER_ID}" purger.yml

    drush -y config-set system.performance cache.page.max_age 43200

    curl -Is varnish:6081 | grep -s "X-Varnish-Cache: MISS"
    curl -Is varnish:6081 | grep -s "X-Varnish-Cache: HIT"

    drush cc render
    drush pqw

    curl -Is varnish:6081 | grep -s "X-Varnish-Cache: MISS"
    curl -Is varnish:6081 | grep -s "X-Varnish-Cache: HIT"
}

cd ./web
installDrupal
installModules
runTests
