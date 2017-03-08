# Fixing Permissions Problems

To avoid potential permissions problems between host machine and containers you can add a user/group on your host machine with ID 82, it's the same ID that www-data user/group has in Alpine Linux.

## Linux

Create a new group with ID 82 and add yourself to this group.

```bash
sudo groupadd -r -g 82 alpine-www-data
sudo usermod -a -G alpine-www-data $(id -un)
```

## macOS

On macOS group with 82 already exists (_clamav). 

```bash
sudo dseditgroup -o edit -a $(id -un) -t user _clamav
```

## Windows

TBD

