## Stopping containers

```bash
$ docker-compose stop
```

IMPORTANT: do not use `docker-compose down` or you will lose data in your MariaDB volume.

## Accessing containers

You can connect to any container by executing the following command:
```bash
$ docker-compose exec php sh
```

Replace `php` with the name of your service (e.g. `mariadb`, `nginx`, etc).
