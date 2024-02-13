#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/../runtime/detect_environment.sh

echo -e "\n*** Install user tools ***"

DEBIAN_FRONTEND=noninteractive \
DEBCONF_NONINTERACTIVE_SEEN=true \
TZ=Etc/UTC \
$SUDO apt-get install -yqq \
    bash \
    emacs \
    gnuplot \
    isc-dhcp-server \
    libcgi-pm-perl \
    lxpanel \
    python3-matplotlib \
    python3-numpy \
    python3-scipy \
    python3-serial \
    tmux \
    tigervnc-standalone-server \
    vim
