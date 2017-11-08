# Memcached

To spin up a container with Memcached and use it as a default cache storage follow these steps:

1. Uncomment lines with memcached service definition in the compose file.
2. Download and install [memcache module](https://www.drupal.org/project/memcache)
3. Add the following lines to the settings.php file:

## Drupal 7

```php
$conf['memcache_extension'] = 'memcached';
$conf['cache_backends'][] = 'sites/all/modules/memcache/memcache.inc';
$conf['lock_inc'] = 'sites/all/modules/memcache/memcache-lock.inc';
$conf['memcache_stampede_protection'] = TRUE;
$conf['cache_default_class'] = 'MemCacheDrupal';
$conf['cache_class_cache_form'] = 'DrupalDatabaseCache';
$conf['memcache_servers'] = array('memcached:11211' => 'default');
```
## Drupal 8

You _must enable the module_ before you do this. 
```php 
$settings['memcache']['servers'] = ['memcached:11211' => 'default'];
$settings['cache']['default'] = 'cache.backend.memcache';
```

## Memcached status and hits

You are able to check the status of memcached and its hits by running the following command.
```php
docker-compose exec memcached watch "echo stats | nc 127.0.0.1 11211"
```

## Configuration

Configuration is possible via environment variables. See the full list of variables on [GitHub](https://github.com/wodby/memcached).
