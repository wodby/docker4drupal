.PHONY: all
MAKEFLAGS += --silent

include .env

# Executable
WORKSPACE:=$(shell pwd)
CURRENT_COMMIT=$(shell git rev-parse HEAD)
CMD_DOCKER_COMPOSE=docker-compose -p $(PROJECT_NAME)
CMD_DOCKER_COMPOSE_WEB=$(CMD_DOCKER_COMPOSE) exec php
CMD_DOCKER_COMPOSE_DB=$(CMD_DOCKER_COMPOSE) exec mariadb

DRUPAL_VER ?= 9
PHP_VER ?= 8.0

.PHONY: test

test:
	cd ./tests/$(DRUPAL_VER) && PHP_VER=$(PHP_VER) ./run.sh
install:
	make up
	make composer-install
	make local-settings
	make local-install
up:
	$(CMD_DOCKER_COMPOSE) up -d
down:
	$(CMD_DOCKER_COMPOSE) down
restart:
	make down
	make up
destroy:
	make down
	sudo rm -rf web
	git checkout web
ssh-php: # connexion container php
	$(CMD_DOCKER_COMPOSE_WEB) /bin/bash
ssh-db: # connexion container php
	$(CMD_DOCKER_COMPOSE_DB) /bin/bash
composer-install:
	$(CMD_DOCKER_COMPOSE_WEB) ./composer.sh install
composer-require:
	$(CMD_DOCKER_COMPOSE_WEB) ./composer.sh require
local-settings:
	$(CMD_DOCKER_COMPOSE_WEB) ./local.sh
local-install:
	$(CMD_DOCKER_COMPOSE_WEB) ./install.sh