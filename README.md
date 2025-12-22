# Docker-based Drupal stack

[![Build Status](https://github.com/wodby/docker4drupal/workflows/Run%20tests/badge.svg)](https://github.com/wodby/docker4drupal/actions)

## Introduction

Docker4Drupal is a set of docker images optimized for Drupal. Use
`compose.yml` file from the [latest stable release](https://github.com/wodby/docker4drupal/releases) to spin up local environment on Linux, Mac OS X and Windows.

* Read the docs on [**how to use**](https://wodby.com/docs/stacks/drupal/local#usage)
* Ask questions on [Discord](http://discord.wodby.com/)
* Ask questions on [Slack](http://slack.wodby.com/)
* Follow [@wodbycloud](https://twitter.com/wodbycloud) for future announcements

## Stack

The Drupal stack consists of the following containers:

| Container             | Versions                | Image                                     | ARM64 support | Enabled by default |
|-----------------------|-------------------------|-------------------------------------------|---------------|--------------------|
| [Nginx]               | 1.29, 1.28              | [wodby/nginx]                             | ✓             | ✓                  |
| [Apache]              | 2.4                     | [wodby/apache]                            | ✓             |                    |
| Drupal CMS            | 1                       | [wodby/drupal-cms]                        | ✓             | ✓                  |
| Vanilla Drupal        | 11, 10                  | [wodby/drupal]                            | ✓             |                    |
| [PHP]                 | 8.5, 8.4, 8.3, 8.2, 8.1 | [wodby/drupal-php]                        | ✓             |                    |
| Crond                 |                         | [wodby/drupal-php]                        | ✓             | ✓                  |
| [MariaDB]             | 11.8, 11.4, 10.11, 10.6 | [wodby/mariadb]                           | ✓             | ✓                  |
| [PostgreSQL]          | 18, 17, 16, 15, 14      | [wodby/postgres]                          | ✓             |                    |
| [Valkey]              | 9.0, 8.1, 8.0, 7        | [wodby/valkey]                            | ✓             |                    |
| [Redis]               | 8.2, 8.0, 7.4           | [wodby/redis]                             | ✓             |                    |
| [Memcached]           | 1.6                     | [wodby/memcached]                         | ✓             |                    |
| [Varnish]             | 6.0                     | [wodby/varnish]                           | ✓             |                    |
| [Node.js]             | 24, 22, 20              | [wodby/node]                              | ✓             |                    |
| [Solr]                | 9                       | [wodby/solr]                              | ✓             |                    |
| Zookeeper             | 3                       | [wodby/zookeeper]                         | ✓             |                    |
| OpenSearch            | 2                       | [opensearchproject/opensearch]            | ✓             |                    |
| OpenSearch Dashboards | 2                       | [opensearchproject/opensearch-dashboards] | ✓             |                    |
| [OpenSMTPD]           | 7                       | [wodby/opensmtpd]                         | ✓             |                    |
| Mailpit               | latest                  | [axllent/mailpit]                         | ✓             | ✓                  |
| Gotenberg             | latest                  | [gotenberg/gotenberg]                     | ✓             |                    |
| [Rsyslog]             | latest                  | [wodby/rsyslog]                           | ✓             |                    |
| [Webgrind]            | 1                       | [wodby/webgrind]                          | ✓             |                    |
| [Xhprof viewer]       | latest                  | [wodby/xhprof]                            | ✓             |                    |
| Adminer               | 5                       | [wodby/adminer]                           | ✓             |                    |
| phpMyAdmin            | latest                  | [phpmyadmin/phpmyadmin]                   |               |                    |
| Selenium chrome       | 3.141                   | [selenium/standalone-chrome]              |               |                    |
| Traefik               | latest                  | [_/traefik]                               | ✓             | ✓                  |

## Documentation

Full documentation is available at https://wodby.com/docs/stacks/drupal/local.

## Image's tags

Images' tags format is `[VERSION]-[STABILITY_TAG]` where:

`[VERSION]` is the _version of an application_ (without patch version) running in a container, e.g.
`wodby/nginx:1.15-x.x.x` where Nginx version is `1.15` and
`x.x.x` is a stability tag. For some images we include both major and minor version like PHP
`7.2`, for others we include only major like Valkey `7`.

`[STABILITY_TAG]` is the _version of an image_ that corresponds to a git tag of the image repository, e.g.
`wodby/mariadb:10.2-3.3.8` has MariaDB `10.2` and stability tag [
`3.3.8`](https://github.com/wodby/mariadb/releases/tag/3.3.8). New stability tags include patch updates for applications and image's fixes/improvements (new env vars, orchestration actions fixes, etc). Stability tag changes described in the corresponding a git tag description. Stability tags follow [semantic versioning](https://semver.org/).

We highly encourage to use images only with stability tags.

## Maintenance

We regularly update images used in this stack and release them together, see [releases page](https://github.com/wodby/docker4drupal/releases) for full changelog and update instructions. Most of routine updates for images and this project performed by [the bot](https://github.com/wodbot) via scripts located at [wodby/images](https://github.com/wodby/images).

## Beyond local environment

Docker4Drupal is a project designed to help you spin up local environment with Docker Compose. If you want to deploy a consistent stack with orchestrations to your own server, check out [Drupal stack](https://wodby.com/stacks/drupal) on Wodby ![](https://www.google.com/s2/favicons?domain=wodby.com).

## Other Docker4x projects

* [docker4php](https://github.com/wodby/docker4php)
* [docker4laravel](https://github.com/wodby/docker4laravel)
* [docker4wordpress](https://github.com/wodby/docker4wordpress)
* [docker4ruby](https://github.com/wodby/docker4ruby)
* [docker4python](https://github.com/wodby/docker4python)

## License

This project is licensed under the MIT open source license.

[Apache]: https://wodby.com/docs/stacks/drupal/containers#apache

[Drupal CMS]: https://wodby.com/docs/stacks/drupal/containers#php

[Vanilla Drupal]: https://wodby.com/docs/stacks/drupal/containers#php

[MariaDB]: https://wodby.com/docs/stacks/drupal/containers#mariadb

[Memcached]: https://wodby.com/docs/stacks/drupal/containers#memcached

[Nginx]: https://wodby.com/docs/stacks/drupal/containers#nginx

[Node.js]: https://wodby.com/docs/stacks/drupal/containers#nodejs

[OpenSMTPD]: https://wodby.com/docs/stacks/drupal/containers#opensmtpd

[PHP]: https://wodby.com/docs/stacks/drupal/containers#php

[PostgreSQL]: https://wodby.com/docs/stacks/drupal/containers#postgresql

[Redis]: https://wodby.com/docs/stacks/drupal/containers#redis

[Valkey]: https://wodby.com/docs/stacks/drupal/containers#valkey

[Rsyslog]: https://wodby.com/docs/stacks/drupal/containers#rsyslog

[Solr]: https://wodby.com/docs/stacks/drupal/containers#solr

[Varnish]: https://wodby.com/docs/stacks/drupal/containers#varnish

[Webgrind]: https://wodby.com/docs/stacks/drupal/containers#webgrind

[XHProf viewer]: https://wodby.com/docs/stacks/php/containers#xhprof-viewer

[_/traefik]: https://hub.docker.com/_/traefik

[gotenberg/gotenberg]: https://hub.docker.com/r/gotenberg/gotenberg

[axllent/mailpit]: https://hub.docker.com/r/axllent/mailpit

[phpmyadmin/phpmyadmin]: https://hub.docker.com/r/phpmyadmin/phpmyadmin

[selenium/standalone-chrome]: https://hub.docker.com/r/selenium/standalone-chrome

[wodby/adminer]: https://hub.docker.com/r/wodby/adminer

[wodby/apache]: https://github.com/wodby/apache

[wodby/drupal-php]: https://github.com/wodby/drupal-php

[wodby/drupal]: https://github.com/wodby/drupal

[wodby/drupal-cms]: https://github.com/wodby/drupal-cms

[wodby/mariadb]: https://github.com/wodby/mariadb

[wodby/memcached]: https://github.com/wodby/memcached

[wodby/nginx]: https://github.com/wodby/nginx

[wodby/node]: https://github.com/wodby/node

[wodby/opensmtpd]: https://github.com/wodby/opensmtpd

[wodby/postgres]: https://github.com/wodby/postgres

[wodby/valkey]: https://github.com/wodby/valkey

[wodby/redis]: https://github.com/wodby/redis

[wodby/rsyslog]: https://hub.docker.com/r/wodby/rsyslog

[wodby/solr]: https://github.com/wodby/solr

[wodby/varnish]: https://github.com/wodby/varnish

[wodby/webgrind]: https://hub.docker.com/r/wodby/webgrind

[wodby/xhprof]: https://hub.docker.com/r/wodby/xhprof

[wodby/zookeeper]: https://hub.docker.com/r/wodby/zookeeper

[opensearchproject/opensearch]: https://hub.docker.com/r/opensearchproject/opensearch

[opensearchproject/opensearch-dashboards]: https://hub.docker.com/r/opensearchproject/opensearch-dashboards
