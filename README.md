# Docker-based environment for Drupal

Use this Docker compose file to spin up local environment for Drupal with a *native Docker app* on Linux, Mac OS X and Windows. 

* [Overview](#overview)
* [Instructions](#instructions)
* [Drush](#drush)
* [Composer](#composer)
* [Xdebug](#xdebug)
* [Database](#database)
* [Cache](#cache)
* [SMTP](#smtp)
* [phpMyAdmin](#phpmyadmin)
* [Apache Solr](#apache-solr)
* [Accessing containers](#accessing-containers)
* [Logs](#logs)
* [Updating](#updating)
* [Status](#status)
* [Troubleshooting](#troubleshooting)
* [Going beyond local machine](#going-beyond-local-machine)

## Overview

The Drupal bundle consist of the following containers:

| Container | Service name | Image | Volume | Port | Enabled by default |
| --------- | ------------ | ----- | ------ | ---- | ------------------ |
| Nginx | nginx | <a href="https://hub.docker.com/r/wodby/drupal-nginx/" target="_blank">wodby/drupal-nginx</a> || 8000 | ✓ |
| PHP 7, 5.6 | php | <a href="https://hub.docker.com/r/wodby/drupal-php/" target="_blank">wodby/drupal-php</a> | `./` || ✓ |
| MariaDB | mariadb | <a href="https://hub.docker.com/r/wodby/drupal-mariadb/" target="_blank">wodby/drupal-mariadb</a> |  `./docker-runtime/mariadb` || ✓ |
| phpMyAdmin | pma | <a href="https://hub.docker.com/r/phpmyadmin/phpmyadmin">phpmyadmin/phpmyadmin</a> || 8001 | ✓ |
| Mail catcher | smtp | <a href="https://hub.docker.com/r/junxy/docker-mailcatcher" target="_blank">junxy/docker-mailcatcher</a> || 8002 | ✓ |
| Redis | redis | <a href="https://hub.docker.com/_/redis/" target="_blank">redis:3.2-alpine</a> ||||
| Memcached | memcached | <a href="https://hub.docker.com/_/memcached/" target="_blank">memcached:1.4-alpine</a> ||||
| Search engine | solr | <a href="https://hub.docker.com/_/solr" target="_blank">solr:5.5-alpine</a> | `./docker-runtime/solr` |||

PHP, Nginx and MariaDB configs are optimized to be used with Drupal. We regularly update this bundle with performance improvements, bug fixes and newer version of Nginx/PHP/MariaDB.

## Instructions 

__Feel free to adjust volumes and ports in the compose file for your convenience.__

Supported Drupal versions: 7 and 8

Supported PHP versions: 7.x and 5.6.x.

1\. Install docker for <a href="https://docs.docker.com/engine/installation/" target="_blank">Linux</a>, <a href="https://docs.docker.com/engine/installation/mac" target="_blank">Mac OS X</a> or <a href="https://docs.docker.com/engine/installation/windows" target="_blank">Windows</a>. You need to install docker 1.12, not docker toolbox. 

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

Choose PHP version 
```yml

5\. Update database credentials in your settings.php file:
```
database: drupal
username: drupal
password: drupal
host: mariadb
```

6\. If you want to import your database, uncomment the following line in the compose file:
```yml
#      - ./docker-runtime/mariadb-init:/docker-entrypoint-initdb.d # Place init .sql file(s) her
```

Create the volume directory `./docker-runtime/mariadb-init` in the same directory as the compose file and put there your SQL file(s). All SQL files will be automatically imported once MariaDB container has started.

7\. Now, let's run the compose file. It will download the images and run the containers:
```bash
$ docker-compose up -d
```

8\. Make sure all containers are running by executing:

```bash
$ docker-compose ps
```

9\. That's it! You drupal website should be up and running at http://localhost:8000. 

## Drush

PHP container has installed drush, [connect to the php container](#accessing-containers) to use drush.

## Composer

PHP container has installed composer, [connect to the php container](#accessing-containers) to use composer.

## Xdebug

If you want to use xdebug, uncomment the following line in the compose file:

```yml
#    XDEBUG_CONFIG: xdebug.remote_autostart=1
```

See the <a href="https://github.com/Wodby/drupal-php/issues/1" target="_blank">known issue</a> with Xdebug in Mac OS.

## Database

### Export

Exporting all databases:

```bash
docker-compose exec mariadb sh -c 'exec mysqldump --all-databases -uroot -p"root-password"' > databases.sql
```

Exporting a specific database:

```bash
docker-compose exec mariadb sh -c 'exec mysqldump -uroot -p"root-password" my-db' > my-db.sql
```

## Cache

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

## SMTP

By default, container with mail catcher included in the bundle. It will catch all email sent from PHP container. You can view emails by visiting localhost:8002.

## phpMyAdmin

By default, container with phpMyAdmin included in the bundle. You can accessit by localhost:8001

## Apache Solr

To spin up a container with Apache Solr search engine uncomment lines with solr service definition in the compose file. Use  volume directory `./docker-runtime/solr` to access configuration files. Solr admin UI can be accessed by localhost:8003

## Accessing containers

You can connect to any container by executing the following command:
```bash
$ docker-compose exec php sh
```

Replace `php` with the name of your service (e.g. `mariadb`, `nginx`).

## Logs

To get logs from a container simply run (skip the last param to get logs form all the containers):
```
$ docker-compose logs [service]
```

Example: real-time logs of the PHP container:
```
$ docker-compose logs -f php
```

## Updating

We update containers from time to time, to get the lastest changes simply run again:
```
$ docker-compose up -d
```

## Status

We're actively working on this instructions and containers. More options will be added soon. If you have a feature request or found a bug please sumbit an issue.

## Troubleshooting

In case you have any problems submit an issue or contact us at hello [at] wodby.com.

## Going beyond local machine

Check out <a href="https://wodby.com" target="_blank">Wodby</a> if you need optimized consistent docker-based environment for Drupal on your dev/staging or production servers. 
