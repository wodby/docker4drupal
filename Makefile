include docker.mk

.PHONY: test

DRUPAL_VER ?= 11
PHP_VER ?= 8.3

test:
	cd ./tests/$(DRUPAL_VER) && PHP_VER=$(PHP_VER) ./run.sh
