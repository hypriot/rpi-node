IMAGENAME := $(shell basename `git rev-parse --show-toplevel`)
VERSION :=$(shell cat VERSION)
VERSION_MINOR :=$(shell cat VERSION | cut -d "." -f 1-2)
VERSION_MAJOR :=$(shell cat VERSION | cut -d "." -f 1)
NAMESPACE := hypriot

default: dockerbuild

test:
	docker run --rm $(NAMESPACE)/$(IMAGENAME) --help

version:
	docker run --rm $(NAMESPACE)/$(IMAGENAME) --version

dockerbuild:
	docker build -t $(NAMESPACE)/$(IMAGENAME) .
	docker tag -f $(NAMESPACE)/$(IMAGENAME):latest hypriot/rpi-node:$(VERSION)
	docker tag -f $(NAMESPACE)/$(IMAGENAME):latest hypriot/rpi-node:$(VERSION_MAJOR)
	docker tag -f $(NAMESPACE)/$(IMAGENAME):latest hypriot/rpi-node:$(VERSION_MINOR)
	docker build -t $(NAMESPACE)/$(IMAGENAME):onbuild onbuild
	docker tag -f $(NAMESPACE)/$(IMAGENAME):onbuild hypriot/rpi-node:$(VERSION)-onbuild
	docker tag -f $(NAMESPACE)/$(IMAGENAME):onbuild hypriot/rpi-node:$(VERSION_MAJOR)-onbuild
	docker tag -f $(NAMESPACE)/$(IMAGENAME):onbuild hypriot/rpi-node:$(VERSION_MINOR)-onbuild
	docker build -t $(NAMESPACE)/$(IMAGENAME):slim slim
	docker tag -f $(NAMESPACE)/$(IMAGENAME):slim hypriot/rpi-node:$(VERSION)-slim
	docker tag -f $(NAMESPACE)/$(IMAGENAME):slim hypriot/rpi-node:$(VERSION_MAJOR)-slim
	docker tag -f $(NAMESPACE)/$(IMAGENAME):slim hypriot/rpi-node:$(VERSION_MINOR)-slim
	docker build -t $(NAMESPACE)/$(IMAGENAME):wheezy wheezy
	docker tag -f $(NAMESPACE)/$(IMAGENAME):wheezy hypriot/rpi-node:$(VERSION)-wheezy
	docker tag -f $(NAMESPACE)/$(IMAGENAME):wheezy hypriot/rpi-node:$(VERSION_MAJOR)-wheezy
	docker tag -f $(NAMESPACE)/$(IMAGENAME):wheezy hypriot/rpi-node:$(VERSION_MINOR)-wheezy

testimg:
	docker rm -f new-$(IMAGENAME) || true
	docker run -d --name new-$(IMAGENAME) $(NAMESPACE)/$(IMAGENAME):latest
	docker inspect -f '{{.NetworkSettings.IPAddress}}' new-$(IMAGENAME)
	docker logs -f new-$(IMAGENAME)

push:
	# push VERSION
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION_MAJOR)
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION_MINOR)
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)-onbuild
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION_MAJOR)-onbuild
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION_MINOR)-onbuild
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)-slim
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION_MAJOR)-slim
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION_MINOR)-slim
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)-wheezy
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION_MAJOR)-wheezy
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION_MINOR)-wheezy
	# push latest
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):latest
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):onbuild
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):slim
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):wheezy
