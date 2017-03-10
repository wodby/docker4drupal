# Domains configuration

To use custom domain for your project follow these steps:

1. Uncomment definition of traefik service in the compose file 
2. Make sure port 80 is free on your host machine
3. Customize your base domain under services labels. The default base domain is `drupal.docker.localhost` in `traefik.frontend.rule=Host:mailhog.drupal.docker.localhost`. If domains end with `docker.localhost` you don't need to add records to /etc/hosts file
4. Remove public ports definition from all services except traefik, you don't need them now
5. That's it! Run the compose file and check that domains work fine (default `http://drupal.docker.localhost/`)
6. Also you can visit traefik dashboard on `localhost:8080`
