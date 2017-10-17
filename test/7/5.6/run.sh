#!/usr/bin/env bash

set -e

if [[ ! -z "${DEBUG}" ]]; then
  set -x
fi

. ../../images.env

docker-compose up -d
docker-compose exec mariadb make check-ready -f /usr/local/bin/actions.mk max_try=12 wait_seconds=5
docker-compose exec solr make check-ready -f /usr/local/bin/actions.mk max_try=12 wait_seconds=3
docker-compose exec solr make core=core1 -f /usr/local/bin/actions.mk
docker-compose exec --user=0 php chown -R www-data:www-data /var/www/html
docker-compose exec php ./test.sh
docker-compose down
