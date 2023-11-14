##################################################
##        get minimal distro from cloud         ##
##################################################

FROM ubuntu:22.04

##################################################
##                prerequisites                 ##
##################################################

ENV DABC_TRB3_REV=HEAD
ENV TRBNET_COMMIT=master
ENV DAQTOOLS_COMMIT=master

ENV PATH=$PATH:/dist/trbnettools/bin
ENV ROOTSYS=/dist/cern/root

ENV PIP_ROOT_USER_ACTION=ignore
ENV PANDA_TRB_DISTDIR=/dist

ENV TRB_DOCER_ENV=1

##################################################
##                    build                     ##
##################################################

RUN mkdir -p $PANDA_TRB_DISTDIR

# For ubuntu systemsto speed up instalaltion on can use host cache
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

COPY build_files /build_files

RUN --mount=type=bind,source=build_files/scripts,target=/scripts \
    /scripts/install_root.sh && \
    /scripts/install_trb3.sh && \
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
