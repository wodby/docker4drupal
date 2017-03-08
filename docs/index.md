# Docker4Drupal

Docker4Drupal is a set of docker containers optimized for Drupal. Use docker-compose.yml file from [docker4drupal repository](https://github.com/wodby/docker4drupal) to spin up local environment on Linux, Mac OS X and Windows. 

Docker4Drupal is designed to be used for local development, if you're looking for a dev/staging/production solution consistent with Docker4Drupal check out [Wodby](https://wodby.com). 

## Overview

The Drupal bundle consist of the following containers:

| Container | Service name | Image | Public Port | Enabled by default |
| --------- | ------------ | ----- | ----------- | ------------------ |
| [Nginx 1.10](containers/nginx.md)                | nginx     | [wodby/drupal-nginx](https://github.com/wodby/drupal-nginx/)            | 8000 | ✓ |
| [PHP 5.3/5.6/7.0/7.1](containers/php.md)         | php       | [wodby/drupal-php](https://github.com/wodby/drupal-php/)                |      | ✓ |
| [MariaDB 10.1](containers/mariadb.md)            | mariadb   | [wodby/mariadb](https://github.com/wodby/mariadb/)                      |      | ✓ |
| [Redis 3.2](containers/redis.md)                 | redis     | [wodby/redis](https://hub.docker.com/wodby/redis)                       |      | ✓ |
| [Varnish 4.1](containers/varnish.md)             | varnish   | [wodby/drupal-varnish](https://github.com/wodby/drupal-varnish)         | 8004 |   |
| [Apache Solr 5.5/6.3/6.4](containers/varnish.md) | solr      | [wodby/drupal-solr](https://github.com/wodby/drupal-solr)               | 8003 |   |
| [phpMyAdmin](containers/pma.md)                  | pma       | [phpmyadmin/phpmyadmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin) | 8001 | ✓ |
| [Mailhog](containers/mailhog.md)                 | mailhog   | [mailhog/mailhog](https://hub.docker.com/r/mailhog/mailhog)             | 8002 | ✓ |
| [Node.js 7](containers/node.md)                  | node      | [_/node](https://hub.docker.com/_/node)                                 | 3000 |   |
| [Memcached](containers/memcached.md)             | memcached | [_/memcached](https://hub.docker.com/_/memcached/)                      |      |   |

Supported Drupal versions: 6/7/8.

## Requirements

* Install Docker ([Linux](https://docs.docker.com/engine/installation), [Docker for Mac](https://docs.docker.com/engine/installation/mac) or [Docker for Windows (10+ Pro)](https://docs.docker.com/engine/installation/windows))
* For Linux additionally install [docker compose](https://docs.docker.com/compose/install)

## Must know before you start

1. To make sure you don't lose your MariaDB data DO NOT use `docker-compose down` (Docker will destroy volumes), instead use `docker-compose down`. Alternatively, you can specify manual volume for `/var/lib/mysql` (see compose file), this way your data will always persist 
2. To avoid potential problems with permissions between your host and containers please follow [this instructions](permissions.md)
3. _For macOS users_: Out of box Docker for Mac has [poor performance](https://github.com/Wodby/docker4drupal/issues/4) on macOS. However there's a workaround based on [docker-sync project](https://github.com/EugenMayer/docker-sync/), read instructions [here](macos.md)

## Usage 

Feel free to adjust volumes and ports in the compose file for your convenience.

1. Download [docker-compose.yml file](https://github.com/wodby/docker4drupal/blob/master/docker-compose.yml) from [docker4drupal repository](https://github.com/wodby/docker4drupal) and put it to your Drupal project codebase directory. This directory will be mounted to PHP and Nginx containers 
2. Depending on your Drupal version make sure you're using correct tags (versions) of Nginx and PHP images
3. Make sure you have the same database credentials in your settings.php file and MariaDB service definition in the compose file 
4. Optional: [import existing database](containers/mariadb.md#import-existing-database)
6. Optional: add additional services (Varnish, Apache Solr, Memcached, Node.js) by uncommenting the corresponding lines in the compose file
7. Optional: [attach domains](domains.md)
8. Run containers:
```bash
docker-compose up -d
```
9. That's it! You drupal website should be up and running at http://localhost:8000 (or http://drupal.docker.localhost if you use domains)

You can stop containers by executing:
```bash
docker-compose stop
```

Also, read [how to access containers](access.md) and [how to get logs](logs.md)

## Status

We're actively working on this instructions and containers. More options will be added soon. If you have a feature request or found a bug please [submit an issue on GitHub](https://github.com/wodby/docker4drupal/issues/new) or [![Wodby Slack](https://www.google.com/s2/favicons?domain=www.slack.com) join us on Slack](https://slack.wodby.com/)

We update containers from time to time by releasing new images tags.

## License

This project is licensed under the MIT open source license.
