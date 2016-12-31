Docker4Drupal is a set of docker containers optimized for Drupal. Use docker-compose.yml file from [docker4drupal repository](https://github.com/wodby/docker4drupal) to spin up local environment on Linux, Mac OS X and Windows. 

Docker4Drupal is designed to be used for local development, if you're looking for a dev/staging/production solution consistent with Docker4Drupal check out [Wodby](https://wodby.com). 

## Overview

The Drupal bundle consist of the following containers:

| Container | Service name | Image | Public Port | Enabled by default |
| --------- | ------------ | ----- | ----------- | ------------------ |
| [Nginx](containers/nginx.md) | nginx | [wodby/drupal-nginx](https://hub.docker.com/r/wodby/drupal-nginx/) | 8000 | ✓ |
| [PHP 7 / 5.6](containers/php.md) | php | [wodby/drupal-php](https://hub.docker.com/r/wodby/drupal-php/) |  | ✓ |
| [MariaDB](containers/mariadb.md) | mariadb | [wodby/drupal-mariadb](https://hub.docker.com/r/wodby/drupal-mariadb/) | | ✓ |
| [phpMyAdmin](containers/pma.md) | pma | [phpmyadmin/phpmyadmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin) | 8001 | ✓ |
| [Mailhog](containers/mailhog.md) | mailhog | [mailhog/mailhog](https://hub.docker.com/r/mailhog/mailhog) | 8002 | ✓ |
| [Redis](containers/redis.md) | redis | [redis/redis](https://hub.docker.com/_/redis) |||
| [Memcached](containers/memcached.md) | memcached | [_/memcached](https://hub.docker.com/_/memcached/) |||
| [Solr](containers/solr.md) | solr | [wodby/solr](https://hub.docker.com/r/wodby/solr) | 8003 ||
| [Varnish](containers/varnish.md) | varnish | [wodby/drupal-varnish](https://hub.docker.com/r/wodby/drupal-varnish) | 8004 ||

PHP, Nginx, MariaDB and Varnish configs are optimized to be used with Drupal. We regularly update this bundle with performance improvements, bug fixes and newer version of Nginx/PHP/MariaDB.

> All images used in the bundle are either official or based on official with optimization for Drupal.

Supported Drupal versions: 7 and 8<br>
Supported PHP versions: 7.0.x and 5.6.x.

## Requirements

Install docker for [Linux](https://docs.docker.com/engine/installation), [macOS (OS X)](https://docs.docker.com/engine/installation/mac) or [Windows (10+ Pro)](https://docs.docker.com/engine/installation/windows). For Mac and Windows make sure you're installing native docker app version 1.12+, not docker toolbox. For Linux additionally install [docker compose](https://docs.docker.com/compose/install)

## Usage 

Feel free to adjust volumes and ports in the compose file for your convenience.

1\. Download [docker-compose.yml file](https://github.com/wodby/docker4drupal/blob/master/docker-compose.yml) from [docker4drupal repository](https://github.com/wodby/docker4drupal) and put it to your Drupal project codebase (you might want to add docker-compose.yml to .gitignore).

2\. Mount your codebase directory (`./` by default) to PHP container (Nginx uses volumes from PHP). MariaDB volume is defined in its Dockerfile and will be handled by Docker.

_For macOS users_: By default Docker has a [very poor performance](https://github.com/Wodby/docker4drupal/issues/4) on macOS (OS X). However there's a workaround based on [docker-sync project](https://github.com/EugenMayer/docker-sync/), read instructions [here](macos.md). 

_For Linux users_: fix permissions for your files directory with:
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

6\. Optional: [import existing database](containers/mariadb.md#import-existing-database)

7\. If you need to deploy one of the optional containers ([Redis](containers/redis.md), [Memcached](containers/memcached.md), [Apache Solr](containers/solr.md)) uncomment the corresponding lines in the compose file.

8\. Now, let's run the compose file. It will download the images and run the containers:
```bash
docker-compose up -d
```

9\. Make sure all containers are running by executing:

```bash
docker-compose ps
```

10\. That's it! You drupal website should be up and running at http://localhost:8000.

You can view your access and error logs by running:
```bash
docker-compose logs
```

You can stop all containers by executing:

```bash
docker-compose stop
```

## Status

We're actively working on this instructions and containers. More options will be added soon. If you have a feature request or found a bug please submit an issue.

We update containers from time to time, to get the latest changes simply run again:
```
$ docker-compose up -d
```

## License

This project is licensed under the MIT open source license.
