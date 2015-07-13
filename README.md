## What is Docker?

Docker is a pretty face on linux containers (LXC). LXC can be thought of as chroot on steroids. An LXC container has its users and process table mapped to the host, but will little or no access to the host itself. The container maintainer may share as little or as much between the container and host as appropriate.


## Why Use Containers?

_"It works in dev and test. I don't know why it doesn't work in prod."_

* A container allows you to bundle all dependencies in a single image.
* Anything that differs from one environment to another should be controlled by an environment variable.
    * The image that runs in dev/test is the same image that runs in prod.
    * The only difference will be the environment variables.
* A container should do one thing, one thing only.
    * One process per container
    * If you think you need supervisord, you're doing it wrong.

In other words, the host on which it runs becomes cattle. You only need a server that runs docker.

## Overview of Using Docker

#### setting up

* Docker images are similar to raw/iso/ami files. A docker container is similar to a running VM. The first is a template, the second is an instance of the template.
* Since docker requires certain Linux kernel features, using docker on Mac and Windows requires running a small VM in something like VirtualBox.
* You may then use the docker client natively from your mac or pc to communicate to the docker host vm.
* See https://docs.docker.com/ to install docker and docker-machine locally.


#### Build the image

An image is build from a Dockerfile, which

* Identifies a base image (i.e, ubuntu, centos, debian)
* Software to be installed
* How the image is then configured
* What (if any) commands to run when the container starts.

All of this is done without modifying the host.

```docker build -t espy-docker .```

Our image could be a web application, an itdeploy daemon, or a one-off script.

#### Run a container from the image

A container runs an image.

```docker run -d espy-docker```


## Docker Workflow

1. Create an env.sh file that contains all the environment-specific values.
1. Create an entrypoint.sh script that sources the env.sh file before running your actual application.
1. Build the image
1. Start an emphemeral container and mount the env.sh file and your source code directory. You can now make changes to the source from your local machine, but run it inside the docker container. You can now interactively edit and test your code.

It is helpful to use a Makefile to build, run, and drop into a shell. The Makefile in this project has the following targets:

* ```make build``` - build the image and tag it as espy-docker
* ```make run ENV=[env]``` - run the image using the environment [env]
* ```make shell ENV=[env]``` - run an ephemeral, interactive image using the environment [env]

The targets run and shell will both look for a file named [env].env.sh and mount it as /env.sh. For instance, if you specify ENV=dev, there should be a file named dev.env.sh in the project's root directory. The shell target will also mount the src directory on /src.


## What's the Catch?

* Logging - best to send to syslog and collect from there
* Monitoring - docker api is good, but google's cadvisor is probably be better
* Resiliency and scaling - requires a management layer like kubernetes or mesos
* Config management - requires etcd, consul, vault, etc.
