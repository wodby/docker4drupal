# Docker4Drupal Changelog

## 1.3.0-rc1 (Dec 20th 2016)

### Improvements

* IMPORTANT: MariaDB container now has no volume defined via compose file. The volume is already defined in its Dockerfile, so Docker will create and mount volume automatically. Do not use `docker-compose down` unless you want to purge your volumes. If you restart docker or use `docker-compose stop` the volume will persist
* Performance improvement for macOS (OSX) users: a new way to sync codebase files is now described. It's based on [docker-sync project](https://github.com/EugenMayer/docker-sync/). Docker is now usable for development on mac. See README.md
* New solr container (versions 5.5 and 6.3)
* Versions of images, except official, are now frozen. A new version will be released when a newer image version is available
* SSHD container is now removed from the standard set
* We now have [slack](https://slack.wodby.com) where you can any questions about docker4drupal 
* Instructions updated
* License file added (MIT)
* Changelog file added (duh!)

### Action Required Before Upgrading

* Since MariaDB now uses volume defined in Dockerfile instead of docker-compose, you should export your database and import it again (use mariadb-init volume for this)
* Do not use `docker-compose down` command because it will purge MariaDB volume. Instead use `docker-compose stop`. If you restart Docker you WILL NOT lose your data