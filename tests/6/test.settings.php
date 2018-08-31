<?php

$contrib_path = is_dir('sites/all/modules/contrib')
  ? 'sites/all/modules/contrib'
  : 'sites/all/modules';

if (file_exists("$contrib_path/memcache")) {
  $conf['memcache_extension'] = 'memcached';
  $conf['cache_inc'] = "$contrib_path/memcache/memcache.inc";
  $conf['memcache_servers'] = array('memcached:11211' => 'default');
  $conf['memcache_key_prefix'] = 'docker4drupal';
  $conf['memcache_bins'] = array(
    'cache' => 'default',
    'cache_update' => 'database',
    'cache_form' => 'database',
  );
}
