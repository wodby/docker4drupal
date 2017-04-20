# Running Multiple Projects with Træfik

[Træfik](https://docs.traefik.io/) is a modern HTTP reverse proxy and load balancer made to deploy microservices with ease.
To understand the basics of Traefik it is suggested to check Træfik's documentation page: https://docs.traefik.io/

<img src="https://docs.traefik.io/img/internal.png" />

Image: Multi-domain set-up example
(Source: traefik.io)

## Steps to set up two projects on one host ##

1. Create two dirs where you will host two projects. Let's name them "site1" and "site2".
2. Copy docker-compose.yml file to both dirs (site1 and site2).
3. Copy traefik.yml to the parent dir where site1 and site2 dirs are.
4. Edit traefik.yml and change "project1-dir_default" to "**site1_default**" and "project2-dir_default" to "**site2_default**". Those are docker networks names that are created automatically from the dir name where docker-compose.yml is located.
5. Edit site1's docker-compose.yml file. There are 3 main things that need to be done there:
  - In nginx service, under labels, change 'traefik.backend=nginx' to '**traefik.backend=site1_nginx_1**'. This is the name of the container. You can see that under NAMES when your have the containers running by executing "docker ps".
  - Change traefik.frontend.rule from "Host:drupal.docker.localhost" to "**Host:site1.docker.localhost**"
  - Comment out (#) all lines of "traefik" service at the bottom of the file.
6. Make similar 3 changes in site2's docker-compose.yml file:
  - 'traefik.backend=nginx' to '**traefik.backend=site2_nginx_1**'
  - "Host:drupal.docker.localhost" to "**Host:site2.docker.localhost**"
  - Comment out (#) all lines of "traefik" service at the bottom of the file.
7. Run `docker-compose up -d` in site1 and site2 dirs to spin up containers for both projects.
8. Run stand-alone traefik `docker-compose -f traefik.yml up -d` to spin up traefik reverse proxy.
9. Visit http://site1.docker.localhost and http://site2.docker.localhost in your broswer.

This set up also works for other Docker projects (non Drupal and non docker4drupal based). You can replace nginx-proxy config with Traefik and get other projects all routed with on traefik container.

## Problems? ##

- Check `docker ps` to see which containers are running and check if you have set up all names correctly.
- Check `docker network ls` to check if the network names are matching.
- Run `docker-compose logs -f` in site1 or site2 to see the log of each project.

To report issues about multi-project set up with docker4drupal or if you have more suggestions and use-cases, please use this thread: https://github.com/wodby/docker4drupal/issues/124


## Additional for macOS users with docker-sync:

Names of `syncs` in docker-sync.yml file must be unique per project. The recommended way is to run stand-alone docker-sync with syncs definition for all projects. Do not forget to update `src` paths for projects. 
