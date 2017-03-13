# Domains configuration

Docker4Drupal uses [traefik](https://hub.docker.com/_/traefik/) container for routing. By default, we use port 8080 to avoid potential conflicts but if port 80 is free on your host machine just replace traefik's ports definition in the compose file.

Default domains:

| Service | Domain | 
| ------- | ------ | 
| nginx   | http://drupal.docker.localhost:8080         | 
| pma     | http://pma.drupal.docker.localhost:8080     | 
| mailhog | http://mailhog.drupal.docker.localhost:8080 | 
| solr    | http://solr.docker.localhost:8080           | 
| node    | http://front.drupal.docker.localhost:8080   | 
| varnish | http://varnish.drupal.docker.localhost:8080 |
 
You can customize domains under labels definition, e.g. `traefik.frontend.rule=Host:mailhog.drupal.docker.localhost`. Note: if domains end with `docker.localhost` you don't need to add records to /etc/hosts file
