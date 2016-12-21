# Docker-based Drupal environment for local development

[![Documentation Status](https://readthedocs.org/projects/docker4drupal/badge/?version=latest)](http://docs.docker4drupal.org)

Docker4Drupal is a set of docker containers optimized for Drupal. Use docker-compose.yml file from this repository to spin up local environment on Linux, Mac OS X and Windows.

Docker4Drupal is designed to be used for local development, if you're looking for a dev/staging/production solution consistent with Docker4Drupal check out [Wodby](https://wodby.com). 

The Drupal bundle consist of the following containers:

| Container | Service name | Image | Public Port | Enabled by default |
| --------- | ------------ | ----- | ----------- | ------------------ |
| Nginx | nginx | [wodby/drupal-nginx](https://hub.docker.com/r/wodby/drupal-nginx/) | 8000 | ✓ |
| PHP 7 / 5.6 | php | [wodby/drupal-php](https://hub.docker.com/r/wodby/drupal-php/) |  | ✓ |
| MariaDB | mariadb | [wodby/drupal-mariadb](https://hub.docker.com/r/wodby/drupal-mariadb/) | | ✓ |
| phpMyAdmin | pma | [phpmyadmin/phpmyadmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin) | 8001 | ✓ |
| Mailhog | mailhog | [mailhog/mailhog](https://hub.docker.com/r/mailhog/mailhog) | 8002 | ✓ |
| Redis | redis | [redis/redis](https://hub.docker.com/_/redis) |||
| Memcached | memcached | [_/memcached](https://hub.docker.com/_/memcached/) |||
| Apache Solr | solr | [wodby/solr](https://hub.docker.com/r/wodby/solr) | 8003 ||
| Varnish | varnish | [wodby/drupal-varnish](https://hub.docker.com/r/wodby/drupal-varnish) | 8004 ||

Supported Drupal versions: 7 and 8

Supported PHP versions: 7.0.x and 5.6.x.

## Documentation

Full Docker4Drupal documentation is available at http://docs.docker4drupal.org/

## License

This project is licensed under the MIT open source license.
