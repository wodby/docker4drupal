# Nginx

Nginx is being used as a default http server. 

## Files proxy

Since `wodby/drupal-nginx:x-x-3.0.2`, you can set up a proxy for Drupal files. Uncomment environment variable `NGINX_DRUPAL_FILE_PROXY_URL: http://example.com` from nginx service. Update the URL to the instance of your site where you want to get your files from, nginx will proxy all requests done to `/sites/*/files` to this instance.

## Configuration

Configuration is possible via environment variables. See the full list of variables on [GitHub](https://github.com/wodby/drupal-nginx).
 
