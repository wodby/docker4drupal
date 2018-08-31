<?php
/**
 * @file
 * feature_search_api_solr.features.inc
 */

/**
 * Implements hook_default_search_api_server().
 */
function feature_search_api_solr_default_search_api_server() {
  $items = array();
  $items['apache_solr_6_4'] = entity_import('search_api_server', '{
    "name" : "Apache Solr 6.4",
    "machine_name" : "apache_solr_6_4",
    "description" : "",
    "class" : "search_api_solr_service",
    "options" : {
      "clean_ids" : true,
      "site_hash" : true,
      "scheme" : "http",
      "host" : "solr",
      "port" : "8983",
      "path" : "\\/solr\\/core1",
      "http_user" : "",
      "http_pass" : "",
      "excerpt" : 0,
      "retrieve_data" : 0,
      "highlight_data" : 0,
      "skip_schema_check" : 0,
      "solr_version" : "",
      "http_method" : "AUTO",
      "log_query" : 0,
      "log_response" : 0,
      "commits_disabled" : 0
    },
    "enabled" : "1",
    "rdf_mapping" : []
  }');
  return $items;
}
