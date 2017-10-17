# Blackfire

You can profile your Drupal application via blackfire.io by following the next steps:

* Enable blackfire probe extension by adding the environment variable `PHP_BLACKFIRE` with any value to PHP (Drupal) service
* Uncomment `blackfire` agent service in your docker compose file 
* Specify values for `BLACKFIRE_SERVER_ID` and `BLACKFIRE_SERVER_TOKEN` environment variables (you can acquire them from your blackfire.io profile)
* Install blackfire companion extension for [Chrome](https://blackfire.io/docs/integrations/chrome) or [Firefox](https://blackfire.io/docs/integrations/firefox)
* Start profiling your app via the extension and see data from blackfire.io dashboard

Fore more details please refer to the official documentation: https://blackfire.io/docs/introduction
