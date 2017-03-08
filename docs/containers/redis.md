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

You can find more information about redis configuration on [wodby/redis](https://github.com/wodby/redis).