# Docker-based Drupal stack

[![Build Status](https://github.com/wodby/docker4drupal/workflows/Run%20tests/badge.svg)](https://github.com/wodby/docker4drupal/actions)

## Introduction

Docker4Drupal is a set of docker images optimized for Drupal. Use `compose.yml` file from the [latest stable release](https://github.com/wodby/docker4drupal/releases) to spin up local environment on Linux, Mac OS X and Windows. 

* Read the docs on [**how to use**](https://wodby.com/docs/stacks/drupal/local#usage)
* Ask questions on [Discord](http://discord.wodby.com/)
* Ask questions on [Slack](http://slack.wodby.com/)
* Follow [@wodbycloud](https://twitter.com/wodbycloud) for future announcements

## Stack

The Drupal stack consist of the following containers:

| Container       | Versions                    | Image                        | ARM64 support | Enabled by default |
|-----------------|-----------------------------|------------------------------|---------------|--------------------|
| [Nginx]         | 1.27, 1.26                  | [wodby/nginx]                | ✓             | ✓                  |
| [Apache]        | 2.4                         | [wodby/apache]               | ✓             |                    |
| [Drupal]        | 11, 10, 7                   | [wodby/drupal]               | ✓             | ✓                  |
| [PHP]           | 8.3, 8.2, 8.1               | [wodby/drupal-php]           | ✓             |                    |
| Crond           |                             | [wodby/drupal-php]           | ✓             | ✓                  |
| [MariaDB]       | 11, 10.11, 10.6, 10.5, 10.4 | [wodby/mariadb]              | ✓             | ✓                  |
| [PostgreSQL]    | 16, 15, 14, 13, 12          | [wodby/postgres]             | ✓             |                    |
| [Valkey]        | 7                           | [wodby/valkey]               | ✓             |                    |
| [Memcached]     | 1                           | [wodby/memcached]            |               |                    |
| [Varnish]       | 6.0                         | [wodby/varnish]              | ✓             |                    |
| [Node.js]       | 20, 18                      | [wodby/node]                 |               |                    |
| [Drupal node]   | 1.0                         | [wodby/drupal-node]          |               |                    |
| [Solr]          | 8, 7, 6, 5                  | [wodby/solr]                 |               |                    |
| Zookeeper       | 3.8                         | [zookeeper]                  | ✓             |                    |
| [Elasticsearch] | 7                           | [wodby/elasticsearch]        |               |                    |
| [Kibana]        | 7                           | [wodby/kibana]               |               |                    |
| [OpenSMTPD]     | 7                           | [wodby/opensmtpd]            | ✓             |                    |
| Mailpit         | latest                      | [axllent/mailpit]            | ✓             | ✓                  |
| Gotenberg       | latest                      | [gotenberg/gotenberg]        | ✓             |                    |
| [Rsyslog]       | latest                      | [wodby/rsyslog]              |               |                    |
| [Webgrind]      | 1                           | [wodby/webgrind]             | ✓             |                    |
| [Xhprof viewer] | latest                      | [wodby/xhprof]               | ✓             |                    |
| Adminer         | 4.6                         | [wodby/adminer]              | ✓             |                    |
| phpMyAdmin      | latest                      | [phpmyadmin/phpmyadmin]      |               |                    |
| Selenium chrome | 3.141                       | [selenium/standalone-chrome] |               |                    |
| Traefik         | latest                      | [_/traefik]                  | ✓             | ✓                  |
 
## Documentation

Full documentation is available at https://wodby.com/docs/stacks/drupal/local.

## Image's tags

Images' tags format is `[VERSION]-[STABILITY_TAG]` where:

`[VERSION]` is the _version of an application_ (without patch version) running in a container, e.g. `wodby/nginx:1.15-x.x.x` where Nginx version is `1.15` and `x.x.x` is a stability tag. For some images we include both major and minor version like PHP `7.2`, for others we include only major like Valkey `7`. 

`[STABILITY_TAG]` is the _version of an image_ that corresponds to a git tag of the image repository, e.g. `wodby/mariadb:10.2-3.3.8` has MariaDB `10.2` and stability tag [`3.3.8`](https://github.com/wodby/mariadb/releases/tag/3.3.8). New stability tags include patch updates for applications and image's fixes/improvements (new env vars, orchestration actions fixes, etc). Stability tag changes described in the corresponding a git tag description. Stability tags follow [semantic versioning](https://semver.org/).

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
[Drupal node]: https://wodby.com/docs/stacks/drupal/containers#drupal-nodejs
[Drupal]: https://wodby.com/docs/stacks/drupal/containers#php
[Elasticsearch]: https://wodby.com/docs/stacks/elasticsearch
[Kibana]: https://wodby.com/docs/stacks/elasticsearch
[MariaDB]: https://wodby.com/docs/stacks/drupal/containers#mariadb
[Memcached]: https://wodby.com/docs/stacks/drupal/containers#memcached
[Nginx]: https://wodby.com/docs/stacks/drupal/containers#nginx
[Node.js]: https://wodby.com/docs/stacks/drupal/containers#nodejs
[OpenSMTPD]: https://wodby.com/docs/stacks/drupal/containers#opensmtpd
[PHP]: https://wodby.com/docs/stacks/drupal/containers#php
[PostgreSQL]: https://wodby.com/docs/stacks/drupal/containers#postgresql
[Redis]: https://wodby.com/docs/stacks/drupal/containers#redis
[Valkey]: https://wodby.com/docs/stacks/valkey/containers#valkey
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
[wodby/drupal-node]: https://github.com/wodby/drupal-node
[wodby/drupal-php]: https://github.com/wodby/drupal-php
[wodby/drupal]: https://github.com/wodby/drupal
[wodby/elasticsearch]: https://github.com/wodby/elasticsearch
[wodby/kibana]: https://github.com/wodby/kibana
[wodby/mariadb]: https://github.com/wodby/mariadb
[wodby/memcached]: https://github.com/wodby/memcached
[wodby/nginx]: https://github.com/wodby/nginx
[wodby/node]: https://github.com/wodby/node
[wodby/opensmtpd]: https://github.com/wodby/opensmtpd
[wodby/postgres]: https://github.com/wodby/postgres
[wodby/valkey]: https://github.com/wodby/valkey
[wodby/rsyslog]: https://hub.docker.com/r/wodby/rsyslog
[wodby/solr]: https://github.com/wodby/solr
[wodby/varnish]: https://github.com/wodby/varnish
[wodby/webgrind]: https://hub.docker.com/r/wodby/webgrind
[wodby/xhprof]: https://hub.docker.com/r/wodby/xhprof
[zookeeper]: https://hub.docker.com/_/zookeeper
