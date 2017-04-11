# Running Multiple Projects with Docker4Drupal

Follow these instructions to run multiple projects simultaneously:

1. Run your docker-compose file and execute `docker ps`. Use values from last column NAMES to replace corresponding `traefik.backend` labels in the compose file (e.g. `projectdir_nginx_1` instead of `nginx`)
2. Remove traefik definition from your compose file, we will run it stand-alone
3.   
4. Download `traefik.yml` from docker4drupal repository, replace example network names to your own (e.g. `projectdir_default` instead of `project1-dir_default`)
5. Run stand-alone traefik `docker-compose -f traefik.yml up -d`

## Additional for macOS users with docker-sync:

Names of `syncs` in docker-sync.yml file must be unique per project. The recommended way is to run stand-alone docker-sync with syncs definition for all projects. Do not forget to update `src` paths for projects. 