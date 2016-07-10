include env_make

NS = earvin/blog
VERSION ?= latest

REPO = earvin
NAME = earvin
INSTANCE = default

.PHONY: build push shell run start stop logs rm release dev

deps:
	gem update --no-ri --no-rdoc && gem install jekyll pygments.rb rdiscount rouge --no-ri --no-rdoc

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
	jekyll serve --watch --source=blog --incremental

logs:
	docker logs $(NAME)-$(INSTANCE)

default: build
