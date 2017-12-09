# Domains Configuration

Docker4Drupal uses [traefik](https://hub.docker.com/_/traefik/) container for routing. By default, we use port `8000` to avoid potential conflicts but if port `80` is free on your host machine just replace traefik's ports definition in the compose file.

Add `127.0.0.1 drupal.docker.localhost` to your `/etc/hosts` file (some browsers like Chrome may work without it). Do the same for other default domains you might need from listed below:  

| Service      | Domain                                                                                         |
| ------------ | ---------------------------------------------------------------------------------------------- |
| nginx/apache | [http://drupal.docker.localhost:8000](http://drupal.docker.localhost:8000)                     |
| pma          | [http://pma.drupal.docker.localhost:8000](http://pma.drupal.docker.localhost:8000)             |
| adminer      | [http://adminer.drupal.docker.localhost:8000](http://adminer.drupal.docker.localhost:8000)     |
| mailhog      | [http://mailhog.drupal.docker.localhost:8000](http://mailhog.drupal.docker.localhost:8000)     |
| solr         | [http://solr.drupal.docker.localhost:8000](http://solr.drupal.docker.localhost:8000)           |
| nodejs       | [http://nodejs.drupal.docker.localhost:8000](http://nodejs.drupal.docker.localhost:8000)       |
| node         | [http://front.drupal.docker.localhost:8000](http://front.drupal.docker.localhost:8000)         |
| varnish      | [http://varnish.drupal.docker.localhost:8000](http://varnish.drupal.docker.localhost:8000)     |
| portainer    | [http://portainer.drupal.docker.localhost:8000](http://portainer.drupal.docker.localhost:8000) |
| webgrind     | [http://webgrind.drupal.docker.localhost:8000](http://webgrind.drupal.docker.localhost:8000)   |

You can modify domains under labels definition, e.g. `traefik.frontend.rule=Host:mailhog.drupal.docker.localhost`.
