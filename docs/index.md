# Docker4Drupal Getting Started

Docker4Drupal is a set of docker containers optimized for Drupal. Use docker-compose.yml file from [docker4drupal repository](https://github.com/wodby/docker4drupal) to spin up local environment on Linux, Mac OS X and Windows. 

Docker4Drupal is designed to be used for local development, if you're looking for a production solution see [using in production](production.md).

## Overview

The Drupal stack consist of the following containers:

[wodby/drupal-nginx]: https://github.com/wodby/drupal-nginx
[wodby/php-apache]: https://github.com/wodby/php-apache
[wodby/drupal]: https://github.com/wodby/drupal
[wodby/drupal-php]: https://github.com/wodby/drupal-php
[wodby/mariadb]: https://github.com/wodby/mariadb
[wodby/redis]: https://github.com/wodby/redis
[wodby/drupal-varnish]: https://github.com/wodby/drupal-varnish
[wodby/drupal-solr]: https://github.com/wodby/drupal-solr
[wodby/drupal-node]: https://github.com/wodby/drupal-node
[wodby/memcached]: https://github.com/wodby/memcached
[wodby/webgrind]: https://hub.docker.com/r/wodby/webgrind
[blackfire/blackfire]: https://hub.docker.com/r/blackfire/blackfire
[wodby/rsyslog]: https://hub.docker.com/r/wodby/rsyslog
[arachnysdocker/athenapdf-service]: https://hub.docker.com/r/arachnysdocker/athenapdf-service
[mailhog/mailhog]: https://hub.docker.com/r/mailhog/mailhog
[wodby/adminer]: https://hub.docker.com/r/wodby/adminer
[phpmyadmin/phpmyadmin]: https://hub.docker.com/r/phpmyadmin/phpmyadmin
[portainer/portainer]: https://hub.docker.com/portainer/portainer
[_/node]: https://hub.docker.com/_/node
[_/traefik]: https://hub.docker.com/_/traefik
[Nginx]: containers/nginx.md
[Apache]: containers/apache.md
[PHP]: containers/php.md
[MariaDB]: containers/mariadb.md
[Redis]: containers/redis.md
[Varnish]: containers/varnish.md
[Solr]: containers/solr.md
[Node.js]: containers/nodejs.md
[Memcached]: containers/memcached.md
[Webgrind]: containers/webgrind.md
[Blackfire]: containers/blackfire.md
[Rsyslog]: containers/rsyslog.md
[AthenaPDF]: containers/athenapdf.md

| Container   | Versions           | Service name | Image                              | Enabled by default |
| ---------   | ------------------ | ------------ | ---------------------------------- | ------------------ |
| [Nginx]     | 1.13, 1.12         | nginx        | [wodby/drupal-nginx]               | ✓                  |
| [Apache]    | 2.4                | apache       | [wodby/php-apache]                 |                    |
| Drupal      | 8, 7, 6            | php          | [wodby/drupal]                     | ✓                  |
| [PHP]       | 7.1, 7.0, 5.6, 5.3 | php          | [wodby/drupal-php]                 |                    |
| [MariaDB]   | 10.1               | mariadb      | [wodby/mariadb]                    | ✓                  |
| [Redis]     | 3.2, 4.0           | redis        | [wodby/redis]                      |                    |
| [Varnish]   | 4.1                | varnish      | [wodby/drupal-varnish]             |                    |
| [Solr]      | 6.x, 5.5, 5.4      | solr         | [wodby/drupal-solr]                |                    |
| [Node.js]   | 1.0                | nodejs       | [wodby/drupal-node]                |                    |
| [Memcached] | 1.4                | memcached    | [wodby/memcached]                  |                    |
| [Webgrind]  | 1.5                | webgrind     | [wodby/webgrind]                   |                    |
| [Blackfire] | latest             | blackfire    | [blackfire/blackfire]              |                    |
| [Rsyslog]   | latest             | rsyslog      | [wodby/rsyslog]                    |                    |
| [AthenaPDF] | 2.10.0             | athenapdf    | [arachnysdocker/athenapdf-service] |                    |
| Mailhog     | latest             | mailhog      | [mailhog/mailhog]                  | ✓                  |
| Adminer     | 4.3                | adminer      | [wodby/adminer]                    |                    |
| phpMyAdmin  | latest             | pma          | [phpmyadmin/phpmyadmin]            |                    |
| Node        | latest             | node         | [_/node]                           |                    |
| Portainer   | latest             | portainer    | [portainer/portainer]              | ✓                  |
| Traefik     | latest             | traefik      | [_/traefik]                        | ✓                  |

Supported Drupal versions: 8 / 7 / 6

## Requirements

* Install Docker ([Linux](https://docs.docker.com/engine/installation), [Docker for Mac](https://docs.docker.com/engine/installation/mac) or [Docker for Windows (10+ Pro)](https://docs.docker.com/engine/installation/windows))
* For Linux additionally install [docker compose](https://docs.docker.com/compose/install)

## Must know before you start

1. **(!!!) You will lose MariaDB data** if you run `docker-compose down`. Instead use `docker-compose stop` to stop containers. Alternatively, you can use a manual volume for mariadb data (see compose file), this way your data will always persist 
2. To avoid potential problems with permissions between your host and containers please follow [these instructions](permissions.md)
3. _For macOS users_: Out of box Docker for Mac volumes has [poor performance](https://github.com/Wodby/docker4drupal/issues/4). However there are workarounds, read more [here](macos.md)
4. For better reliability we release images with stability tags (e.g. `wodby/drupal-php:7.1-X.X.X`) which correspond to git tags. We strongly recommend using images only with stability tags. 

## Usage 

There are 2 options how to use docker4drupal – you can either run [vanilla](https://en.wikipedia.org/wiki/Vanilla_software) Drupal from the image or mount your own Drupal codebase:

### 1. Run Vanilla Drupal from Image (default)

1. Download `docker-compose.yml` file from the [latest stable release](https://github.com/wodby/docker4drupal/releases)
2. Optional: update _php_ and _nginx_ images tags if you want to run Drupal 7 or 6 (by default Drupal 8)
3. Run containers: `docker-compose up -d` (it may take some time for them to initialize) 
4. [Configure domains](domains.md)
5. That's it! Proceed with Drupal installation at [http://drupal.docker.localhost:8000](http://drupal.docker.localhost:8000). Default database user, password and database name are all `drupal`, database host is `mariadb`
6. You can see status of your containers and their logs via portainer: [http://portainer.drupal.docker.localhost:8000](http://portainer.drupal.docker.localhost:8000)

### 2. Mount my Drupal Codebase

0. Read [must know before you start](#must-know-before-you-start) 
1. Download `docker-compose.yml` file from the [latest stable release](https://github.com/wodby/docker4drupal/releases) to your Drupal project root
2. Replace php image from `wodby/drupal` (PHP + vanilla Drupal) to `wodby/drupal-php` (just PHP)
3. Depending on your Drupal version use appropriate tags for _php_ and _nginx_ images
4. Update _nginx_ and _php_ volumes to `- ./:/var/www/html` to mount your codebase
4. Update `NGINX_SERVER_ROOT` (or `APACHE_SERVER_ROOT`) to `/var/www/html` unless your project is based on [composer template](https://github.com/drupal-composer/drupal-project)
5. Ensure your settings.php uses the same credentials as _mariadb_ service 
6. Optional: [import existing database](containers/mariadb.md#import-existing-database)
7. Optional: uncomment lines in the compose file to run _redis_, _solr_, etc
8. [Configure domains](domains.md) 
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
