# PostgreSQL

PostgreSQL uses a persistent volume defined in Dockerfile. 

## Data persistence

Do not use `docker-compose down` command because it will purge PostgreSQL volume. Instead use `docker-compose stop`. If you restart Docker you WILL NOT lose your PostgreSQL data. 

Alternatively, you can manage your volumes manually by uncommenting the volume definition for `/var/lib/postgresql/data`. Replace `/path/to/postgres/data/on/host` to the preferred filepath on your host machine. This way, your db data will always persist.

## Import existing database

if you want to import your database, uncomment the following line in the compose file:
```yml
#      - ./postgres-init:/docker-entrypoint-initdb.d # Place init .sql .sql.gz .sh file(s) here
```

Create the volume directory `./postgres-init` in the same directory as the compose file and put there your SQL file(s). All SQL files will be automatically imported once PostgreSQL container has started.

## Configuration

Configuration is possible via environment variables. See the full list of variables on [GitHub](https://github.com/wodby/postgres).
