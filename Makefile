IMAGENAME := $(shell basename `git rev-parse --show-toplevel`)
SHA := $(shell git rev-parse --short HEAD)
# Done in Dockerfile
#targz_file := $(shell cat FILEPATH)
timestamp := $(shell date +"%Y%m%d%H%M")
VERSION :=$(shell cat VERSION)
#NAMESPACE :=$(shell cat NAMESPACE)

default: dockerbuild push

test:
	docker run --rm $(NAMESPACE)/$(IMAGENAME) --help
        
version:
	docker run --rm $(NAMESPACE)/$(IMAGENAME) --version                

dockerbuild:
	docker build -t $(NAMESPACE)/$(IMAGENAME) 4.0
	docker tag -f $(NAMESPACE)/$(IMAGENAME):latest hypriot/rpi-node:$(VERSION)
	docker build -t $(NAMESPACE)/$(IMAGENAME)-onbuild 4.0/onbuild
	docker build -t $(NAMESPACE)/$(IMAGENAME)-slim 4.0/slim
	docker build -t $(NAMESPACE)/$(IMAGENAME)-wheezy 4.0/wheezy

testimg:
	docker rm -f new-$(IMAGENAME) || true
	docker run -d --name new-$(IMAGENAME) $(NAMESPACE)/$(IMAGENAME):latest
	docker inspect -f '{{.NetworkSettings.IPAddress}}' new-$(IMAGENAME)
	docker logs -f new-$(IMAGENAME)

push:
	# push VERSION
	docker tag -f $(NAMESPACE)/$(IMAGENAME):latest $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)
	docker tag -f $(NAMESPACE)/$(IMAGENAME)-onbuild $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)-onbuild
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)-onbuild
	docker tag -f $(NAMESPACE)/$(IMAGENAME)-slim $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)-slim
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)-slim
	docker tag -f $(NAMESPACE)/$(IMAGENAME)-wheezy $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)-wheezy
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):$(VERSION)-wheezy
	# push latest
	docker tag -f $(NAMESPACE)/$(IMAGENAME):latest $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):latest
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):latest
	docker tag -f $(NAMESPACE)/$(IMAGENAME)-onbuild $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):onbuild
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):onbuild
	docker tag -f $(NAMESPACE)/$(IMAGENAME)-slim $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):slim
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):slim
	docker tag -f $(NAMESPACE)/$(IMAGENAME)-wheezy $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):wheezy
	docker push $(REGISTRY_URL)/$(NAMESPACE)/$(IMAGENAME):wheezy
