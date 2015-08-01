#
# start with an ubuntu 15.10 image
#
FROM    ubuntu:15.10

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
           groupadd mydocker; \
           useradd -m -g mydocker mydocker ; \
           rm -f $APP_DIR/log/* $APP_DIR/tmp/*; \
           chown mydocker:mydocker $APP_DIR/log $APP_DIR/tmp

COPY   .$APP_DIR/bashrc /home/mydocker/.bashrc

USER   mydocker

#
# set your working directory
#
WORKDIR $APP_DIR

#
# what to run when container starts
#
ENTRYPOINT $APP_DIR/entrypoint.sh
