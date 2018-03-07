#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

DB_URL="${DB_DRIVER}://${DB_USER}:${DB_PASSWORD}@${DB_HOST}/${DB_NAME}"

make init -f /usr/local/bin/actions.mk

cd ./web

drush si --db-url="${DB_URL}" -y
drush dl memcache-6.x-1.11

chmod 755 "${APP_ROOT}/web/sites/default/settings.php"
echo "include '${APP_ROOT}/test.settings.php';" >> "${APP_ROOT}/web/sites/default/settings.php"

drush en memcache -y
