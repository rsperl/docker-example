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
        DateTime \
        Mojolicious

ENV APP_DIR=/src

#
# add your code
#
ADD     ./src $APP_DIR

#
# optional - create and configure a user
#
RUN     chmod +x $APP_DIR/*.sh $APP_DIR/*.pl; \
           mkdir -p $APP_DIR/log $APP_DIR/tmp; \
           groupadd ssodocker; \
           useradd -m -g ssodocker ssodocker ; \
           rm -f $APP_DIR/log/* $APP_DIR/tmp/*; \
           chown ssodocker:ssodocker $APP_DIR/log $APP_DIR/tmp

COPY   .$APP_DIR/bashrc /home/ssodocker/.bashrc

USER   ssodocker

#
# set your working directory
#
WORKDIR $APP_DIR

#
# what to run when container starts
#
ENTRYPOINT $APP_DIR/entrypoint.sh
