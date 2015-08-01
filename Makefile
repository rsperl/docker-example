info:
	@echo "Usage info"
	@echo "  make build              Build a fresh docker image"
	@echo "  make shell ENV=<env>    Start a container in shell"
	@echo "  make run ENV=<env>      Run a container"

.PHONY: build

build:
	docker build -t my-docker .

shell:
	docker run --rm -it \
	    --entrypoint /bin/bash \
	    -v $$PWD/$$ENV.env.sh:/env.sh \
	    -v $$PWD/src:/src \
	    -p 8080:8080 \
	    my-docker

run:
	docker run  \
	    -d \
	    --hostname my-docker \
	    --name my-docker \
	    -p 8080:8080 \
	    -v $$PWD/$$ENV.env.sh:/env.sh \
	    my-docker
