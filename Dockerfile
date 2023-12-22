##################################################
##        get minimal distro from cloud         ##
##################################################

FROM ubuntu:22.04

##################################################
##                prerequisites                 ##
##################################################

ENV TRB_DOCKER_ENV=1

ENV PIP_ROOT_USER_ACTION=ignore

##################################################
##                    build                     ##
##################################################

# For ubuntu systems to speed up instalaltion on can use host cache
#RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
#RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
#    --mount=type=cache,target=/var/lib/apt,sharing=locked \
#    --mount=type=bind,source=system_update.sh,target=/system_update.sh \
#    /system_update.sh

ARG LAST_SYSTEM_DATE=unknown

# This is general for any system
RUN --mount=type=bind,source=data/,target=/data \
    /data/scripts/system_update.sh

RUN --mount=type=bind,source=data/,target=/data \
    /data/scripts/system_build_tools.sh

RUN echo "dash dash/sh boolean false" | debconf-set-selections && \
    dpkg-reconfigure -p critical dash

ARG LAST_BUILD_DATE=unknown

RUN --mount=type=bind,source=data/,target=/data \
    . /data/runtime/environment.sh && \
    mkdir -p $PANDA_TRB_DISTDIR/ && \
    /data/scripts/install_root.sh && \
    . $ROOTSYS/bin/thisroot.sh && \
    /data/scripts/install_trb3.sh && \
    . $PANDA_TRB_DISTDIR/trb3/trb3login && \
    /data/scripts/install_trbnettools.sh && \
    /data/scripts/install_daqtools.sh && \
    /data/scripts/install_pasttrectools.sh

RUN --mount=type=bind,source=data/,target=/data \
    /data/scripts/system_user_tools.sh

## cleanup of files from setup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

##################################################
##                  post build                  ##
##################################################

COPY data/bash_aliases /root/.bash_aliases

COPY data/runtime /runtime

RUN echo "System installed on $LAST_SYSTEM_DATE"
RUN echo "Last tools build on $LAST_BUILD_DATE"
