# Docker-based Drupal stack

[![Build Status](https://travis-ci.org/wodby/docker4drupal.svg?branch=master)](https://travis-ci.org/wodby/docker4drupal)

## AADL Dev Install Steps
There are two web applications that will be installed to provide a local AADL development environment:
1. The AADL Drupal web site.
1. The AADL API Laravel web service.
### Installing the Drupal Web site
1. Download a recent database dump file from univac.aadl.org. Open a terminal window, change directory to the *docker4aadl* directory and enter the following scp command to copy the latest database backup from univac:   
	`scp it@univac.aadl.org:/mnt/backups/latest/aadlexport_*.sql.gz  mariadb-init/`
1. Copy domain aliases from etc_hosts file to host machine's /etc/hosts
1. Get Access Token from github for private AADL repositories
1. Run `docker-compose up` to create docker containers and to install the database backup.
1. Open terminal window in the aadldev_php container. Use the docker command:  
	`docker exec -it aadldev_php bash`
	1. Download drupal `cd /var/www/html/aadlorg && drush dl drupal --drupal-project-rename=web`
	1. Install modules `composer update`
1. In a browser, open `http://aadldev.test:8000/` and complete the Drupal install process.
    1. Select `standard` install profile
    1. Database connection info:
        * database: `drupal`
        * username: `drupal`
        * password: `drupal`
        * Advanced info host: `mariadb`  
          
    **Install the aadl theme from github**  
  	1. Use the following git clone command to get the latest code:  
		`git clone https://github.com/aadl/aadl.org-frontend.git`
  	1. Copy on top of existing themes directory
  	1. In the browser, navigate to the admin/appearance section and select the aadl theme as the Default
  	1. Rebuilt the drupal cache. Run `drush cr` from a terminal window connected to the aadldev_php container - from the root level for the web site `aadlorg/web/`   
1. Change path to '/../vendor/autoload.php' in aadlorg/web/autoload.php
### Installing the API
Open terminal window in the aadldev_php container  
1. Clone AADL API from github  
	`cd /var/www/html && git clone https://github.com/aadl/api.git`  
2. Install API  
	`cd /var/www/html/api %% composer install`

## Introduction

Docker4Drupal is a set of docker images optimized for Drupal. Use `docker-compose.yml` file from the [latest stable release](https://github.com/wodby/docker4drupal/releases) to spin up local environment on Linux, Mac OS X and Windows.

* Read the docs on [**how to use**](https://wodby.com/docs/stacks/drupal/local#usage)
* Ask questions on [Slack](http://slack.wodby.com/)
* Follow [@wodbycloud](https://twitter.com/wodbycloud) for future announcements

## Stack

The Drupal stack consist of the following containers:

| Container       | Versions               | Service name    | Image                              | Default |
| --------------  | ---------------------- | --------------- | ---------------------------------- | ------- |
| [Nginx]         | 1.19, 1.18             | `nginx`         | [wodby/nginx]                      | ✓       |
| [Apache]        | 2.4                    | `apache`        | [wodby/apache]                     |         |
| [Drupal]        | 9, 8, 7                | `php`           | [wodby/drupal]                     | ✓       |
| [PHP]           | 7.4, 7.3, 7.2          | `php`           | [wodby/drupal-php]                 |         |
| Crond           |                        | `crond`         | [wodby/drupal-php]                 | ✓       |
| [MariaDB]       | 10.5, 10.4, 10.3, 10.2 | `mariadb`       | [wodby/mariadb]                    | ✓       |
| [PostgreSQL]    | 12, 11, 10, 9.x        | `postgres`      | [wodby/postgres]                   |         |
| [Redis]         | 6, 5                   | `redis`         | [wodby/redis]                      |         |
| [Memcached]     | 1                      | `memcached`     | [wodby/memcached]                  |         |
| [Varnish]       | 6.0, 4.1               | `varnish`       | [wodby/varnish]                    |         |
| [Node.js]       | 14, 12, 10             | `node`          | [wodby/node]                       |         |
| [Drupal node]   | 1.0                    | `drupal-node`   | [wodby/drupal-node]                |         |
| [Solr]          | 8, 7, 6, 5             | `solr`          | [wodby/solr]                       |         |
| [Elasticsearch] | 7, 6                   | `elasticsearch` | [wodby/elasticsearch]              |         |
| [Kibana]        | 7, 6                   | `kibana`        | [wodby/kibana]                     |         |
| [OpenSMTPD]     | 6.0                    | `opensmtpd`     | [wodby/opensmtpd]                  |         |
| [Mailhog]       | latest                 | `mailhog`       | [mailhog/mailhog]                  | ✓       |
| [AthenaPDF]     | 2.10.0                 | `athenapdf`     | [arachnysdocker/athenapdf-service] |         |
| [Rsyslog]       | latest                 | `rsyslog`       | [wodby/rsyslog]                    |         |
| [Blackfire]     | latest                 | `blackfire`     | [blackfire/blackfire]              |         |
| [Webgrind]      | 1                      | `webgrind`      | [wodby/webgrind]                   |         |
| [Xhprof viewer] | latest                 | `xhprof`        | [wodby/xhprof]                     |         |
| Adminer         | 4.6                    | `adminer`       | [wodby/adminer]                    |         |
| phpMyAdmin      | latest                 | `pma`           | [phpmyadmin/phpmyadmin]            |         |
| Selenium chrome | 3.141                  | `chrome`        | [selenium/standalone-chrome]       |         |
| Portainer       | latest                 | `portainer`     | [portainer/portainer]              | ✓       |
| Traefik         | latest                 | `traefik`       | [_/traefik]                        | ✓       |

Supported Drupal versions: 9 / 8 / 7

## Documentation

Full documentation is available at https://wodby.com/docs/stacks/drupal/local.

## Images' tags

Images tags format is `[VERSION]-[STABILITY_TAG]` where:

`[VERSION]` is the _version of an application_ (without patch version) running in a container, e.g. `wodby/nginx:1.15-x.x.x` where Nginx version is `1.15` and `x.x.x` is a stability tag. For some images we include both major and minor version like PHP `7.2`, for others we include only major like Redis `5`.

`[STABILITY_TAG]` is the _version of an image_ that corresponds to a git tag of the image repository, e.g. `wodby/mariadb:10.2-3.3.8` has MariaDB `10.2` and stability tag [`3.3.8`](https://github.com/wodby/mariadb/releases/tag/3.3.8). New stability tags include patch updates for applications and image's fixes/improvements (new env vars, orchestration actions fixes, etc). Stability tag changes described in the corresponding a git tag description. Stability tags follow [semantic versioning](https://semver.org/).

We highly encourage to use images only with stability tags.

## Maintenance

We regularly update images used in this stack and release them together, see [releases page](https://github.com/wodby/docker4drupal/releases) for full changelog and update instructions. Most of routine updates for images and this project performed by [the bot](https://github.com/wodbot) via scripts located at [wodby/images](https://github.com/wodby/images).

## Beyond local environment

Docker4Drupal is a project designed to help you spin up local environment with docker-compose. If you want to deploy a consistent stack with orchestrations to your own server, check out [Drupal stack](https://wodby.com/stacks/drupal) on Wodby ![](https://www.google.com/s2/favicons?domain=wodby.com).

## Other Docker4x projects

* [docker4php](https://github.com/wodby/docker4php)
* [docker4wordpress](https://github.com/wodby/docker4wordpress)
* [docker4ruby](https://github.com/wodby/docker4ruby)
* [docker4python](https://github.com/wodby/docker4python)

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
[XHProf viewer]: https://wodby.com/docs/stacks/php/containers#xhprof-viewer

[_/traefik]: https://hub.docker.com/_/traefik
[arachnysdocker/athenapdf-service]: https://hub.docker.com/r/arachnysdocker/athenapdf-service
[blackfire/blackfire]: https://hub.docker.com/r/blackfire/blackfire
[mailhog/mailhog]: https://hub.docker.com/r/mailhog/mailhog
[phpmyadmin/phpmyadmin]: https://hub.docker.com/r/phpmyadmin/phpmyadmin
[portainer/portainer]: https://hub.docker.com/r/portainer/portainer
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
[wodby/redis]: https://github.com/wodby/redis
[wodby/rsyslog]: https://hub.docker.com/r/wodby/rsyslog
[wodby/solr]: https://github.com/wodby/solr
[wodby/varnish]: https://github.com/wodby/varnish
[wodby/webgrind]: https://hub.docker.com/r/wodby/webgrind
[wodby/xhprof]: https://hub.docker.com/r/wodby/xhprof
