# Using docker for local development

This article explains how you can spin up a local environment using the *native Docker app* on Linux, Mac OS X and Windows. 

## Drupal 8

### Overview

The Drupal 8 bundle consist of the following containers:

| Container | Image | 
| --------- | ----- |
| Nginx   | <a href="https://hub.docker.com/r/wodby/drupal-nginx/" target="_blank">wodby/drupal-nginx</a> |
| PHP 7   | <a href="https://hub.docker.com/r/wodby/drupal-php/" target="_blank">wodby/drupal-php</a> |
| MariaDB | <a href="https://hub.docker.com/r/wodby/drupal-mariadb/" target="_blank">wodby/drupal-mariadb</a> |

### Instructions 

#### Linux / MacOS

1\. Install docker for <a href="https://docs.docker.com/engine/installation/" target="_blank">Linux</a>, <a href="https://docs.docker.com/engine/installation/mac" target="_blank">Mac OS X</a> or <a href="https://docs.docker.com/engine/installation/windows" target="_blank">Windows</a>

2\. Download the compose file from this repository

3\. Since containers do not have a permanent storage, directories from the host machine should be mounted: one with your Drupal project and another with database files. By default `docroot` and `mariadb` directories will be automatically created in the same directory as the compose file. 

First, let's edit the path to your Drupal project for PHP container. Find the following line
```yml
    - ./docroot:/var/www/html
```

and replace it with your path:
```yml
 - /path/to/my/drupal/docroot:/var/www/html
```

Additionally, you can adjust path to the database files directory (`- ./mariadb:/var/lib/mysql`). 

4\. Specify database credentials in your settings.php file:
```php
$databases['default']['default'] = array (
  'database' => 'drupal',
  'username' => 'drupal',
  'password' => 'drupal',
  'host' => 'db',
  'port' => '3306',
  'driver' => 'mysql',
  'prefix' => '',
  'collation' => 'utf8mb4_general_ci',
);
```

5\. Now, let's run the compose file. It will download the images and run the containers:
```bash
$ docker-compose up -d
```

6\. Make sure all containers are running by executing:

```bash
$ docker ps
```

7\. You can import your database via:
```bash
$ drush sql-cli < database-dump.sql
```

8\. That's it. You drupal website should be up and running at http://localhost:8000
