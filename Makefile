include env_make

NS = earvin
VERSION ?= latest

REPO = blog
NAME = blog
INSTANCE = default

.PHONY: build push shell run start stop logs rm release dev ssh

deps:
	gem update --no-ri --no-rdoc && gem install bundler io-console && bundler install

build:
	docker build -t $(NS)/$(REPO):$(VERSION) .

push:
	docker push $(NS)/$(REPO):$(VERSION)

shell:
	docker run --rm --name $(NAME)-$(INSTANCE) -i -t $(PORTS) $(ENV) $(NS)/$(REPO):$(VERSION) /bin/bash

run:
	docker run --rm --name $(NAME)-$(INSTANCE) $(PORTS)  $(ENV) $(NS)/$(REPO):$(VERSION)

start:
	docker run -d --label=jekyll --name $(NAME)-$(INSTANCE)  $(PORTS) $(ENV) $(NS)/$(REPO):$(VERSION)

stop:
	docker stop $(NAME)-$(INSTANCE)

rm:
	docker rm -f $(NAME)-$(INSTANCE)

release: build
	make push -e VERSION=$(VERSION)

dev:
	rm -rf _site
	docker build -t $(NS)/$(REPO)-dev -f Dockerfile.dev .
	docker run -d $(NS)/$(REPO)-dev -p "3000:3000" -v `pwd`:/usr/share/nginx/html/ 


logs:
	docker logs $(NAME)-$(INSTANCE)

ssh:
	docker exec -i -t $(NAME)-$(INSTANCE) /bin/bash

default: build
