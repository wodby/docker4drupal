# Docker4Drupal Getting Started

Docker4Drupal is a set of docker containers optimized for Drupal. Use docker-compose.yml file from [docker4drupal repository](https://github.com/wodby/docker4drupal) to spin up local environment on Linux, Mac OS X and Windows. 

Docker4Drupal is designed to be used for local development, if you're looking for a dev/staging/production solution consistent with Docker4Drupal check out [Wodby](https://wodby.com). 

## Overview

The Drupal stack consist of the following containers:

[wodby/drupal-nginx]: https://github.com/wodby/drupal-nginx
[wodby/drupal-apache]: https://github.com/wodby/drupal-apache
[wodby/drupal]: https://github.com/wodby/drupal
[wodby/drupal-php]: https://github.com/wodby/drupal-php
[wodby/mariadb]: https://github.com/wodby/mariadb
[wodby/redis]: https://github.com/wodby/redis
[wodby/drupal-varnish]: https://github.com/wodby/drupal-varnish
[wodby/drupal-solr]: https://github.com/wodby/drupal-solr
[wodby/drupal-node]: https://github.com/wodby/drupal-node
[wodby/memcached]: https://github.com/wodby/memcached
[wodby/rsyslog]: https://hub.docker.com/r/wodby/rsyslog
[athenapdf-service]: https://hub.docker.com/r/arachnysdocker/athenapdf-service
[mailhog]: https://hub.docker.com/r/mailhog/mailhog
[wodby/adminer]: https://hub.docker.com/r/wodby/adminer
[phpmyadmin]: https://hub.docker.com/r/phpmyadmin/phpmyadmin
[portainer]: https://hub.docker.com/r/portainer/portainer
[_/node]: https://hub.docker.com/_/node
[_/traefik]: https://hub.docker.com/_/traefik

| Container | Versions | Service name | Image | Enabled by default |
| --------- | -------- | ------------ | ----- | ------------------ |
| [Nginx](containers/nginx.md)         | 1.13, 1.12         | nginx     | [wodby/drupal-nginx]   | ✓ |
| [Apache](containers/apache.md)       | 2.4                | apache    | [wodby/drupal-apache]  |   |
| [Drupal](containers/drupal.md)       | 8, 7, 6            | php       | [wodby/drupal]         | ✓ |
| [PHP](containers/php.md)             | 7.1, 7.0, 5.6, 5.3 | php       | [wodby/drupal-php]     |   |
| [MariaDB](containers/mariadb.md)     | 10.1               | mariadb   | [wodby/mariadb]        | ✓ |
| [Redis](containers/redis.md)         | 3.2                | redis     | [wodby/redis]          |   |
| [Varnish](containers/varnish.md)     | 4.1                | varnish   | [wodby/drupal-varnish] |   |
| [Solr](containers/solr.md)           | 6.6-6.3, 5.5, 5.4  | solr      | [wodby/drupal-solr]    |   |
| [Node.js](containers/nodejs.md)      | 1.0                | nodejs    | [wodby/drupal-node]    |   |
| [Memcached](containers/memcached.md) | 1.4                | memcached | [wodby/memcached]      |   |
| [Rsyslog](containers/rsyslog)        | latest             | rsyslog   | [wodby/rsyslog]        |   |
| [AthenaPDF](containers/athenapdf.md) | latest             | athenapdf | [athenapdf-service]    |   |
| Mailhog                              | latest             | mailhog   | [mailhog]              | ✓ |
| Adminer                              | 4.3                | adminer   | [wodby/adminer]        |   |
| phpMyAdmin                           | latest             | pma       | [phpmyadmin]           |   |
| Node                                 | latest             | node      | [_/node]               |   |
| Portainer                            | latest             | portainer | [portainer]            | ✓ |
| Traefik                              | latest             | traefik   | [_/traefik]            | ✓ |

Supported Drupal versions: 6, 7, 8.

## Requirements

* Install Docker ([Linux](https://docs.docker.com/engine/installation), [Docker for Mac](https://docs.docker.com/engine/installation/mac) or [Docker for Windows (10+ Pro)](https://docs.docker.com/engine/installation/windows))
* For Linux additionally install [docker compose](https://docs.docker.com/compose/install)

## Must know before you start

1. **(!!!) You will lose MariaDB data** if you run `docker-compose down`. Instead use `docker-compose stop` to stop containers. Alternatively, you can use a manual volume for mariadb data (see compose file), this way your data will always persist 
2. To avoid potential problems with permissions between your host and containers please follow [these instructions](permissions.md)
3. _For macOS users_: Out of box Docker for Mac volumes has [poor performance](https://github.com/Wodby/docker4drupal/issues/4). However there's a workaround based on [docker-sync project](https://github.com/EugenMayer/docker-sync/), read instructions [here](macos.md)

## Usage 

There 2 options how to use docker4drupal – you can either run [vanilla](https://en.wikipedia.org/wiki/Vanilla_software) Drupal from the image or mount your own Drupal codebase:

### 1. Run Vanilla Drupal from Image (default)

1. Download [docker-compose.yml file](https://github.com/wodby/docker4drupal/blob/master/docker-compose.yml)
2. Optional: update _php_ and _nginx_ images tags if you want to run Drupal 6 or 7 (by default Drupal 8)
3. Run containers: `docker-compose up -d` 
4. Wait a few seconds for containers initialization 
5. That's it! Proceed with Drupal installation at [http://drupal.docker.localhost:8000](http://drupal.docker.localhost:8000). Default database user, password and database name are all `drupal`, database host is `mariadb`
6. You can see status of your containers and their logs via portainer: [http://portainer.drupal.docker.localhost:8000](http://portainer.drupal.docker.localhost:8000)

### 2. Mount my Drupal Codebase

0. Read [must know before you start](#must-know-before-you-start) 
1. Download [docker-compose.yml file](https://github.com/wodby/docker4drupal/blob/master/docker-compose.yml) to your Drupal project root
2. Replace php image from `wodby/drupal` (PHP + vanilla Drupal) to `wodby/drupal-php` (just PHP)
3. Depending on your Drupal version use appropriate tags for _php_ and _nginx_ images
4. Update _nginx_ and _php_ volumes to `- ./:/var/www/html` to mount your codebase
4. Update `NGINX_SERVER_ROOT` (or `APACHE_SERVER_ROOT`) to `/var/www/html` unless your project is based on [composer template](https://github.com/drupal-composer/drupal-project)
5. Ensure your settings.php uses the same credentials as _mariadb_ service 
6. Optional: [import existing database](containers/mariadb.md#import-existing-database)
7. Optional: uncomment lines in the compose file to run _redis_, _solr_, etc
8. Optional: [configure domains](domains.md)
9. Run containers: `docker-compose up -d`
10. That's it! Your drupal website should be up and running at [http://drupal.docker.localhost:8000](http://drupal.docker.localhost:8000). If you need to run multiple projects simultaneously see [this article](multiple-projects.md)
11. You can see status of your containers and their logs via portainer: [http://portainer.drupal.docker.localhost:8000](http://portainer.drupal.docker.localhost:8000)

You can stop containers by executing:
```bash
docker-compose stop
```

Feel free to adjust volumes and ports in the compose file for your convenience. Also, read [how to access containers](access.md) and [how to get logs](logs.md)

## Status

We're actively working on these instructions and containers. More options will be added soon. If you have a feature request or found a bug please [submit an issue on GitHub](https://github.com/wodby/docker4drupal/issues/new) or [![Wodby Slack](https://www.google.com/s2/favicons?domain=www.slack.com) join us on Slack](https://slack.wodby.com/)

We update containers from time to time by releasing new images (stability tags change).

## License

This project is licensed under the MIT open source license.
