# Containers Logs

## GUI

You can find containers logs from portainer UI: [http://portainer.drupal.docker.localhost:8000](http://portainer.drupal.docker.localhost:8000)

## CLI

To get logs from a container simply run (skip the last param to get logs form all the containers):
```
$ docker-compose logs [service]
```

Example: real-time logs of the PHP container:
```
$ docker-compose logs -f php
```
