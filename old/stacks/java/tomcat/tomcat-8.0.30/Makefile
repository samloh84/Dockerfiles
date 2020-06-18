ORG="samuelloh"
NAME="tomcat"
VERSION="tomcat-8.0.28"
REGISTRY?=localhost:5000
TAGS="latest"

.PHONY: all build tag push

all: build tag

build:
	docker build -t $(ORG)/$(NAME):$(VERSION) .

tag:
	@for TAG in $(TAGS); do \
		docker tag -f $(ORG)/$(NAME):$(VERSION) $(ORG)/$(NAME):$(TAG); \
	done

push:
	docker tag -f $(ORG)/$(NAME):$(VERSION) $(REGISTRY)/$(NAME):$(VERSION)
	docker push $(REGISTRY)/$(NAME):$(VERSION)
	for TAG in $(TAGS); do \
		docker tag -f $(ORG)/$(NAME):$(VERSION) $(REGISTRY)/$(NAME):$(TAG); \
		docker push $(REGISTRY)/$(NAME):$(TAG); \
	done

