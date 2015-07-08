#
# start with an ubuntu 15.10 image
#
FROM    ubuntu:15.10

#
# helpful metadata
#
MAINTAINER Richard.Sugg@sas.com
LABEL      com.sas.it.for=espy com.sas.it.desc="demo for espy"

#
# install software
#
RUN apt-get update -y
RUN apt-get install -y \
        build-essential \
        curl \
        cpanminus

#
# install perl modules
#
RUN cpanm --notest \
        Readonly \
        DateTime


#
# add your code
#
ADD     ./src /src/

#
# optional - create and configure a user
#
RUN     chmod +x /src/*.sh /src/*.pl; \
           mkdir -p /src/log /src/tmp; \
           groupadd ssodocker; \
           useradd -m -g ssodocker ssodocker ; \
           chown ssodocker:ssodocker /src/log /src/tmp

COPY   ./src/bashrc /home/ssodocker/.bashrc

USER   ssodocker

#
# set your working directory
#
WORKDIR /src

#
# what to run when container starts
#
ENTRYPOINT /src/entrypoint.sh
