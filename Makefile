-include env_make

.PHONY: test

drupal ?= 8
php ?= 7.1
tag ?= 2.0.0

default: test

test:
	cd ./test/$(drupal)/$(php) && TAG=$(tag) ./run.sh
