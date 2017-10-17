# Varnish

## Integration

### Drupal 7

To spin up a container with Varnish cache and use it as a cache solution follow these steps:

1. Uncomment lines with varnish service definition in the compose file.
2. Download and install [varnish module](https://www.drupal.org/project/varnish)
3. Add the following lines to the settings.php file:

```php
$conf['varnish_version'] = 4;
$conf['varnish_control_terminal'] = 'varnish:6082';
$conf['varnish_control_key'] = 'secret';
```

### Drupal 8

Read [https://wunderkraut.se/blogg/purge-cachetags-varnish](https://wunderkraut.se/blogg/purge-cachetags-varnish).

## Configuration

Configuration is possible via environment variables. See the full list of variables on [GitHub](https://github.com/wodby/drupal-varnish).
