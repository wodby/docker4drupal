# Solr

To spin up a container with Apache Solr search engine uncomment lines with solr service definition in the compose file.  

By default, Solr admin UI can be accessed by [http://solr.drupal.docker.localhost:8000](http://solr.drupal.docker.localhost:8000). Solr container has a persistent volume defined in Dockerfile, so your data won't be lost if you stop the container. Solr cores can be found under `/opt/solr/server/solr`.

## Integration with Search API Solr module

1. Create new solr core `docker exec -ti [ID] make core=core1 -f /usr/local/bin/actions.mk`. The new core will already include config files from Search API Solr module
2. Download and enable [Search API Solr module](https://www.drupal.org/project/search_api_solr)
3. Open module configuration page and add a new search server
4. Choose Solr as a backend and _Standard_ Solr Connector
5. Specify `solr` as a Solr host, `8983` as a port, `/solr` as a solr path and your core name (`core1` from step 1)
6. That's it! Now Drupal should be connected to our Solr backend 

## Configuration

Configuration is possible via environment variables. See the full list of variables on [GitHub](https://github.com/wodby/drupal-solr).