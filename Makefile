info:
	@echo "Usage info"
	@echo "  make build              Build a fresh docker image"
	@echo "  make shell ENV=<env>    Start a container in shell"
	@echo "  make run ENV=<env>      Run a container"

.PHONY: build

build:
	docker build -t espy-docker .

shell:
	docker run --rm -it \
	    --entrypoint /bin/bash \
	    -v $$PWD/$$ENV.env.sh:/env.sh \
	    -v $$PWD/src:/src \
	    -v /var/lib/docker:/var/lib/docker \
	    -p 8080:8080 \
	    espy-docker

run:
	docker run  \
	    -d \
	    --hostname espy-docker \
	    --name espy-docker \
	    -p 8080:8080 \
	    -v $$PWD/$$ENV.env.sh:/env.sh \
	    espy-docker
