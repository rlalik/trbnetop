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
    tmux \
    tigervnc-standalone-server \
    vim

#     rsyslog \
#     xterm screen xvfb x11vnc tigervnc-tools tigervnc-viewer tigervnc-standalone-server openbox \
#     cmake gcc g++ gfortran binutils \
#     rpcbind iptables \
#     net-tools iputils-ping \
#     git subversion perl \
#     libxml-libxml-perl libfile-chdir-perl libtimedate-perl libterm-readline-perl-perl \
#     libdata-treedumper-perl \
#     libntirpc-dev libcgi-pm-perl \
#     firefox \
#     imagemagick libgraphviz-dev mesa-common-dev \
#     htop psmisc \
#     ncdu \
#     libx11-dev libxpm-dev libxft-dev libxext-dev libglu1-mesa-dev libglew-dev \
#     libpcre2-dev libxml2-dev libkrb5-dev libgsl-dev \
#     libcurl4-openssl-dev libldap-dev libfftw3-dev libcfitsio-dev \
#     patch pkg-config \
#     libmysqlclient-dev \
#     libboost-dev \
#     python3-pip python3-prettytable python3-dialog \
#     python3-dev python3-setuptools python3-numpy
