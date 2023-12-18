#!/bin/bash

if $TRB_DOCKER_ENV; then
    true
else
    . /scripts/environment.sh
fi

echo "*** Install build tools ***"

DEBIAN_FRONTEND=noninteractive \
DEBCONF_NONINTERACTIVE_SEEN=true \
TZ=Etc/UTC \
$SUDO apt-get install -yqq \
    cmake-curses-gui \
    git \
    g++ \
    libafterimage0 \
    libdata-treedumper-perl \
    libfile-chdir-perl \
    libtirpc-dev \
    libxml-libxml-perl \
    make \
    qt5-qmake \
    qtbase5-dev \
    patch \
    pip \
    pkg-config \
    subversion \
    wget
