include docker.mk

.PHONY: test

DRUPAL_VER ?= 8
PHP_VER ?= 7.1

test:
	cd ./test/$(DRUPAL_VER) && PHP_VER=$(PHP_VER) ./run
