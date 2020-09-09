include docker.mk

.PHONY: test

DRUPAL_VER ?= 9
PHP_VER ?= 7.4

test:
	cd ./tests/$(DRUPAL_VER) && PHP_VER=$(PHP_VER) ./run.sh
