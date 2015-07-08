info:
	@echo "Usage info"
	@echo "make build              Build a fresh docker image"
	@echo "make shell ENV=<env>    Start container in shell"

.PHONY: build clean

build:
	docker build -t espy-docker .

shell:
	docker run --rm -it \
	    --entrypoint /bin/bash \
	    -v $$PWD/$$ENV.env.sh:/env.sh \
	    -v $$PWD/src:/src \
	    espy-docker

run:
	docker run  \
	    -d \
	    -v $$PWD/$$ENV.env.sh:/env.sh \
	    espy-docker
