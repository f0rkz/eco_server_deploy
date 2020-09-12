.DEFAULT_GOAL := help
PACKAGE_NAME ?= eco_configs
TAG ?= latest
ECO_TAG ?= latest

help:
	@echo "This Makefile will interact with the Eco docker container and copy the server configuration files."
	@echo ""
	@echo "Targets:"
	@echo "  build            Builds the docker container"
	@echo "  copy_configs     Runs the container and copies the files"
	@echo "  clean            Cleans out the config and mod directories"
	@echo "  login            Enters the container for debugging"
	@echo "  deploy           Deploys the Eco server"
	@echo "  stop             Stops the Eco server"
	@echo "  update           Updates the Eco server"
	@echo ""

build:
	@docker build --build-arg ECO_TAG=${ECO_TAG} -t ${PACKAGE_NAME}:${TAG} .

clean: build
	docker run --rm -v $(CURDIR)/Configs:/Configs -v $(CURDIR)/Mods:/Mods -it ${PACKAGE_NAME}:${TAG} /usr/bin/clean.sh

copy_configs: build
	@docker run --rm \
		-v $(CURDIR)/Configs:/Configs \
		-v $(CURDIR)/Mods:/Mods \
		-v $(CURDIR)/conf.d:/conf.d \
		-v $(CURDIR)/mod.d:/mod.d \
		-it ${PACKAGE_NAME}:${TAG} \
		/usr/bin/copy_configs.sh

login: build
	@docker run --rm -v $(CURDIR)/Configs:/Configs -v $(CURDIR)/Mods:/Mods -it ${PACKAGE_NAME}:${TAG} /bin/bash

deploy:
	@docker-compose up -d

stop:
	@docker-compose down

update: stop
	@docker-compose pull
