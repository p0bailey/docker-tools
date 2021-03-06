#Authored by Phillip Bailey
.PHONY: all build terraform ansible
.SILENT:
SHELL := '/bin/bash'

USERNAME=p0bailey

IMAGE=docker-tools

BRANCH := $(shell git rev-parse --abbrev-ref HEAD)


all:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build:  ## Build docker image!
	docker build -t ${USERNAME}/${IMAGE} .

push:  ## push
	git add . && git commit -m "`date`" && git push origin $${BRANCH} || true

pull:  ## pull
	git pull origin $${BRANCH}

ansible:  ## ansible
	docker run --rm ${USERNAME}/${IMAGE} ansible --version

terraform:  ## ansible
	docker run --rm ${USERNAME}/${IMAGE} terraform --version

vault:  ## vault
	docker run --rm ${USERNAME}/${IMAGE} vault --version
