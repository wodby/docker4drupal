# Docker-based Drupal environment for local development

Use this Docker compose file to spin up local environment for Drupal with a *native Docker app* on Linux, Mac OS X and Windows.

Join us on [Slack](http://slack.wodby.com) to ask any questions about docker4drupal.  

Docker4Drupal is designed to be used for local development, if you're looking for a dev/staging/production solution consistent with Docker4Drupal check out [Wodby](https://wodby.com). 

---

* [Overview](#overview)
* [Requirements](#requirements)
* [Usage](#usage)
* [Containers](#containers)
* [Multiple projects](#multiple-projects)
* [CI/CD](#cicd)
* [Docroot in subdirectory](#docroot-in-subdirectory)
* [Logs](#logs)
* [Status](#status)
* [Performance on macOS](#performance-on-macos)
* [Known Issues](#known-issues)
* [License](#license)

## Overview

The Drupal bundle consist of the following containers:

| Container | Service name | Image | Public Port | Enabled by default |
| --------- | ------------ | ----- | ----------- | ------------------ |
| [Nginx](#nginx) | nginx | [wodby/drupal-nginx](https://hub.docker.com/r/wodby/drupal-nginx/) | 8000 | ✓ |
| [PHP 7 / 5.6](#php) | php | [wodby/drupal-php](https://hub.docker.com/r/wodby/drupal-php/) |  | ✓ |
| [MariaDB](#mariadb) | mariadb | [wodby/drupal-mariadb](https://hub.docker.com/r/wodby/drupal-mariadb/) | | ✓ |
| [phpMyAdmin](#phpmyadmin) | pma | [phpmyadmin/phpmyadmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin) | 8001 | ✓ |
| [Mailhog](#mailhog) | mailhog | [mailhog/mailhog](https://hub.docker.com/r/mailhog/mailhog) | 8002 | ✓ |
| [Redis](#redis) | redis | [redis/redis](https://hub.docker.com/_/redis) |||
| [Memcached](#memcached) | memcached | [_/memcached](https://hub.docker.com/_/memcached/) |||
| [Solr](#apache-solr) | solr | [wodby/solr](https://hub.docker.com/r/wodby/solr) | 8003 ||
| [Varnish](#varnish) | varnish | [wodby/drupal-varnish](https://hub.docker.com/r/wodby/drupal-varnish) | 8004 ||

PHP, Nginx, MariaDB and Varnish configs are optimized to be used with Drupal. We regularly update this bundle with performance improvements, bug fixes and newer version of Nginx/PHP/MariaDB.

__All containers' images used in the bundle are either official or based on official with optimization for Drupal.__

Supported Drupal versions: 7 and 8

Supported PHP versions: 7.0.x and 5.6.x.

## Requirements

Install docker for [Linux](https://docs.docker.com/engine/installation), [macOS (OS X)](https://docs.docker.com/engine/installation/mac) or [Windows (10+ Pro)](https://docs.docker.com/engine/installation/windows). For Mac and Windows make sure you're installing native docker app version 1.12+, not docker toolbox. For Linux additionally install [docker compose](https://docs.docker.com/compose/install)

## Usage 

Feel free to adjust volumes and ports in the compose file for your convenience.

1\. Download `docker-compose.yml` file from this repository and put it to your Drupal project codebase (you might want to add docker-compose.yml to .gitignore).

2\. Mount your codebase diretory (`./` by default) to PHP container (Nginx uses volumes from PHP). MariaDB volume is defined in its Dockerfile and will be handled by Docker.

**For macOS users**: By default Docker has a [very poor performance](https://github.com/Wodby/docker4drupal/issues/4) on macOS (OS X). However there's a workaround based on [docker-sync project](https://github.com/EugenMayer/docker-sync/), read instructions [here](#performance-on-macos). 

**For Linux users**: fix permissions for your files directory with:
```bash
$ sudo chgrp -R 82 sites/default/files
$ sudo chmod -R 775 sites/default/files
```

3\. Choose Drupal version by modifying the following environment variable (could be 7 or 8) in the compose file:
```yml
DRUPAL_VERSION: 8
```

4\. Choose PHP version by modifying the name of the image:
```yml
image: wodby/drupal-php:7.0 # Allowed: 7.0, 5.6
```

5\. Update database credentials in your settings.php file:
```
database: drupal
username: drupal
password: drupal
host: mariadb
```

6\. Optional: [import existing database](#import-existing-database)

7\. If you need to deploy one of the optional containers ([Redis](#redis), [Memcached](#memcached), [Apache Solr](#apache-solr)) uncomment the corresponding lines in the compose file.

8\. Now, let's run the compose file. It will download the images and run the containers:
```bash
$ docker-compose up -d
```

9\. Make sure all containers are running by executing:

```bash
$ docker-compose ps
```

10\. That's it! You drupal website should be up and running at http://localhost:8000.

## Containers

### Stopping containers

```bash
$ docker-compose stop
```

IMPORTANT: do not use `docker-compose down` or you will lose data in your MariaDB volume.

### Accessing containers

You can connect to any container by executing the following command:
```bash
$ docker-compose exec php sh
```

Replace `php` with the name of your service (e.g. `mariadb`, `nginx`, etc).

### Nginx

Nginx is being used as a web server. Nginx is pre-configured to be used with Drupal 7 and 8.

### PHP

PHP is used with Nginx via PHP-FPM. Currently PHP version 5.6 and 7 are provided. Check out [the instructions (step 5)](#instructions) to learn how to switch the version.

#### Drush

PHP container has installed drush. When running drush make sure to open the shell as user 82 (www-data) to avoid access problems in the web server, which is running as user 82, too:
```bash
$ docker-compose exec --user 82 php drush
```

Also, you can use preconfigured drush alias @dev:
```bash
$ docker-compose exec --user 82 php drush @dev
```

#### Composer

PHP container has installed composer. Example:
```bash
$ docker-compose exec --user 82 php composer update
```

#### Drupal Console

PHP container has installed drupal console. Example:
```bash
$ docker-compose exec --user 82 php drupal list
```

#### Xdebug

If you want to use Xdebug, uncomment this line to enable it in the compose file before starting containers:
```yml
PHP_XDEBUG_ENABLED: 1       # Comment out to disable (default).
```

If you would like to autostart xdebug, uncomment this line:
```yml
PHP_XDEBUG_AUTOSTART: 1     # Comment out to disable (default).
```

#### Xdebug on Mac OS X

There are two more things that need to be done on Mac OS X in order to have Xdebug working. Uncomment `PHP_XDEBUG_ENABLED` to enable Xdebug and uncomment the following two lines:

```yml
PHP_XDEBUG_REMOTE_CONNECT_BACK: 0         # Disabled for remote.host to work (enabled by default)
PHP_XDEBUG_REMOTE_HOST: "10.254.254.254"  # Setting the host (localhost by default)
```

It is also needed to have localhost loopback alias with IP from above. You need this only once and that settings stays active until logout or restart.

```bash
sudo ifconfig lo0 alias 10.254.254.254
```

For more details see the issue with [Xdebug in Mac OS](https://github.com/Wodby/drupal-php/issues/1).

### MariaDB

MariaDB uses a persistent volume defined in Dockerfile. 

IMPORTANT: Do not use `docker-compose down` command because it will purge MariaDB volume. Instead use `docker-compose stop`. If you restart Docker you WILL NOT lose your MariaDB data. 

#### Configuring

Many configuration options can be passed as flags without adjusting a cnf file. See example in the compose file:
```bash
#    command: --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
```

#### Import existing database

if you want to import your database, uncomment the following line in the compose file:
```yml
#      - ./mariadb-init:/docker-entrypoint-initdb.d # Place init .sql file(s) here
```

Create the volume directory `./mariadb-init` in the same directory as the compose file and put there your SQL file(s). All SQL files will be automatically imported once MariaDB container has started.

#### Export

Exporting all databases:
```bash
docker-compose exec mariadb sh -c 'exec mysqldump --all-databases -uroot -p"root-password"' > databases.sql
```

Exporting a specific database:
```bash
docker-compose exec mariadb sh -c 'exec mysqldump -uroot -p"root-password" my-db' > my-db.sql
```

### Redis

To spin up a container with Redis cache and use it as a default cache storage follow these steps:

1. Uncomment lines with redis service definition in the compose file.
2. Download and install [redis module](https://www.drupal.org/project/redis)
3. Add the following lines to the settings.php file:

```php
$conf['redis_client_host'] = 'redis';
$conf['redis_client_interface'] = 'PhpRedis';
$conf['lock_inc'] = $contrib_path . '/redis/redis.lock.inc';
$conf['path_inc'] = $contrib_path . '/redis/redis.path.inc';
$conf['cache_backends'][] = 'sites/all/modules/redis/redis.autoload.inc';
$conf['cache_default_class'] = 'Redis_Cache';
$conf['cache_class_cache_form'] = 'DrupalDatabaseCache';
```

### Memcached

To spin up a container with Memcached and use it as a default cache storage follow these steps:

1. Uncomment lines with memcached service definition in the compose file.
2. Download and install [memcache module](https://www.drupal.org/project/memcache)
3. Add the following lines to the settings.php file:

```php
$conf['cache_backends'][] = 'sites/all/modules/memcache/memcache.inc';
$conf['lock_inc'] = 'sites/all/modules/memcache/memcache-lock.inc';
$conf['memcache_stampede_protection'] = TRUE;
$conf['cache_default_class'] = 'MemCacheDrupal';
$conf['cache_class_cache_form'] = 'DrupalDatabaseCache';
$conf['memcache_servers'] = array('memcached:11211' => 'default');
```

### Memcached Admin

To spin up a container with the Memcached Admin User interface uncomment to memcached-admin service definition.
To get started visit http://localhost:8006/index.php

### Mailhog

By default, container with mailhog included in the bundle. It will catch all email sent from the PHP container. You can view emails by visiting its admin UI on localhost:8002.

### phpMyAdmin

By default, container with phpMyAdmin included in the bundle. You can access it by localhost:8001

### Apache Solr

To spin up a container with Apache Solr search engine uncomment lines with solr service definition in the compose file. There two versions available: `5.5` and `6.3`. 

Solr admin UI can be accessed by `localhost:8003`. Solr container has a persistent volume defined in Dockerfile, so your data won't be lost if you stop the container. Solr cores can be found under `/opt/solr/server/solr`.

#### Solr commands

The following commands are available inside of the container:

Create core
```bash
solr-create-core core1
```
Create pre-configured core for Drupal 7 Search API Solr module (available only in 5.5 version)
```
solr-create-core core2 drupal7
```
Create pre-configured core for Drupal 8 Search API Solr module  (available only in 5.5 version)
```
solr-create-core core2 drupal8
```
Delete core
```bash
solr-delete-core core1
```
Reload core
```bash
solr-reload-core core1
```

#### Integration with Search API Solr module

Drupal 8 example:

1. Create pre-configured solr core (available only for v5.5) `docker-compose solr exec solr-create-core my-core drupal8`
2. Download and enable [Search API Solr module](https://www.drupal.org/project/search_api_solr)
3. Open module configuration page and add a new search server
4. Choose Solr as a backend and _Standard_ Solr Connector
5. Specify `solr` as a Solr host, `8983` as a port, `/solr` as a solr path and your core name (`my-core` from step 1)
6. That's it! Now Drupal should be connected to our Solr backend. Solr admin UI is available by `localhost:8003` 

### Varnish

To spin up a container with Varnish uncomment lines with varnish service definition in the compose file. Use the port specified in the compose file to access your website via Varnish.

## Multiple projects

To use D4D with multiple projects simply adjust the ports in the compose file, e.g. instead of ports 8000, 8001, 8002 you can use 7000, 7001, 7002.

## CI/CD

Use D4D containers as your testing environment in CI/CD workflow:
* [CircleCI example](https://blog.wodby.com/continuous-integration-and-delivery-drupal-docker-circleci-192c6ac97087#.gh8sggeze)
* [Jenkins example](https://blog.wodby.com/drupal-8-ci-cd-with-jenkins-part-1-integration-eabd0f5c4f75#.obnyfv84i)

## Docroot in subdirectory

If your docroot located in a subdirectory use options `PHP_DOCROOT` and `NGINX_DOCROOT` to specify the path (relative path inside the /var/www/html/ directory) for PHP and Nginx containers.

## Logs

To get logs from a container simply run (skip the last param to get logs form all the containers):
```
$ docker-compose logs [service]
```

Example: real-time logs of the PHP container:
```
$ docker-compose logs -f php
```

## Status

We're actively working on this instructions and containers. More options will be added soon. If you have a feature request or found a bug please submit an issue.

We update containers from time to time, to get the latest changes simply run again:
```
$ docker-compose up -d
```

## Performance on macOS

To fix Docker [poor performance](https://github.com/Wodby/docker4drupal/issues/4) on macOS (OSX) use the following workaround. The workaround is based on [docker-sync project](https://github.com/EugenMayer/docker-sync/). The core idea is to replace a standard slow volume with a file synchronizer tool like unison (used by default) or rsync.

### Installation

```
gem install docker-sync
brew install fswatch
```

### Usage

1. Uncomment _d4d-unison-sync_ volume definition in your compose file
2. Replace volume for _php_ container to _d4d-unison-sync_ (uncomment and delete the current one)
3. Start the synchronization with `docker-sync start` and let docker-sync run in the background
4. In a new shell run after you started docker-sync `docker-compose up -d`

Alternatively to docker-sync start you can do it all in one step

run `docker-sync-stack start` to start sync services and docker-compose at the same time

Now when you change your code and it will all end up in php and nginx containers.

## Known Issues

### Windows permissions problems
https://github.com/Wodby/docker4drupal/issues/35#issuecomment-253806588

### Windows interactive mode isn't supported
https://github.com/Wodby/docker4drupal/issues/41#issuecomment-254051955

### Xdebug on OS X
https://github.com/Wodby/drupal-php/issues/1

### Drupal Console issues
https://github.com/Wodby/docker4drupal/issues/49

### Site in a subdirectory
https://github.com/Wodby/drupal-php/issues/16
https://github.com/Wodby/docker4drupal/issues/58

## License

This project is licensed under the MIT open source license.
