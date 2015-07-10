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
	    -v /var/lib/docker:/var/lib/docker \
	    -p 8080:8080 \
	    --user root \
	    espy-docker

run:
	docker run  \
	    -d \
	    --hostname espy-docker \
	    --name espy-docker1 \
	    -p 8080:8080 \
	    --log-opt tag=espy-docker1 \
	    -v $$PWD/$$ENV.env.sh:/env.sh \
	    espy-docker
