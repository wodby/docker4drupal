To fix Docker [poor performance](https://github.com/Wodby/docker4drupal/issues/4) on macOS use the following workaround based on [docker-sync project](https://github.com/EugenMayer/docker-sync/). The core idea is to replace a standard slow volume with a file synchronizer tool like unison (used by default) or rsync.

### Installation

```
gem install docker-sync
brew install fswatch
```

### Usage

1. Uncomment _docker-sync-unison_ volume definition in your compose file
2. Replace volume for _php_ and _nginx_ services to _docker-sync-unison_ (uncomment and delete the current one)
3. Start the synchronization with `docker-sync start --daemon` and let docker-sync run in the background
4. In a new shell run after you started docker-sync `docker-compose up -d`

Now when you change your code and it will all end up in php and nginx containers.

For more information visit [docker-sync project page](https://github.com/EugenMayer/docker-sync/).