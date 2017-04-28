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

cd ./web

drush si --db-url="${DB_URL}" -y
drush dl memcache-6.x-1.11

chmod 755 "${APP_ROOT}/web/sites/default/settings.php"
echo "include '${APP_ROOT}/test.settings.php';" >> "${APP_ROOT}/web/sites/default/settings.php"

drush en memcache -y

drush core-requirements | grep -q "PHP\s\+Info\s\+5.3"
drush core-requirements | grep -q "Memcache\s\+OK\s\+2.2.0"