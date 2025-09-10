#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
  set -x
fi

check_rq() {
  echo "Checking requirement: ${1} must be ${2}"
  drush rq --format=json | jq '.[] | select(.title=="'"${1}"'") | .value' | grep -q "${2}"
  echo "OK"
}

check_status() {
  echo "Checking status: ${1} must be ${2}"
  drush status --format=yaml | grep -q "${1}: ${2}"
  echo "OK"
}

DB_URL="${DB_DRIVER}://${DB_USER}:${DB_PASSWORD}@${DB_HOST}/${DB_NAME}"

make init -f /usr/local/bin/actions.mk

composer require -n \
  drupal/redis \
  drupal/purge \
  drupal/varnish_purge

composer require -n \
  drupal/search_api \
  drupal/search_api_solr:~4

cd ./web

drush si -y --db-url="${DB_URL}"

# Test Drupal status and requirements
check_status "drush-version" "13.*"
check_status "root" "${APP_ROOT}/${DOCROOT_SUBDIR}"
check_status "site" "sites/default"
check_status "files" "sites/default/files"
check_status "temp" "/tmp"

check_rq "Database system" "MariaDB"
check_rq "Image toolkit" "gd"
check_rq "PHP OPcode caching" "Enabled"
check_rq "PHP" "${PHP_VERSION}"
check_rq "File system" "Writable"
check_rq "Configuration files" "Protected"

drush en -y \
  redis \
  purge \
  purge_queuer_coretags \
  purge_drush \
  varnish_purger \
  varnish_purge_tags

drush en -y search_api_solr_admin

chmod 755 "${PWD}/sites/default/settings.php"
echo "include '${PWD}/sites/default/test.settings.php';" >>"${PWD}/sites/default/settings.php"

## Enable redis
check_rq "Redis" "Connected"

check_rq "Trusted Host Settings" "Enabled"

# Import solr server
drush cim --source=/var/www/html/solr --partial -y
drush solr-upload-conf solr
drush sapi-sl | grep -q enabled

## Test varnish cache and purge
drush ppadd varnish
drush cr

## Workaround for varnish purger import https://www.drupal.org/node/2856221
PURGER_ID=$(drush ppls --format=json | jq -r "keys[0]")

mkdir -p /var/www/html/varnish
# We copy mounted file because we can't edit mounted file (resource busy error).
cp /var/www/html/varnish-purger.yml /var/www/html/varnish/purger.yml
sed -i "s/PLUGIN_ID/${PURGER_ID}/g" /var/www/html/varnish/purger.yml
mv /var/www/html/varnish/purger.yml "/var/www/html/varnish/varnish_purger.settings.${PURGER_ID}.yml"
drush -y cim --source=/var/www/html/varnish --partial
drush -y config-set system.performance cache.page.max_age 43200

curl -Is -H 'Host: drupal.localhost' varnish:6081 | grep -q "X-VC-Cache: MISS"
curl -Is -H 'Host: drupal.localhost' varnish:6081 | grep -q "X-VC-Cache: HIT"

drush cc render
drush pqw

curl -Is -H 'Host: drupal.localhost' varnish:6081 | grep -q "X-VC-Cache: MISS"
curl -Is -H 'Host: drupal.localhost' varnish:6081 | grep -q "X-VC-Cache: HIT"
