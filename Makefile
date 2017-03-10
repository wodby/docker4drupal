-include env_make

.PHONY: test

drupal ?= 8
php ?= 7.1

default: test

test:
	cd ./test/$(drupal)/$(php) && ./run.sh
