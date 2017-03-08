# Domains configuration

To use custom domain for your project follow these steps:

1. Uncomment definition of traefik service in the compose file 
2. Make sure port 80 is free on your host machine
3. Customize your base domain under services labels. The default base domain is `drupal.docker.localhost` in `traefik.frontend.rule=Host:mailhog.drupal.docker.localhost`. If domains end with `docker.localhost` you don't need to add records to /etc/hosts file
4. That's it! Run the compose file
5. Also you can visit traefik dashboard on `localhost:8080`
