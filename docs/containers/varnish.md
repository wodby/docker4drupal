# Varnish container

## Integration

### Drupal 7

To spin up a container with Redis cache and use it as a default cache storage follow these steps:

1. Uncomment lines with varnish service definition in the compose file.
2. Download and install [varnish module](https://www.drupal.org/project/varnish)
3. Add the following lines to the settings.php file:

```php
$conf['varnish_version'] = 4;
$conf['varnish_control_terminal'] = 'varnish:6082';
$conf['varnish_control_key'] = 'secret';
```

### Drupal 8

Blog post is coming.

## Customization

See the list of environment variables available for customization at [wodby/drupal-varnish](https://github.com/wodby/drupal-varnish).
