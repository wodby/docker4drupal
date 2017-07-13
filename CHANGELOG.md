# Docker4Drupal Changelog

## 2.3.0

* New default container [Portainer](https://portainer.io/), simple UI for containers management
* PHP updates: [7.1.7](http://php.net/ChangeLog-7.php#7.1.7), [7.0.21](http://php.net/ChangeLog-7.php#7.0.21), [5.6.31](http://php.net/ChangeLog-5.php#5.6.31) with security fixes
* Nginx updates: [1.13.3](http://nginx.org/en/CHANGES), [1.12.1](http://nginx.org/en/CHANGES-1.12) with a fix in the range filter vulnerability (CVE-2017-7529).
* Apache2 updates: [2.4.27](http://www.apache.org/dist/httpd/CHANGES_2.4.27)
* Vanilla Drupal updates: [8.3.5](https://www.drupal.org/project/drupal/releases/8.3.5)
* Solr: new versions 6.6 and 6.5 for Drupal 8
* Solr: search_api_solr version update to 8.x-1.0 (configs used from this version)
* `.localhost`, `.local`, `.loc` added as default trusted hosts for Vanilla Drupal 8
* Nginx: Content-Type is now set only if not empty https://github.com/wodby/drupal-nginx/issues/27
* Bugfix: Vanilla Drupal always re-synced Drupal sources https://github.com/wodby/drupal/issues/2 
* Solr versions are now frozen https://github.com/wodby/solr#versions
* Redis version is now frozen https://github.com/wodby/redis#versions

## 2.2.0

* New [Apache 2.4 container](http://docs.docker4drupal.org/en/latest/containers/apache)
* New [Node.js container](http://docs.docker4drupal.org/en/latest/containers/nodejs), for drupal nodejs module
* New [AthenaPDF container](http://docs.docker4drupal.org/en/latest/containers/athenapdf), drop-in replacement for wkhtmltopdf
* New [rsyslog](http://docs.docker4drupal.org/en/latest/containers/rsyslog) to stream watchdog logs
* New adminer container (simplified version of phpmyadmin)
* Solr: new 5.4 version required by search_api_solr module for Drupal 7
* Drupal: updated Vanilla Drupal 8.3.4, 7.56
* PHP: update PHP7: 7.0.20, 7.1.6
* PHP: 5.6, 7.0, 7.1 images rebased to Alpine Linux 3.6 and now use LibreSSL instead of OpenSSL
* PHP: extension are now frozen, see https://github.com/wodby/php
* PHP: runtime libraries are now frozen
* PHP: mongoDB extension downgraded to 1.1.10
* PHP: imagick removed from 5.3 
* PHP: expose header now disabled by default
* PHP: dropped few environment variables
* PHP: APCu extension is now configurable
* Nginx: new version 1.13, 1.12
* Nginx: 1.10 dropped
* Nginx: options to allow all XML endpoints
* Nginx: you can now override include of drupal.conf file
* Nginx: additional configuration for xmlrpc endpoint
* MariaDB: revamped optimized configuration
* Bug fix: resolved imagick segfault caused by a bug in ImageMagick library
* Bug fix: private files not accessible
* Bug fix: some environment variables missed in SSH container
* Bug fix: authorize.php endpoint did not work
* New way to improve volumes performance on macOS: http://docs.docker4drupal.org/en/latest/macos

## 2.1.0

* New 2.1.0 images for php, nginx, mariadb, redis and varnish
* New memcached image
* Updated documentation
* New [Vanilla Drupal option](http://docs.docker4drupal.org/en/latest/#1-run-vanilla-drupal-from-image-default) is now default 
* traefik.yml to [run multiple projects simultaneously](http://docs.docker4drupal.org/en/latest/multiple-projects/)

## 2.0.1

* Traefik with domains is now enabled by default
* Updates in documentation
* Updated redis image

## 2.0.0

* All-new 2.0.0 docker images: [drupal-nginx](https://github.com/wodby/drupal-nginx/), [drupal-php](https://github.com/wodby/drupal-php/), [mariadb](https://github.com/wodby/mariadb/), [redis](https://github.com/wodby/redis/), [drupal-varnish](https://github.com/wodby/drupal-varnish/). You can now customize images with environment variable and override entire configs by using .tpl template (based on confd). Some images come with actions you can execute (e.g. create Solr core with Search API configs)
* Drupal 6 support
* Domains support via Traefik
* PHP versions: 5.3/5.6/7.0/7.1 based on officials (except 5.3)
* Extended list of PHP extensions
* Solr 5.5/6.3/6.4 support
* Node.js optional container
* Revamped documentation
* Auto-tests for Drupal 6/7/8 via Travis

## v1.3.0

### Improvements

* IMPORTANT: MariaDB container now has no volume defined via compose file. The volume is already defined in its Dockerfile, so Docker will create and mount volume automatically. Do not use `docker-compose down` unless you want to purge your volumes. If you restart docker or use `docker-compose stop` the volume will persist
* Performance improvement for macOS (OSX) users: a new way to sync codebase files is now described. It's based on [docker-sync project](https://github.com/EugenMayer/docker-sync/). Docker is now usable for development on mac. See README.md
* New solr container (versions 5.5 and 6.3)
* Versions of images, except official, are now frozen. A new version will be released when a newer image version is available
* SSHD container is now removed from the standard set
* We now have [slack](https://slack.wodby.com) where you can any questions about docker4drupal 
* New documentation http://docs.docker4drupal.org
* Instructions updated
* License file added (MIT)
* Changelog file added

### Action Required Before Upgrading

* Since MariaDB now uses volume defined in Dockerfile instead of docker-compose, you should export your database and import it again (use mariadb-init volume for this)
* Do not use `docker-compose down` command because it will purge MariaDB volume. Instead use `docker-compose stop`. If you restart Docker you WILL NOT lose your data

## 1.3.0-rc1 (Dec 20th 2016)

### Improvements

* IMPORTANT: MariaDB container now has no volume defined via compose file. The volume is already defined in its Dockerfile, so Docker will create and mount volume automatically. Do not use `docker-compose down` unless you want to purge your volumes. If you restart docker or use `docker-compose stop` the volume will persist
* Performance improvement for macOS (OSX) users: a new way to sync codebase files is now described. It's based on [docker-sync project](https://github.com/EugenMayer/docker-sync/). Docker is now usable for development on mac. See README.md
* New solr container (versions 5.5 and 6.3)
* Versions of images, except official, are now frozen. A new version will be released when a newer image version is available
* SSHD container is now removed from the standard set
* We now have [slack](https://slack.wodby.com) where you can any questions about docker4drupal 
* Instructions updated
* License file added (MIT)
* Changelog file added (duh!)

### Action Required Before Upgrading

* Since MariaDB now uses volume defined in Dockerfile instead of docker-compose, you should export your database and import it again (use mariadb-init volume for this)
* Do not use `docker-compose down` command because it will purge MariaDB volume. Instead use `docker-compose stop`. If you restart Docker you WILL NOT lose your data
