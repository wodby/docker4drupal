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
    drupal/purge \
    drupal/varnish_purge \
    drupal/cache_tags

cd ./web

drush si -y --db-url="${DB_URL}"

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


# Enable redis
chmod 755 "${PWD}/sites/default/settings.php"
echo "include '${PWD}/sites/default/test.settings.php';" >> "${PWD}/sites/default/settings.php"

drush core-requirements | grep -q "Database system\s\+Info\s\+MySQL, MariaDB"
drush core-requirements | grep -q "Image toolkit\s\+Info\s\+gd"
drush core-requirements | grep -q "Redis\s\+OK\s\+Connected, using the PhpRedis client"
drush core-requirements | grep -q "PHP OPcode caching\s\+Info\s\+Enabled"
drush core-requirements | grep -q "PHP\s\+Info\s\+7.1"

# Test solr server connection
drupal cis --file search_api.server.solr_6_4.yml
drush core-requirements | grep -q "Solr servers\s\+OK"
drush core-requirements | grep -q "The Solr server could be reached."

# Test varnish cache and purge
cp varnish-purger.yml purger.yml

drush ppadd varnish
drush cr

## Workaround for varnish purger import https://www.drupal.org/node/2856221
PURGER_ID="$(drush ppls | awk 'NR==2{print $1}' | tr -cd '[[:alnum:]]')"

sed -i "s/PLUGIN_ID/${PURGER_ID}/g" purger.yml
mv purger.yml "varnish_purger.settings.${PURGER_ID}.yml"
drupal cis --file "varnish_purger.settings.${PURGER_ID}.yml"

drush -y config-set system.performance cache.page.max_age 43200

curl -Is varnish:6081 | grep -q "X-Varnish-Cache: MISS"
curl -Is varnish:6081 | grep -q "X-Varnish-Cache: HIT"

drush cc render
drush pqw

curl -Is varnish:6081 | grep -q "X-Varnish-Cache: MISS"
curl -Is varnish:6081 | grep -q "X-Varnish-Cache: HIT"
