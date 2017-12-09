# Redis

## Integration

To spin up a container with Redis cache and use it as a default cache storage follow these steps:

1. Uncomment lines with redis service definition in the compose file.
2. Download and install [redis module](https://www.drupal.org/project/redis)
3. Add the following lines to the settings.php file:

DRUPAL 7:

```php
$contrib_path = is_dir('sites/all/modules/contrib') ? 'sites/all/modules/contrib' : 'sites/all/modules';

$conf['redis_client_base'] = 0;
$conf['redis_client_interface'] = 'PhpRedis';
$conf['lock_inc'] = $contrib_path . '/redis/redis.lock.inc';
$conf['path_inc'] = $contrib_path . '/redis/redis.path.inc';
$conf['cache_backends'][] = $contrib_path . '/redis/redis.autoload.inc';
$conf['cache_default_class'] = 'Redis_Cache';
$conf['cache_class_cache_form'] = 'DrupalDatabaseCache';
$conf['redis_client_host'] = 'redis';
$conf['redis_client_port'] = '6379';
```

DRUPAL 8:

```php
$contrib_path = is_dir('modules/contrib') ? 'modules/contrib' : 'modules';

$settings['redis.connection']['host'] = 'redis';
$settings['redis.connection']['port'] = '6379';
$settings['redis.connection']['password'] = '';
$settings['redis.connection']['base'] = 0;
$settings['redis.connection']['interface'] = 'PhpRedis';
$settings['cache']['default'] = 'cache.backend.redis';
$settings['cache']['bins']['bootstrap'] = 'cache.backend.chainedfast';
$settings['cache']['bins']['discovery'] = 'cache.backend.chainedfast';
$settings['cache']['bins']['config'] = 'cache.backend.chainedfast';

$settings['container_yamls'][] = $contrib_path . '/redis/example.services.yml';
```

## Configuration

Configuration is possible via environment variables. See the full list of variables on [GitHub](https://github.com/wodby/redis).
