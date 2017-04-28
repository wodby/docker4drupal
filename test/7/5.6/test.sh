#!/usr/bin/env bash

set -e

if [[ ! -z "${DEBUG}" ]]; then
  set -x
fi

DB_NAME=drupal
DB_HOST=mariadb
DB_USER=drupal
DB_PASS=drupal
DB_URL="mysql://${DB_USER}:${DB_PASS}@${DB_HOST}/${DB_NAME}"

make init -f /usr/local/bin/actions.mk

composer require \
    drupal/redis \
    drupal/search_api \
    drupal/search_api_solr \
    drupal/varnish \
    drupal/features

cd ./web

drush si --db-url="${DB_URL}" -y
drush en -y redis search_api search_api_solr varnish features

# Enable redis
chmod 755 "${PWD}/sites/default/settings.php"
echo "include '${PWD}/sites/default/test.settings.php';" >> "${PWD}/sites/default/settings.php"
drush cc all

# Test solr server connection
drush en -y feature_search_api_solr
drush core-requirements | grep -q "Solr servers\s\+OK"
drush core-requirements | grep -q "The Solr server could be reached."

drush core-requirements | grep -q "Database system\s\+Info\s\+MySQL, MariaDB"
drush core-requirements | grep -q "Redis\s\+OK\s\+Connected, using the PhpRedis client"
drush core-requirements | grep -q "PHP\s\+Info\s\+5.6"
drush core-requirements | grep -q "Varnish status\s\+Info\s\+Running"

# Test varnish cache and purge
curl -Is varnish:6081 | grep -q "X-Varnish-Cache: MISS"
curl -Is varnish:6081 | grep -q "X-Varnish-Cache: HIT"

drush varnish-purge-all

curl -Is varnish:6081 | grep -q "X-Varnish-Cache: MISS"
curl -Is varnish:6081 | grep -q "X-Varnish-Cache: HIT"
