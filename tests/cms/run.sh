#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

docker compose up -d
docker compose exec -T mariadb make check-ready -f /usr/local/bin/actions.mk max_try=12 wait_seconds=5
docker compose exec -T solr make check-ready -f /usr/local/bin/actions.mk max_try=12 wait_seconds=3
docker compose exec -T solr make init -f /usr/local/bin/actions.mk
docker compose exec -T --user=0 php apk add --update jq
docker compose exec -T --user=0 php chown -R wodby:wodby /var/www/html
docker compose exec -T php tests.sh
docker compose down
