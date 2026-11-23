# Docker-based Drupal stack

[![Build Status](https://github.com/wodby/docker4drupal/workflows/Run%20tests/badge.svg)](https://github.com/wodby/docker4drupal/actions)

## Introduction

Docker4Drupal is a set of docker images optimized for Drupal. Use
`compose.yml` file from the [latest stable release](https://github.com/wodby/docker4drupal/releases) to spin up local environment on Linux, Mac OS X and Windows.

* Read the docs on [**how to use**](https://wodby.com/docs/1.0/stacks/drupal/local#usage)
* Deploy to production with the [Drupal stack on Wodby](https://wodby.com/deploy-drupal)
* Ask questions on [Discord](http://discord.wodby.com/)
* Ask questions on [Slack](http://slack.wodby.com/)
* Follow [@wodbycloud](https://twitter.com/wodbycloud) for future announcements

## Stack

The Drupal stack consists of the following containers:

| Container             | Versions                | Image                                     | Enabled by default |
|-----------------------|-------------------------|-------------------------------------------|--------------------|
| [Nginx]               | 1.31, 1.30              | [wodby/nginx]                             | ✓                  |
| [Apache]              | 2.4                     | [wodby/apache]                            |                    |
| Drupal CMS            | 2                       | [wodby/drupal-cms]                        | ✓                  |
| Vanilla Drupal        | 11, 10                  | [wodby/drupal]                            |                    |
| [PHP]                 | 8.5, 8.4, 8.3, 8.2      | [wodby/drupal-php]                        |                    |
| Crond                 |                         | [wodby/drupal-php]                        | ✓                  |
| [MariaDB]             | 12.3, 11.8, 11.4, 10.11, 10.6 | [wodby/mariadb]                           | ✓                  |
| [PostgreSQL]          | 18, 17, 16, 15, 14      | [wodby/postgres]                          |                    |
| [Valkey]              | 9.1, 9.0, 8.1, 8.0, 7   | [wodby/valkey]                            |                    |
| [Redis]               | 8.6, 8.4, 8.2, 7.4      | [wodby/redis]                             |                    |
| [Memcached]           | 1.6                     | [wodby/memcached]                         |                    |
| Vinyl ([Varnish])     | 9.1, 6.0                | [wodby/vinyl]                             |                    |
| [Node.js]             | 26, 24, 22              | [wodby/node]                              |                    |
| [Solr]                | 9                       | [wodby/solr]                              |                    |
| Zookeeper             | 3                       | [wodby/zookeeper]                         |                    |
| OpenSearch            | 2                       | [opensearchproject/opensearch]            |                    |
| OpenSearch Dashboards | 2                       | [opensearchproject/opensearch-dashboards] |                    |
| [OpenSMTPD]           | 7                       | [wodby/opensmtpd]                         |                    |
| Mailpit               | latest                  | [axllent/mailpit]                         | ✓                  |
| Gotenberg             | latest                  | [gotenberg/gotenberg]                     |                    |
| [Rsyslog]             | latest                  | [wodby/rsyslog]                           |                    |
| [Webgrind]            | 1                       | [wodby/webgrind]                          |                    |
| [Xhprof viewer]       | latest                  | [wodby/xhprof]                            |                    |
| Adminer               | 6                       | [wodby/adminer]                           |                    |
| phpMyAdmin            | latest                  | [phpmyadmin/phpmyadmin]                   |                    |
| Selenium chrome       | 3.141                   | [selenium/standalone-chrome]              |                    |
| Traefik               | latest                  | [_/traefik]                               | ✓                  |

## Documentation

Full documentation is available at https://wodby.com/docs/1.0/stacks/drupal/local.

## Image tags

Wodby images that package upstream software use `[VERSION]-r[N]` tags, for example
`wodby/mariadb:11.4-r0`. `11.4` selects the MariaDB version line and `r0` identifies
the Wodby image revision. Revisions include application updates and image changes;
review the image release notes before upgrading because the revision number does
not indicate compatibility.

Major/minor tags share a revision counter per image repository. Full-version tags,
such as `11.4.2-r0`, start at `r0` again for each exact upstream version. Matching
Git tags identify the source commit for each published revision. Development
variants retain their qualifier, for example `8.5-dev-r0`.

Use the versioned image tags supplied in `.env` instead of floating tags such as
`latest`. Previously published tags remain available. Wodby software such as Backup
uses semantic product versions, and third-party images follow their own tag formats.
See the [image revision policy](https://github.com/wodby/images#image-revisions)
for details.

## Maintenance

We regularly update images used in this stack and release them together, see [releases page](https://github.com/wodby/docker4drupal/releases) for full changelog and update instructions. Most of routine updates for images and this project performed by [the bot](https://github.com/wodbot) via scripts located at [wodby/images](https://github.com/wodby/images).

## Deploy to production

Docker4Drupal is for local development with Docker Compose. To run the same stack in production, use the [Drupal stack on Wodby](https://wodby.com/deploy-drupal).

It runs your Composer-based Drupal repository on Kubernetes with the same `wodby/drupal-php` image you use locally, behind Nginx, with MariaDB or PostgreSQL, Valkey, Solr, and Vinyl (Varnish) as optional services. You choose where it runs: Wodby Cloud, a Kubernetes cluster in your own cloud account, or a single server of your own.

* Start from the Drupal CMS or Vanilla Drupal boilerplate, or connect your own repository
* Database, file path, and trusted host settings are generated from the services you link
* CI/CD and backups are built in, and Drush cron runs on a schedule
* Cache rebuild, one-time login link, and database updates are actions you start from the dashboard
* A free plan is available, including on a server of your own

Read the [Drupal stack guide](https://wodby.com/docs/2.0/stacks/catalog/drupal/), or see [Drupal hosting on Wodby](https://wodby.com/drupal-hosting) and [pricing](https://wodby.com/pricing).

## Other Docker4x projects

* [docker4php](https://github.com/wodby/docker4php)
* [docker4laravel](https://github.com/wodby/docker4laravel)
* [docker4wordpress](https://github.com/wodby/docker4wordpress)
* [docker4ruby](https://github.com/wodby/docker4ruby)
* [docker4python](https://github.com/wodby/docker4python)

## License

This project is licensed under the MIT open source license.

[Apache]: https://wodby.com/docs/1.0/stacks/drupal/containers#apache

[Drupal CMS]: https://wodby.com/docs/1.0/stacks/drupal/containers#php

[Vanilla Drupal]: https://wodby.com/docs/1.0/stacks/drupal/containers#php

[MariaDB]: https://wodby.com/docs/1.0/stacks/drupal/containers#mariadb

[Memcached]: https://wodby.com/docs/1.0/stacks/drupal/containers#memcached

[Nginx]: https://wodby.com/docs/1.0/stacks/drupal/containers#nginx

[Node.js]: https://wodby.com/docs/1.0/stacks/drupal/containers#nodejs

[OpenSMTPD]: https://wodby.com/docs/1.0/stacks/drupal/containers#opensmtpd

[PHP]: https://wodby.com/docs/1.0/stacks/drupal/containers#php

[PostgreSQL]: https://wodby.com/docs/1.0/stacks/drupal/containers#postgresql

[Redis]: https://wodby.com/docs/1.0/stacks/drupal/containers#redis

[Valkey]: https://wodby.com/docs/1.0/stacks/drupal/containers#valkey

[Rsyslog]: https://wodby.com/docs/1.0/stacks/drupal/containers#rsyslog

[Solr]: https://wodby.com/docs/1.0/stacks/drupal/containers#solr

[Varnish]: https://wodby.com/docs/1.0/stacks/drupal/containers#varnish

[Webgrind]: https://wodby.com/docs/1.0/stacks/drupal/containers#webgrind

[XHProf viewer]: https://wodby.com/docs/1.0/stacks/php/containers#xhprof-viewer

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

[wodby/vinyl]: https://github.com/wodby/vinyl

[wodby/webgrind]: https://hub.docker.com/r/wodby/webgrind

[wodby/xhprof]: https://hub.docker.com/r/wodby/xhprof

[wodby/zookeeper]: https://hub.docker.com/r/wodby/zookeeper

[opensearchproject/opensearch]: https://hub.docker.com/r/opensearchproject/opensearch

[opensearchproject/opensearch-dashboards]: https://hub.docker.com/r/opensearchproject/opensearch-dashboards
