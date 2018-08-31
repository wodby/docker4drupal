<?php

$contrib_path = is_dir('sites/all/modules/contrib')
  ? 'sites/all/modules/contrib'
  : 'sites/all/modules';

if (file_exists($contrib_path . '/varnish')) {
  $conf['varnish_version'] = 4;
  $conf['varnish_control_terminal'] = 'varnish:6082';
  $conf['varnish_control_key'] = 'secret';
}

if (file_exists($contrib_path . '/redis')) {
  $conf['redis_client_base'] = 0;
  $conf['redis_client_interface'] = 'PhpRedis';
  $conf['lock_inc'] = $contrib_path . '/redis/redis.lock.inc';
  $conf['path_inc'] = $contrib_path . '/redis/redis.path.inc';
  $conf['cache_backends'][] = $contrib_path . '/redis/redis.autoload.inc';
  $conf['cache_default_class'] = 'Redis_Cache';
  $conf['cache_class_cache_form'] = 'DrupalDatabaseCache';

  $conf['redis_client_host'] = 'redis';
  $conf['redis_client_port'] = '6379';
}

$base_url = 'http://varnish';

$conf['page_cache_maximum_age'] = '86400';
$conf['cache_lifetime'] = '86400';
$conf['cache'] = 1;