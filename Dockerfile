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

WORKDIR /app

ARG LAST_SYSTEM_DATE=unknown

# This is general for any system
RUN --mount=type=bind,source=static/,target=/app/static \
    /app/static/scripts/system_update.sh && \
    /app/static/scripts/system_build_tools.sh && \
    echo "dash dash/sh boolean false" | debconf-set-selections && \
    dpkg-reconfigure -p critical dash

ARG LAST_BUILD_DATE=unknown

RUN --mount=type=bind,source=static/,target=/app/static \
    . /app/static/runtime/environment.sh && \
    mkdir -p $TRBOP_DISTDIR/ && \
    /app/static/scripts/install_root.sh && \
    . $ROOTSYS/bin/thisroot.sh && \
    /app/static/scripts/install_trb3.sh && \
    . $TRBOP_DISTDIR/trb3/trb3login && \
    /app/static/scripts/install_trbnettools.sh && \
    /app/static/scripts/install_daqtools.sh && \
    /app/static/scripts/install_pasttrectools.sh && \
    /app/static/scripts/system_user_tools.sh

ARG FORCE_UPDATE=unknown

RUN --mount=type=bind,source=static/,target=/app/static \
    . /app/static/runtime/environment.sh && \
    . $ROOTSYS/bin/thisroot.sh && \
    /app/static/scripts/install_trb3.sh && \
    . $TRBOP_DISTDIR/trb3/trb3login && \
    /app/static/scripts/install_trbnettools.sh && \
    /app/static/scripts/install_daqtools.sh && \
    /app/static/scripts/install_pasttrectools.sh && \
    /app/static/scripts/system_user_tools.sh

## cleanup of files from setup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

##################################################
##                  post build                  ##
##################################################

COPY static/bash_aliases /root/.bash_aliases

COPY static/runtime /app/static/runtime

RUN echo "System installed on $LAST_SYSTEM_DATE" && \
    echo "Last tools build on $LAST_BUILD_DATE" && \
    echo "Last update on      $FORCE_UPDATE"
