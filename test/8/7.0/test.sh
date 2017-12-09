#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

check_rq() {
    echo "Checking requirement: ${1} must be ${2}"
    drush rq --format=json | jq ".\"${1}\".value" | grep -q "${2}"
    echo "OK"
}

check_status() {
    echo "Checking status: ${1} must be ${2}"
    drush status --format=yaml | grep -q "${1}: ${2}"
    echo "OK"
}

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

# Test Drupal status and requirements
check_status "drush-version" "8.*"
check_status "root" "${APP_ROOT}/${DOCROOT_SUBDIR}"
check_status "drupal-settings-file" "sites/default/settings.php"
check_status "site" "sites/default"
check_status "files" "sites/default/files"
check_status "temp" "/tmp"
check_status "config-sync" "../config/sync"

check_rq "database_system" "MySQL, MariaDB, Percona Server, or equivalent"
check_rq "image.toolkit" "gd"
check_rq "php_opcache" "Enabled"
check_rq "php" "${PHP_VERSION}"
check_rq "file system" "Writable (<em>public</em> download method)"
check_rq "configuration_files" "Protected"

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
check_rq "redis" "Connected, using the <em>PhpRedis</em> client"

# Import solr server
drupal cis --file search_api.server.solr_6_4.yml
check_rq "search_api_solr" "1 server"
check_rq "search_api_solr_multiple_indexes" "1 server"

# Test varnish cache and purge
cp varnish-purger.yml purger.yml

drush ppadd varnish
drush cr

## Workaround for varnish purger import https://www.drupal.org/node/2856221
PURGER_ID=$(drush ppls --format=json | jq -r "keys[0]")

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
