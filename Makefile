include boilerplate.mk

.PHONY: test

DRUPAL_VER ?= 8
PHP_VER ?= 7.1

default: test

test:
	cd ./test/$(DRUPAL_VER)/$(PHP_VER) && ./run
