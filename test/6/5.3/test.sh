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
DRUPAL6_DRUSH_ARCHIVE=https://s3-us-west-1.amazonaws.com/wodby-presets/drupal6/wodby-drupal6-latest.tar.gz

installDrupal() {
    # Site installation via drush is broken for Drupal 6.
    wget -q ${DRUPAL6_DRUSH_ARCHIVE}
    drush archive-restore ./wodby-drupal6-latest.tar.gz --db-url=${DB_URL}
}

runTests() {
    chmod 755 "${PWD}/sites/default/settings.php"
    echo "include '${PWD}/../test.settings.php';" >> "${PWD}/sites/default/settings.php"

    drush core-requirements | grep -s "PHP\s\+Info\s\+5.3"
    drush core-requirements | grep -s "Memcache admin\s\+OK\s\+Memcache included"
    drush core-requirements | grep -s "Memcache\s\+OK\s\+2.2.0"
}

installDrupal
cd ./app
runTests
