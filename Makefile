IMAGENAME := $(shell basename `git rev-parse --show-toplevel`)
VERSION :=$(shell cat VERSION)
VERSION_MINOR :=$(shell cat VERSION | cut -d "." -f 1-2)
VERSION_MAJOR :=$(shell cat VERSION | cut -d "." -f 1)
NAMESPACE := hypriot

default: dockerbuild push

test:
	docker run --rm $(NAMESPACE)/$(IMAGENAME) --help
        
version:
	docker run --rm $(NAMESPACE)/$(IMAGENAME) --version

dockerbuild:
	echo docker build -t $(NAMESPACE)/$(IMAGENAME) .
	echo docker tag -f $(NAMESPACE)/$(IMAGENAME):latest hypriot/rpi-node:$(VERSION)
	echo docker tag -f $(NAMESPACE)/$(IMAGENAME):latest hypriot/rpi-node:$(VERSION_MAJOR)
	echo docker tag -f $(NAMESPACE)/$(IMAGENAME):latest hypriot/rpi-node:$(VERSION_MINOR)
	echo docker build -t $(NAMESPACE)/$(IMAGENAME):$(VERSION)-onbuild onbuild
	echo docker tag -f $(NAMESPACE)/$(IMAGENAME):$(VERSION)-onbuild hypriot/rpi-node:$(VERSION_MAJOR)-onbuild
	echo docker tag -f $(NAMESPACE)/$(IMAGENAME):$(VERSION)-onbuild hypriot/rpi-node:$(VERSION_MINOR)-onbuild
	echo docker build -t $(NAMESPACE)/$(IMAGENAME):$(VERSION)-slim slim
	echo docker tag -f $(NAMESPACE)/$(IMAGENAME):$(VERSION)-slim hypriot/rpi-node:$(VERSION_MAJOR)-slim
	echo docker tag -f $(NAMESPACE)/$(IMAGENAME):$(VERSION)-slim hypriot/rpi-node:$(VERSION_MINOR)-slim
	echo docker build -t $(NAMESPACE)/$(IMAGENAME):$(VERSION)-wheezy wheezy
	echo docker tag -f $(NAMESPACE)/$(IMAGENAME):$(VERSION)-wheezy hypriot/rpi-node:$(VERSION_MAJOR)-wheezy
	echo docker tag -f $(NAMESPACE)/$(IMAGENAME):$(VERSION)-wheezy hypriot/rpi-node:$(VERSION_MINOR)-wheezy

testimg:
	docker rm -f new-$(IMAGENAME) || true
	docker run -d --name new-$(IMAGENAME) $(NAMESPACE)/$(IMAGENAME):latest
	docker inspect -f '{{.NetworkSettings.IPAddress}}' new-$(IMAGENAME)
	docker logs -f new-$(IMAGENAME)

push:
	# push VERSION
	echo docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)
	echo docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION_MAJOR)
	echo docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION_MINOR)
	echo docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)-onbuild
	echo docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION_MAJOR)-onbuild
	echo docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION_MINOR)-onbuild
	echo docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)-slim
	echo docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION_MAJOR)-slim
	echo docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION_MINOR)-slim
	echo docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)-wheezy
	echo docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION_MAJOR)-wheezy
	echo docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION_MINOR)-wheezy
	# push latest
	echo docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):latest
	echo docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):onbuild
	echo docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):slim
	echo docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):wheezy
