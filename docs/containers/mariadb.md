# MariaDB

MariaDB uses a persistent volume defined in Dockerfile. 

IMPORTANT: Do not use `docker-compose down` command because it will purge MariaDB volume. Instead use `docker-compose stop`. If you restart Docker you WILL NOT lose your MariaDB data. 

## Import existing database

if you want to import your database, uncomment the following line in the compose file:
```yml
#      - ./mariadb-init:/docker-entrypoint-initdb.d # Place init .sql file(s) here
```

Create the volume directory `./mariadb-init` in the same directory as the compose file and put there your SQL file(s). All SQL files will be automatically imported once MariaDB container has started.

## Export

Exporting all databases:
```bash
docker-compose exec mariadb sh -c 'exec mysqldump --all-databases -uroot -p"root-password"' > databases.sql
```

Exporting a specific database:
```bash
docker-compose exec mariadb sh -c 'exec mysqldump -uroot -p"root-password" my-db' > my-db.sql
```

## Configuration

Configuration is possible via environment variables. See the full list of variables on [GitHub](https://github.com/wodby/mariadb).
