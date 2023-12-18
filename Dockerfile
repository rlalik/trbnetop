##################################################
##        get minimal distro from cloud         ##
##################################################

FROM ubuntu:22.04

##################################################
##                prerequisites                 ##
##################################################

ENV TRB_DOCER_ENV=1

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

# This is general for any system
RUN --mount=type=bind,source=build_files/scripts,target=/scripts \
    /scripts/system_update.sh

RUN --mount=type=bind,source=build_files/scripts,target=/scripts \
    /scripts/system_build_tools.sh

RUN echo "dash dash/sh boolean false" | debconf-set-selections && \
    dpkg-reconfigure -p critical dash

RUN --mount=type=bind,source=build_files/scripts,target=/scripts \
    --mount=type=bind,source=build_files,target=/build_files \
    . /scripts/environment.sh && \
    mkdir -p $PANDA_TRB_DISTDIR/ && \
    /scripts/install_root.sh && \
    . $ROOTSYS/bin/thisroot.sh && \
    /scripts/install_trb3.sh && \
    . $PANDA_TRB_DISTDIR/trb3/trb3login && \
    /scripts/install_trbnettools.sh && \
    /scripts/install_daqtools.sh && \
    /scripts/install_pasttrectools.sh

RUN --mount=type=bind,source=build_files/scripts,target=/scripts \
    /scripts/system_user_tools.sh

## cleanup of files from setup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

##################################################
##                  post build                  ##
##################################################

COPY build_files/bash_aliases /root/.bash_aliases

COPY runtime /runtime
