To spin up a container with Memcached and use it as a default cache storage follow these steps:

1. Uncomment lines with memcached service definition in the compose file.
2. Download and install [memcache module](https://www.drupal.org/project/memcache)
3. Add the following lines to the settings.php file:

```php
$conf['memcache_extension'] = 'memcached';
$conf['cache_backends'][] = 'sites/all/modules/memcache/memcache.inc';
$conf['lock_inc'] = 'sites/all/modules/memcache/memcache-lock.inc';
$conf['memcache_stampede_protection'] = TRUE;
$conf['cache_default_class'] = 'MemCacheDrupal';
$conf['cache_class_cache_form'] = 'DrupalDatabaseCache';
$conf['memcache_servers'] = array('memcached:11211' => 'default');
```

## Memcached Admin

To spin up a container with the Memcached Admin User interface uncomment to memcached-admin service definition.
To get started visit http://localhost:8006/index.php
