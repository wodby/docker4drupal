# Docker for Mac Performance

There 2 ways how can improve [performance](https://github.com/Wodby/docker4drupal/issues/4) of docker volumes on macOS:

## 1. User-guided Caching

Since Docker for Mac 17.06 there's a new `:cached` option available for volumes. You can find more information about this in [docker blog](https://blog.docker.com/2017/05/user-guided-caching-in-docker-for-mac/).

### Usage

Replace _codebase_ volume definition of _php_ and _nginx_/_apache_ services with the option below marked as "User-guided caching". 

## 2. Docker-sync

The core idea of this project is to use an external volume that will sync your files with a file synchronizer tool.

### Installation

```bash
$ gem install docker-sync
```

### Usage

1. Uncomment _docker-sync_ volume definition in your compose file
2. Replace _volumes_ definition of _php_ and _nginx_/_apache_ services with the option below marked as "Docker-sync".
3. Start docker-sync: `docker-sync start`
4. In a new shell run after you started docker-sync `docker-compose up -d`

Now when you change your code on the host machine docker-sync will sync your data to php and nginx/apache containers.

For more information visit [docker-sync project page](https://github.com/EugenMayer/docker-sync/).
