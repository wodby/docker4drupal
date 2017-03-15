# Docker4Drupal

Docker4Drupal is a set of docker containers optimized for Drupal. Use docker-compose.yml file from [docker4drupal repository](https://github.com/wodby/docker4drupal) to spin up local environment on Linux, Mac OS X and Windows. 

Docker4Drupal is designed to be used for local development, if you're looking for a dev/staging/production solution consistent with Docker4Drupal check out [Wodby](https://wodby.com). 

## Overview

The Drupal bundle consist of the following containers:

| Container | Versions | Service name | Image | Enabled by default |
| --------- | -------- | ------------ | ----- | ------------------ |
| [Nginx](containers/nginx.md)         | 1.10               | nginx     | [wodby/drupal-nginx](https://github.com/wodby/drupal-nginx/)            | ✓ |
| [PHP](containers/php.md)             | 5.3, 5.6, 7.0, 7.1 | php       | [wodby/drupal-php](https://github.com/wodby/drupal-php/)                | ✓ |
| [MariaDB](containers/mariadb.md)     | 10.1               | mariadb   | [wodby/mariadb](https://github.com/wodby/mariadb/)                      | ✓ |
| [Redis](containers/redis.md)         | 3.2                | redis     | [wodby/redis](https://hub.docker.com/wodby/redis)                       | ✓ |
| [Varnish](containers/varnish.md)     | 4.1                | varnish   | [wodby/drupal-varnish](https://github.com/wodby/drupal-varnish)         |   |
| [Solr](containers/varnish.md)        | 5.5, 6.3, 6.4      | solr      | [wodby/drupal-solr](https://github.com/wodby/drupal-solr)               |   |
| [phpMyAdmin](containers/pma.md)      | latest             | pma       | [phpmyadmin/phpmyadmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin) | ✓ |
| [Mailhog](containers/mailhog.md)     | latest             | mailhog   | [mailhog/mailhog](https://hub.docker.com/r/mailhog/mailhog)             | ✓ |
| [Node.js](containers/node.md)        | 7                  | node      | [_/node](https://hub.docker.com/_/node)                                 |   |
| [Memcached](containers/memcached.md) | latest             | memcached | [_/memcached](https://hub.docker.com/_/memcached/)                      |   |
| Traefik                              | latest             | traefik   | [_/traefik](https://hub.docker.com/_/traefik/)                          |   |

Supported Drupal versions: 6, 7, 8.

## Requirements

* Install Docker ([Linux](https://docs.docker.com/engine/installation), [Docker for Mac](https://docs.docker.com/engine/installation/mac) or [Docker for Windows (10+ Pro)](https://docs.docker.com/engine/installation/windows))
* For Linux additionally install [docker compose](https://docs.docker.com/compose/install)

## Must know before you start

1. To make sure you don't lose your MariaDB data DO NOT use `docker-compose down` (Docker will destroy volumes), instead use `docker-compose stop`. Alternatively, you can specify manual volume for `/var/lib/mysql` (see compose file), this way your data will always persist 
2. To avoid potential problems with permissions between your host and containers please follow [this instructions](permissions.md)
3. _For macOS users_: Out of box Docker for Mac has [poor performance](https://github.com/Wodby/docker4drupal/issues/4) on macOS. However there's a workaround based on [docker-sync project](https://github.com/EugenMayer/docker-sync/), read instructions [here](macos.md)

## Usage 

Feel free to adjust volumes and ports in the compose file for your convenience.

1. Download [docker-compose.yml file](https://github.com/wodby/docker4drupal/blob/master/docker-compose.yml) from [docker4drupal repository](https://github.com/wodby/docker4drupal) and put it to your Drupal project codebase directory. This directory will be mounted to PHP and Nginx containers 
2. Depending on your Drupal version make sure you're using correct tags (versions) of Nginx and PHP images
3. Make sure you have the same database credentials in your settings.php file and MariaDB service definition in the compose file 
4. Optional: [import existing database](containers/mariadb.md#import-existing-database)
6. Optional: add additional services (Varnish, Apache Solr, Memcached, Node.js) by uncommenting the corresponding lines in the compose file
7. Optional: [configure domains](domains.md)
8. Run containers: `docker-compose up -d`
9. That's it! You drupal website should be up and running at [http://drupal.docker.localhost:8000](http://drupal.docker.localhost:8000)

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
