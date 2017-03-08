#!/usr/bin/env bash

set -e

if [[ ! -z $DEBUG ]]; then
  set -x
fi

docker-compose up -d
docker-compose exec mariadb make check-ready -f /usr/local/bin/actions.mk
docker-compose exec --user=82 php ./test.sh
docker-compose down
