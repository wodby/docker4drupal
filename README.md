# Docker-based Drupal stack

[![Build Status](https://travis-ci.org/wodby/docker4drupal.svg?branch=master)](https://travis-ci.org/wodby/docker4drupal)

## Introduction

Docker4Drupal is a set of docker images optimized for Drupal. Use `docker-compose.yml` file from the [latest stable release](https://github.com/wodby/docker4drupal/releases) to spin up local environment on Linux, Mac OS X and Windows. 

* Read the docs on [**how to use**](https://wodby.com/docs/stacks/drupal/local#usage)
* Follow [@wodbycloud](https://twitter.com/wodbycloud) for future announcements
* Join [community slack](https://slack.wodby.com) to ask questions

## Stack

The Drupal stack consist of the following containers:

| Container       | Versions                | Service name    | Image                              | Default |
| --------------- | ----------------------- | --------------- | ---------------------------------- | ------- |
| [Nginx]         | 1.15, 1.14              | `nginx`         | [wodby/nginx]                      | ✓       |
| [Apache]        | 2.4                     | `apache`        | [wodby/apache]                     |         |
| [Drupal]        | 8, 7                    | `php`           | [wodby/drupal]                     | ✓       |
| [PHP]           | 7.2, 7.1, 5.6           | `php`           | [wodby/drupal-php]                 |         |
| [MariaDB]       | 10.3, 10.2, 10.1        | `mariadb`       | [wodby/mariadb]                    | ✓       |
| [PostgreSQL]    | 10, 9.x                 | `postgres`      | [wodby/postgres]                   |         |
| [Redis]         | 5, 4                    | `redis`         | [wodby/redis]                      |         |
| [Varnish]       | 4.1                     | `varnish`       | [wodby/varnish]                    |         |
| [Node.js]       | 10, 8, 6                | `node`          | [wodby/node]                       |         |
| [Drupal node]   | 1.0                     | `drupal-node`   | [wodby/drupal-node]                |         |
| [Solr]          | 7.x, 6.6, 5.5, 5.4      | `solr`          | [wodby/solr]                       |         |
| [Elasticsearch] | 6.x, 5.6, 5.5, 5.4      | `elasticsearch` | [wodby/elasticsearch]              |         |
| [Kibana]        | 6.x, 5.6, 5.5, 5.4      | `kibana`        | [wodby/kibana]                     |         |
| [Memcached]     | 1                       | `memcached`     | [wodby/memcached]                  |         |
| [Webgrind]      | 1.5                     | `webgrind`      | [wodby/webgrind]                   |         |
| [Blackfire]     | latest                  | `blackfire`     | [blackfire/blackfire]              |         |
| [Rsyslog]       | latest                  | `rsyslog`       | [wodby/rsyslog]                    |         |
| [AthenaPDF]     | 2.10.0                  | `athenapdf`     | [arachnysdocker/athenapdf-service] |         |
| [Mailhog]       | latest                  | `mailhog`       | [mailhog/mailhog]                  | ✓       |
| [OpenSMTPD]     | 6.0                     | `opensmtpd`     | [wodby/opensmtpd]                  |         |
| Adminer         | 4.6                     | `adminer`       | [wodby/adminer]                    |         |
| phpMyAdmin      | latest                  | `pma`           | [phpmyadmin/phpmyadmin]            |         |
| Portainer       | latest                  | `portainer`     | [portainer/portainer]              | ✓       |
| Traefik         | latest                  | `traefik`       | [_/traefik]                        | ✓       |

Supported Drupal versions: 8 / 7

## Documentation

Full documentation is available at https://wodby.com/docs/stacks/drupal/local.

## Beyond local environment

Docker4Drupal is a project designed to help you spin up local environment with docker-compose. If you want to deploy a consistent stack with orchestrations to your own server, check out [Drupal stack](https://wodby.com/stacks/drupal) on Wodby ![](https://www.google.com/s2/favicons?domain=wodby.com).

## Maintenance

We regularly update images used in this stack and release them together, see [releases page](https://github.com/wodby/docker4drupal/releases) for full changelog and update instructions.  

## License

This project is licensed under the MIT open source license.

[Apache]: https://wodby.com/docs/stacks/drupal/containers#apache
[AthenaPDF]: https://wodby.com/docs/stacks/drupal/containers#athenapdf
[Blackfire]: https://wodby.com/docs/stacks/drupal/containers#blackfire
[Drupal node]: https://wodby.com/docs/stacks/drupal/containers#drupal-nodejs
[Drupal]: https://wodby.com/docs/stacks/drupal/containers#php
[Elasticsearch]: https://wodby.com/docs/stacks/elasticsearch
[Kibana]: https://wodby.com/docs/stacks/elasticsearch
[Mailhog]: https://wodby.com/docs/stacks/drupal/containers#mailhog
[MariaDB]: https://wodby.com/docs/stacks/drupal/containers#mariadb
[Memcached]: https://wodby.com/docs/stacks/drupal/containers#memcached
[Nginx]: https://wodby.com/docs/stacks/drupal/containers#nginx
[Node.js]: https://wodby.com/docs/stacks/drupal/containers#nodejs
[OpenSMTPD]: https://wodby.com/docs/stacks/drupal/containers#opensmtpd
[PHP]: https://wodby.com/docs/stacks/drupal/containers#php
[PostgreSQL]: https://wodby.com/docs/stacks/drupal/containers#postgresql
[Redis]: https://wodby.com/docs/stacks/drupal/containers#redis
[Rsyslog]: https://wodby.com/docs/stacks/drupal/containers#rsyslog
[Solr]: https://wodby.com/docs/stacks/drupal/containers#solr
[Varnish]: https://wodby.com/docs/stacks/drupal/containers#varnish
[Webgrind]: https://wodby.com/docs/stacks/drupal/containers#webgrind

[wodby/nginx]: https://github.com/wodby/nginx
[wodby/apache]: https://github.com/wodby/apache
[wodby/drupal]: https://github.com/wodby/drupal
[wodby/drupal-php]: https://github.com/wodby/drupal-php
[wodby/mariadb]: https://github.com/wodby/mariadb
[wodby/postgres]: https://github.com/wodby/postgres
[wodby/redis]: https://github.com/wodby/redis
[wodby/varnish]: https://github.com/wodby/varnish
[wodby/solr]: https://github.com/wodby/solr
[wodby/elasticsearch]: https://github.com/wodby/elasticsearch
[wodby/kibana]: https://github.com/wodby/kibana
[wodby/node]: https://github.com/wodby/node
[wodby/drupal-node]: https://github.com/wodby/drupal-node
[wodby/memcached]: https://github.com/wodby/memcached
[wodby/opensmtpd]: https://github.com/wodby/opensmtpd
[wodby/webgrind]: https://hub.docker.com/r/wodby/webgrind
[blackfire/blackfire]: https://hub.docker.com/r/blackfire/blackfire
[wodby/rsyslog]: https://hub.docker.com/r/wodby/rsyslog
[arachnysdocker/athenapdf-service]: https://hub.docker.com/r/arachnysdocker/athenapdf-service
[mailhog/mailhog]: https://hub.docker.com/r/mailhog/mailhog
[wodby/adminer]: https://hub.docker.com/r/wodby/adminer
[phpmyadmin/phpmyadmin]: https://hub.docker.com/r/phpmyadmin/phpmyadmin
[portainer/portainer]: https://hub.docker.com/r/portainer/portainer
[_/traefik]: https://hub.docker.com/_/traefik
