DOCKER_PREFIX=myproject

start: up

install: docker-update up copy-config composer-install npm-install build-grunt build-reactjs fixtures

up: docker-up

stop: docker-stop

# Docker
docker-update:
	docker-compose -p $(DOCKER_PREFIX) pull

docker-up:
	docker-compose -p $(DOCKER_PREFIX) up -d

docker-stop:
	docker-compose -p $(DOCKER_PREFIX) stop

# Config
copy-config:
	cp ./src/config.php.docker ./src/config.php
	cp ./resources/reactjs/config/app/dev.config.json.docker ./resources/reactjs/config/app/dev.config.json
	cp ./behat.yml.docker ./behat.yml

# PHP
composer-install:
	docker exec -it $(DOCKER_PREFIX)_php_1 sh -c "composer install"

# JS
npm-install: npm-install-assets npm-install-reactjs

npm-install-assets:
	docker exec -it $(DOCKER_PREFIX)_node_1 sh -c "npm install"

npm-install-reactjs:
	docker exec -it $(DOCKER_PREFIX)_node_1 sh -c "cd resources/reactjs && npm install"

build: build-grunt build-reactjs

build-grunt:
	docker exec -it $(DOCKER_PREFIX)_node_1 sh -c "./node_modules/.bin/grunt dev"

build-reactjs:
	docker exec -it $(DOCKER_PREFIX)_node_1 sh -c "cd resources/reactjs && npm run webpack"

watch-grunt:
	docker exec -it $(DOCKER_PREFIX)_node_1 sh -c "./node_modules/.bin/grunt watch:less"

watch-reactjs:
	docker exec -it $(DOCKER_PREFIX)_node_1 sh -c "cd resources/reactjs && npm start"

test-reactjs:
	docker exec -it $(DOCKER_PREFIX)_node_1 sh -c "cd resources/reactjs && npm test"

# Fixtures
fixtures:
	docker exec -it $(DOCKER_PREFIX)_php_1 sh -c "./console mp:fixtures --use-cache -v"

fixtures-force:
	docker exec -it $(DOCKER_PREFIX)_php_1 sh -c "./console mp:fixtures -v"

# Workers
workers-reload:
	docker exec -it $(DOCKER_PREFIX)_workers_1 sh -c "supervisorctl -c /etc/supervisord.conf restart all"

# Shells
bash-php:
	docker exec -it $(DOCKER_PREFIX)_php_1 bash

bash-node:
	docker exec -it $(DOCKER_PREFIX)_node_1 bash

bash-db:
	docker exec -it $(DOCKER_PREFIX)_db_1 bash

# Help
help:
	@grep '^[^#[:space:]].*:' Makefile
