# Webgrind

[Webgrind](https://github.com/jokkedk/webgrind) allows you view and analyze Xdebug profiler output and generate call graphs for visualisation. 

Usage:

1. Enable Xdebug profiler by uncommenting the following environment variables for `php` service:
```
PHP_XDEBUG: 1
PHP_XDEBUG_PROFILER_ENABLE: 1
PHP_XDEBUG_PROFILER_ENABLE_TRIGGER: 1
PHP_XDEBUG_PROFILER_ENABLE_TRIGGER_VALUE: 1
```
2. Uncomment `webgrind` service in your docker-compose file
3. Uncomment `files` volume for `php` service and the definition in global volumes  
4. Add `XDEBUG_PROFILE=1` param to GET or POST request (or set a cookie) you want to profile. Xdebug will generate profile files in `/mnt/files/xdebug/profiler`
5. Click Update in Webgrind to access the new information. See https://xdebug.org/docs/profiler to learn more about xdebug profiling.

> ! IMPORTANT: Xdebug profiling significantly decreases performance and increases resources usage. DO NOT USE it on Production servers.
