include docker.mk

.PHONY: test

DRUPAL_VER ?= 9
PHP_VER ?= 8.0

test:
	cd ./tests/$(DRUPAL_VER) && PHP_VER=$(PHP_VER) ./run.sh
