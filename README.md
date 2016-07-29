# Docker-based environment for Drupal

Use this Docker compose file to spin up local environment for Drupal with a *native Docker app* on Linux, Mac OS X and Windows. 

* [Overview](#overview)
* [Instructions](#instructions)
* [Containers](#containers)
    * [Accessing containers](#accessing-containers)
    * [PHP](#php)
        * [Drush](#drush)
        * [Composer](#composer)
        * [Drupal Console](#drupal-console)
        * [Xdebug](#xdebug)    
    * [MariaDB](#mariadb)
        * [Import](#import)
        * [Export](#export)
    * [Redis](#redis)
    * [Memcached](#memcached)
    * [Mailhog](#mailhog)
    * [phpMyAdmin](#phpmyadmin)
    * [Apache Solr](#apache-solr)
* [Logs](#logs)
* [Status](#status)
* [Going beyond local machine](#going-beyond-local-machine)

## Overview

The Drupal bundle consist of the following containers:

| Container | Service name | Volume | Port | Enabled by default |
| --------- | ------------ | ------ | ---- | ------------------ |
| <a href="https://hub.docker.com/r/wodby/drupal-nginx/" target="_blank">Nginx</a> | nginx || 8000 | ✓ |
| <a href="https://hub.docker.com/r/wodby/drupal-php/" target="_blank">PHP 7, 5.6</a> | php | `./` || ✓ |
| <a href="https://hub.docker.com/r/wodby/drupal-mariadb/" target="_blank">MariaDB</a> | mariadb | `./docker-runtime/mariadb` || ✓ |
| <a href="https://hub.docker.com/r/phpmyadmin/phpmyadmin" target="_blank">phpMyAdmin</a> | pma || 8001 | ✓ |
| <a href="https://hub.docker.com/r/mailhog/mailhog" target="_blank">Mailhog</a> | mailhog || 8002 | ✓ |
| <a href="https://hub.docker.com/_/redis/" target="_blank">Redis</a> | redis ||||
| <a href="https://hub.docker.com/_/memcached/" target="_blank">Memcached</a> | memcached ||||
| <a href="https://hub.docker.com/_/solr" target="_blank">Apache Solr</a> | solr | `./docker-runtime/solr` | 8003 ||

PHP, Nginx and MariaDB configs are optimized to be used with Drupal. We regularly update this bundle with performance improvements, bug fixes and newer version of Nginx/PHP/MariaDB.

## Instructions 

__Feel free to adjust volumes and ports in the compose file for your convenience.__

Supported Drupal versions: 7 and 8

Supported PHP versions: 7.x and 5.6.x.

1\. Install docker for <a href="https://docs.docker.com/engine/installation/" target="_blank">Linux</a>, <a href="https://docs.docker.com/engine/installation/mac" target="_blank">Mac OS X</a> or <a href="https://docs.docker.com/engine/installation/windows" target="_blank">Windows</a>. __For Mac and Windows make sure you're installing native docker app version 1.12, not docker toolbox.__ 

For Linux additionally install <a href="https://docs.docker.com/compose/install/" target="_blank">docker compose</a>

2\. Download <a href="https://raw.githubusercontent.com/Wodby/drupal-compose/master/docker-compose.yml" target="_blank">the compose file</a> from this repository and put it to your Drupal project codebase (you might want to add docker-compose.yml to .gitignore). 

3\. Since containers <a href="https://docs.docker.com/engine/tutorials/dockervolumes/" target="_blank">do not have a permanent storage</a>, directories from the host machine (volumes) should be mounted: one with code of your Drupal project and another with database files. 

By default, the directory with the compose file (volume `./`) will be mounted to PHP container (assuming it's your codebase directory). Additionally `docker-runtime` directory will be created to store files for mariadb and, optionally, solr containers. Do not forget to add `docker-runtime` to your .gitignore file. 

**Linux only**: fix permissions for your files directory with:
```bash
$ sudo chgrp -R 82 sites/default/files
$ sudo chmod -R 775 sites/default/files
```

4\. Choose Drupal version by modifying the following environment variable (could be 7 or 8) in the compose file:
```yml
DRUPAL_VERSION: 8
```

5\. Choose PHP version by modifying the name of the image:
```yml
image: wodby/drupal-php:7.0 # Allowed: 7.0, 5.6
```

6\. Update database credentials in your settings.php file:
```
database: drupal
username: drupal
password: drupal
host: mariadb
```

7\. If you want to import your database, uncomment the following line in the compose file:
```yml
#      - ./docker-runtime/mariadb-init:/docker-entrypoint-initdb.d # Place init .sql file(s) her
```

Create the volume directory `./docker-runtime/mariadb-init` in the same directory as the compose file and put there your SQL file(s). All SQL files will be automatically imported once MariaDB container has started.

8\. If you need to deploy one of the optional containers ([Redis](#redis), [Memcached](#memcached), [Apache Solr](#apache-solr)) uncomment the corresponding lines in the compose file.

9\. Now, let's run the compose file. It will download the images and run the containers:
```bash
$ docker-compose up -d
```

10\. Make sure all containers are running by executing:

```bash
$ docker-compose ps
```

11\. That's it! You drupal website should be up and running at http://localhost:8000. 

## Containers

### Accessing containers

You can connect to any container by executing the following command:
```bash
$ docker-compose exec php sh
```

Replace `php` with the name of your service (e.g. `mariadb`, `nginx`, etc).

### PHP

Currently PHP version 5.6 and 7 are provided. Check out [the instructions (step 5)](#instructions) to learn how to switch the version.

#### Drush

PHP container has installed drush. When running drush make sure to open the shell as user 82 (www-data) to avoid access problems in the web server, which is running as user 82, too:
```bash
$ docker-compose exec --user 82 php drush
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

If you want to use xdebug, uncomment the following line in the compose file:

```yml
#    XDEBUG_CONFIG: xdebug.remote_autostart=1
```

See the <a href="https://github.com/Wodby/drupal-php/issues/1" target="_blank">known issue</a> with Xdebug in Mac OS.

### MariaDB

#### Import

Check out [the instructions (step 7)](#instructions) to learn how to import your existing database. 

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
2. Download and install <a href="https://www.drupal.org/project/redis" target="_blank">redis module</a> 
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
2. Download and install <a href="https://www.drupal.org/project/memcache" target="_blank">memcache module</a> 
3. Add the following lines to the settings.php file:

```php
$conf['cache_backends'][] = 'sites/all/modules/memcache/memcache.inc';
$conf['lock_inc'] = 'sites/all/modules/memcache/memcache-lock.inc';
$conf['memcache_stampede_protection'] = TRUE;
$conf['cache_default_class'] = 'MemCacheDrupal';
$conf['cache_class_cache_form'] = 'DrupalDatabaseCache';
$conf['memcache_servers'] = array('memcached:11211' => 'default');
```

### Mailhog

By default, container with mailhog included in the bundle. It will catch all email sent from the PHP container. You can view emails by visiting its admin UI on localhost:8002.

### phpMyAdmin

By default, container with phpMyAdmin included in the bundle. You can accessit by localhost:8001

### Apache Solr

To spin up a container with Apache Solr search engine uncomment lines with solr service definition in the compose file. Use  volume directory `./docker-runtime/solr` to access configuration files. Solr admin UI can be accessed by localhost:8003

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

We update containers from time to time, to get the lastest changes simply run again:
```
$ docker-compose up -d
```

## Going beyond local machine

Check out <a href="https://wodby.com" target="_blank">Wodby</a> if you need optimized consistent docker-based environment for Drupal on your dev/staging or production servers. 
