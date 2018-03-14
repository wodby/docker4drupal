# Docker-based Drupal stack

[![Build Status](https://travis-ci.org/wodby/docker4drupal.svg?branch=master)](https://travis-ci.org/wodby/docker4drupal)
[![Wodby Slack](http://slack.wodby.com/badge.svg)](http://slack.wodby.com)
[![Wodby Twitter](https://img.shields.io/twitter/follow/wodbyhq.svg?style=social&label=Follow)](https://twitter.com/wodbyhq)

## Introduction

Docker4Drupal is a set of docker images optimized for Drupal. Use `docker-compose.yml` file from the [latest stable release](https://github.com/wodby/docker4drupal/releases) to spin up local environment on Linux, Mac OS X and Windows. 

Read [**Getting Started**](http://wodby.com/stacks/drupal/docs/local/quick-start).

## Stack

[wodby/drupal-nginx]: https://github.com/wodby/drupal-nginx
[wodby/php-apache]: https://github.com/wodby/php-apache
[wodby/drupal]: https://github.com/wodby/drupal
[wodby/drupal-php]: https://github.com/wodby/drupal-php
[wodby/mariadb]: https://github.com/wodby/mariadb
[wodby/postgres]: https://github.com/wodby/postgres
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
[portainer/portainer]: https://hub.docker.com/r/portainer/portainer
[_/node]: https://hub.docker.com/_/node
[_/traefik]: https://hub.docker.com/_/traefik

The Drupal stack consist of the following containers:

| Container  | Versions           | Service name | Image                              | Enabled by default |
| ---------- | ------------------ | ------------ | ---------------------------------- | ------------------ |
| Nginx      | 1.13, 1.12         | `nginx`      | [wodby/drupal-nginx]               | ✓                  |
| Apache     | 2.4                | `apache`     | [wodby/php-apache]                 |                    |
| Drupal     | 8, 7, 6            | `php`        | [wodby/drupal]                     | ✓                  |
| PHP        | 7.1, 7.0, 5.6, 5.3 | `php`        | [wodby/drupal-php]                 |                    |
| MariaDB    | 10.2, 10.1         | `mariadb`    | [wodby/mariadb]                    | ✓                  |
| PostgreSQL | 10.1, 9.6          | `postgres`   | [wodby/postgres]                   |                    |
| Redis      | 4.0, 3.2           | `redis`      | [wodby/redis]                      |                    |
| Varnish    | 4.1                | `varnish`    | [wodby/drupal-varnish]             |                    |
| Solr       | 7.x, 6.x, 5.5, 5.4 | `solr`       | [wodby/drupal-solr]                |                    |
| Node.js    | 1.0                | `nodejs`     | [wodby/drupal-node]                |                    |
| Memcached  | 1.4                | `memcached`  | [wodby/memcached]                  |                    |
| Webgrind   | 1.5                | `webgrind`   | [wodby/webgrind]                   |                    |
| Blackfire  | latest             | `blackfire`  | [blackfire/blackfire]              |                    |
| Rsyslog    | latest             | `rsyslog`    | [wodby/rsyslog]                    |                    |
| AthenaPDF  | 2.10.0             | `athenapdf`  | [arachnysdocker/athenapdf-service] |                    |
| Mailhog    | latest             | `mailhog`    | [mailhog/mailhog]                  | ✓                  |
| Adminer    | 4.3                | `adminer`    | [wodby/adminer]                    |                    |
| phpMyAdmin | latest             | `pma`        | [phpmyadmin/phpmyadmin]            |                    |
| Node       | latest             | `node`       | [_/node]                           |                    |
| Portainer  | latest             | `portainer`  | [portainer/portainer]              | ✓                  |
| Traefik    | latest             | `traefik`    | [_/traefik]                        | ✓                  |

Supported Drupal versions: 8 / 7 / 6

## Documentation

Full documentation is available at https://wodby.com/stacks/drupal/docs/local.

## Deployment

Deploy consistent docker-based Drupal stack with orchestrations to your own server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://cloud.wodby.com/stackhub/ada51e9b-2204-45ee-8e49-a4151912a168/detail).

## License

This project is licensed under the MIT open source license.
