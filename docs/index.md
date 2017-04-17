# Docker4Drupal Getting Started

Docker4Drupal is a set of docker containers optimized for Drupal. Use docker-compose.yml file from [docker4drupal repository](https://github.com/wodby/docker4drupal) to spin up local environment on Linux, Mac OS X and Windows. 

Docker4Drupal is designed to be used for local development, if you're looking for a dev/staging/production solution consistent with Docker4Drupal check out [Wodby](https://wodby.com). 

## Overview

The Drupal bundle consist of the following containers:

[wodby/drupal-nginx]: https://github.com/wodby/drupal-nginx
[wodby/drupal-php]: https://github.com/wodby/drupal-php
[wodby/mariadb]: https://github.com/wodby/mariadb
[wodby/redis]: https://github.com/wodby/redis
[wodby/drupal-varnish]: https://github.com/wodby/drupal-varnish
[wodby/drupal-solr]: https://github.com/wodby/drupal-solr
[wodby/memcached]: https://github.com/wodby/memcached
[phpmyadmin/phpmyadmin]: https://hub.docker.com/r/phpmyadmin/phpmyadmin
[mailhog/mailhog]: https://hub.docker.com/r/mailhog/mailhog
[_/node]: https://hub.docker.com/_/node
[_/traefik]: https://hub.docker.com/_/traefik

| Container | Versions | Service name | Image | Enabled by default |
| --------- | -------- | ------------ | ----- | ------------------ |
| [Nginx](containers/nginx.md)         | 1.10               | nginx     | [wodby/drupal-nginx]    | ✓ |
| [PHP](containers/php.md)             | 5.3, 5.6, 7.0, 7.1 | php       | [wodby/drupal-php]      | ✓ |
| [MariaDB](containers/mariadb.md)     | 10.1               | mariadb   | [wodby/mariadb]         | ✓ |
| [Redis](containers/redis.md)         | 3.2                | redis     | [wodby/redis]           |   |
| [Varnish](containers/varnish.md)     | 4.1                | varnish   | [wodby/drupal-varnish]  |   |
| [Solr](containers/solr.md)           | 5.5, 6.3, 6.4      | solr      | [wodby/drupal-solr]     |   |
| [Memcached](containers/memcached.md) | 1.4                | memcached | [wodby/memcached]       |   |
| Mailhog                              | latest             | mailhog   | [mailhog/mailhog]       | ✓ |
| phpMyAdmin                           | latest             | pma       | [phpmyadmin/phpmyadmin] |   |
| Node.js                              | 7                  | node      | [_/node]                |   |
| Traefik                              | latest             | traefik   | [_/traefik]             |   |

Supported Drupal versions: 6, 7, 8.

## Requirements

* Install Docker ([Linux](https://docs.docker.com/engine/installation), [Docker for Mac](https://docs.docker.com/engine/installation/mac) or [Docker for Windows (10+ Pro)](https://docs.docker.com/engine/installation/windows))
* For Linux additionally install [docker compose](https://docs.docker.com/compose/install)

## Must know before you start

1. **You will lose MariaDB data** if you run `docker-compose down`. Instead use `docker-compose stop` to stop containers. Alternatively, you can use a manual volume for mariadb data (see compose file), this way your data will always persist 
2. To avoid potential problems with permissions between your host and containers please follow [this instructions](permissions.md)
3. _For macOS users_: Out of box Docker for Mac volumes has [poor performance](https://github.com/Wodby/docker4drupal/issues/4). However there's a workaround based on [docker-sync project](https://github.com/EugenMayer/docker-sync/), read instructions [here](macos.md)

## Usage 

There 2 options how to use docker4drupal – you can either run [vanilla](https://en.wikipedia.org/wiki/Vanilla_software) Drupal from the image or mount your own Drupal codebase:

### 1. Run Vanilla Drupal from Image (default)

1. Download [docker-compose.yml file](https://github.com/wodby/docker4drupal/blob/master/docker-compose.yml)
2. Depending on Drupal version you want to run update images tags (versions) for php and nginx services, default is Drupal 8
3. Run containers: `docker-compose up -d` 
4. Wait a few seconds for containers initialization 
5. That's it! Proceed with Drupal installation at [http://drupal.docker.localhost:8000](http://drupal.docker.localhost:8000). Default database user, password and database name are all `drupal`, database host is `mariadb`

### 2. Mount my Drupal Codebase

1. Download [docker-compose.yml file](https://github.com/wodby/docker4drupal/blob/master/docker-compose.yml) from [docker4drupal repository](https://github.com/wodby/docker4drupal) and put it to your Drupal project root
2. Replace php image to `wodby/drupal-php`. Depending on your Drupal version update nginx image
3. Update nginx and php volumes to `- ./:/var/www/html`. This means that the directory with the compose file will be mounted to containers   
4. If your project is not based on [composer template](https://github.com/drupal-composer/drupal-project), update `NGINX_SERVER_ROOT` to `/var/www/html` (drupal root == git root)
5. Make sure you have the same database credentials in your settings.php file and MariaDB definition in the compose file 
6. Optional: [import existing database](containers/mariadb.md#import-existing-database)
7. Optional: add additional services (Redis, Solr, etc) by uncommenting the corresponding lines in the compose file
8. Optional: [configure domains](domains.md)
9. Run containers: `docker-compose up -d`
10. That's it! Your drupal website should be up and running at [http://drupal.docker.localhost:8000](http://drupal.docker.localhost:8000). If you need to run multiple projects simultaneously see [this article](multiple-projects.md)

You can stop containers by executing:
```bash
docker-compose stop
```

Feel free to adjust volumes and ports in the compose file for your convenience. Also, read [how to access containers](access.md) and [how to get logs](logs.md)

## Status

We're actively working on these instructions and containers. More options will be added soon. If you have a feature request or found a bug please [submit an issue on GitHub](https://github.com/wodby/docker4drupal/issues/new) or [![Wodby Slack](https://www.google.com/s2/favicons?domain=www.slack.com) join us on Slack](https://slack.wodby.com/)

We update containers from time to time by releasing new image tags.

## License

This project is licensed under the MIT open source license.
