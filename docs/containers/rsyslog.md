# Rsyslog container

Rsyslog can be used to stream your applications logs (watchdog). It's similar to using syslog, however there's no syslog in PHP container (one process per container). Rsyslog will stream all incoming logs to a container output.

Here how you can use it with Monolog (Drupal 8):

1. Install [monolog module](https://www.drupal.org/project/monolog). Make sure all dependencies being downloaded
2. Add new handler at `monolog/monolog.services.yml`:
```yml
monolog.handler.rsyslog:
  class: Monolog\Handler\SyslogUdpHandler
  arguments: ['rsyslog']
```
3. Rebuild cache (`drush cr`)
4. Use `rsyslog` handler for your channels
5. Find your logs in [rsyslog container output](../logs.md)

Read [Logging in Drupal 8](https://www.wellnet.it/en/blog/logging-drupal-8) to learn more.
