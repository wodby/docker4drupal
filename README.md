# Docker-based environment for Drupal

Use this Docker compose file to spin up local environment for Drupal with a *native Docker app* on Linux, Mac OS X and Windows. 

## Overview

The Drupal bundle consist of the following containers:

| Container | Image | 
| --------- | ----- |
| Nginx   | <a href="https://hub.docker.com/r/wodby/drupal-nginx/" target="_blank">wodby/drupal-nginx</a> |
| PHP 7   | <a href="https://hub.docker.com/r/wodby/drupal-php/" target="_blank">wodby/drupal-php</a> |
| MariaDB | <a href="https://hub.docker.com/r/wodby/drupal-mariadb/" target="_blank">wodby/drupal-mariadb</a> |

PHP, Nginx and MariaDB configs are optimized to be used with Drupal. We regularly update this bundle with performance improvements, bug fixes and newer version of Nginx/PHP/MariaDB.

## Instructions 

Supported Drupal versions: 7 and 8

### Linux / Mac OS X

1\. Install docker for <a href="https://docs.docker.com/engine/installation/" target="_blank">Linux</a>, <a href="https://docs.docker.com/engine/installation/mac" target="_blank">Mac OS X</a> or <a href="https://docs.docker.com/engine/installation/windows" target="_blank">Windows</a>

2\. Download the compose file from this repository

3\. Since containers <a href="https://docs.docker.com/engine/tutorials/dockervolumes/" target="_blank">do not have a permanent storage</a>, directories from the host machine should be mounted: one with your Drupal project and another with database files. By default `docroot` and `mariadb` directories will be automatically created in the same directory as the compose file. 

First, let's edit the path to your Drupal project for PHP container. Find the following line
```yml
- ./docroot:/var/www/html
```

and replace it with your path:
```yml
- /path/to/my/drupal/docroot:/var/www/html
```

Additionally, you can adjust path to the database files directory (`- ./mariadb:/var/lib/mysql`). 

4\. You can switch between Drupal version by modifying the following envrionment variable (could 7 or 8) in the compose file:
```yml
DRUPAL_VERSION: 8
```

5\. Update database credentials in your settings.php file:
```
database: drupal
username: drupal
password: drupal
host: db
```

6\. Now, let's run the compose file. It will download the images and run the containers:
```bash
$ docker-compose up -d
```

7\. Make sure all containers are running by executing:

```bash
$ docker ps
```

8\. You can import your database via:
```bash
$ drush sql-cli < database-dump.sql
```

9\. That's it! You drupal website should be up and running at http://localhost:8000. 

In case you have any problems submit an issue or contact us at hello [at] wodby.com.

Check out <a href="https://wodby.com" target="_blank">Wodby</a> if you need optimized docker-based environment for Drupal on your dev/staging or production servers.
