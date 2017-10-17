# Accessing containers

You can connect to any container by executing the following command:
```bash
$ docker-compose exec [service] sh
```

Make sure you're using correct users to access the container, e.g. use user www-data (82) for Nginx and PHP containers:
```bash
$ docker-compose exec php sh
``` 
