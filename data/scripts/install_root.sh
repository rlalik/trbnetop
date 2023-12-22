#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/../runtime/environment.sh

[ -n "$1" ] && njobs=$1

mkdir -p $PANDA_TRB_DISTDIR

##################################################
##                  CERN's ROOT                 ##
##################################################

echo -e "\n*** Prepare ROOT ***"

if ! command -v root-config &> /dev/null
then
    ROOT_FILE=root_v6.30.02.Linux-ubuntu22.04-x86_64-gcc11.4.tar.gz

    mkdir -p $PANDA_TRB_DISTDIR/cern
    cd $PANDA_TRB_DISTDIR/cern

    [ -f $ROOT_FILE ] || wget --quiet https://root.cern/download/$ROOT_FILE
    tar -xzf $ROOT_FILE
fi
