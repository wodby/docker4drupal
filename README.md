# Docker-based Drupal environment for local development

[![Documentation Status](https://readthedocs.org/projects/docker4drupal/badge/?version=latest)](http://docs.docker4drupal.org)
[![Build Status](https://travis-ci.org/wodby/docker4drupal.svg?branch=master)](https://travis-ci.org/wodby/docker4drupal)

[![Wodby Slack](https://www.google.com/s2/favicons?domain=www.slack.com) Get help on Slack](https://slack.wodby.com/)

[![Wodby Twitter](https://twitter.com/favicon.ico) Follow us on Twitter to stay up to date](https://twitter.com/wodbyhq)

## Introduction

Docker4Drupal is a set of docker images optimized for local development with Drupal. Use docker-compose.yml file from this repository to spin up local environment on Linux, Mac OS X and Windows. 

Read [**Getting Started**](http://docs.docker4drupal.org/en/latest/).

## Bundle

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

The Drupal bundle consist of the following containers:

| Container | Versions | Service name | Image | Enabled by default |
| --------- | -------- | ------------ | ----- | ------------------ |
| Nginx      | 1.10               | nginx     | [wodby/drupal-nginx]    | ✓ |
| PHP        | 5.3, 5.6, 7.0, 7.1 | php       | [wodby/drupal-php]      | ✓ |
| MariaDB    | 10.1               | mariadb   | [wodby/mariadb]         | ✓ |
| Redis      | 3.2                | redis     | [wodby/redis]           |   |
| Varnish    | 4.1                | varnish   | [wodby/drupal-varnish]  |   |
| Solr       | 5.5, 6.3, 6.4      | solr      | [wodby/drupal-solr]     |   |
| Memcached  | 1.4                | memcached | [wodby/memcached]       |   |
| Mailhog    | latest             | mailhog   | [mailhog/mailhog]       | ✓ |
| phpMyAdmin | latest             | pma       | [phpmyadmin/phpmyadmin] |   |
| Node.js    | 7                  | node      | [_/node]                |   |
| Traefik    | latest             | traefik   | [_/traefik]             |   |

Supported Drupal versions: 6, 7, 8.

## Documentation

Full documentation is available at http://docs.docker4drupal.org/.

## Using in Production

Deploy docker-based infrastructure for Drupal to your own server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://wodby.com).

## License

This project is licensed under the MIT open source license.
