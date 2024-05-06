<?php

$contrib_path = is_dir('sites/all/modules/contrib')
  ? 'sites/all/modules/contrib'
  : 'sites/all/modules';

$settings['redis.connection']['host'] = 'valkey';
$settings['redis.connection']['port'] = '6379';
$settings['redis.connection']['password'] = 'bad-password';
$settings['redis.connection']['base'] = 0;
$settings['redis.connection']['interface'] = 'PhpRedis';
$settings['cache']['default'] = 'cache.backend.redis';
$settings['cache']['bins']['bootstrap'] = 'cache.backend.chainedfast';
$settings['cache']['bins']['discovery'] = 'cache.backend.chainedfast';
$settings['cache']['bins']['config'] = 'cache.backend.chainedfast';

$settings['container_yamls'][] = $contrib_path . '/redis/example.services.yml';

$settings['trusted_host_patterns'] = array(
    '\\.localhost$', '\\.local$', '\\.loc$'
);
