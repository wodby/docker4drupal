include docker.mk

DRUPAL_VER ?= 11
PHP_VER ?= 8.5

test:
	cd ./tests/$(DRUPAL_VER) && PHP_VER=$(PHP_VER) ./run.sh
.PHONY: test

test-cms:
	cd ./tests/cms && ./run.sh
.PHONY: test-cms
