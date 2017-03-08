To spin up a container with Apache Solr search engine uncomment lines with solr service definition in the compose file.  

Solr admin UI can be accessed by `localhost:8003`. Solr container has a persistent volume defined in Dockerfile, so your data won't be lost if you stop the container. Solr cores can be found under `/opt/solr/server/solr`.

## Integration with Search API Solr module

Drupal 8 example:

1. Create pre-configured solr core (available only for v5.5) `docker-compose exec solr solr-create-core my-core drupal8`
2. Download and enable [Search API Solr module](https://www.drupal.org/project/search_api_solr)
3. Open module configuration page and add a new search server
4. Choose Solr as a backend and _Standard_ Solr Connector
5. Specify `solr` as a Solr host, `8983` as a port, `/solr` as a solr path and your core name (`my-core` from step 1)
6. That's it! Now Drupal should be connected to our Solr backend. Solr admin UI is available by `localhost:8003` 

You can find more information about solr configuration and actions on [wodby/drupal-solr](https://github.com/wodby/drupal-solr).