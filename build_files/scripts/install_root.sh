#!/bin/bash

if $TRB_DOCKER_ENV; then
    true
else
    . scripts/environment.sh
    [ -n "$1" ] && njobs=$1
fi

echo "*** Running make with $njobs jobs ***"

mkdir -p $PANDA_TRB_DISTDIR

##################################################
##                  CERN's ROOT                 ##
##################################################

echo "*** Prepare ROOT ***"

ROOT_FILE=root_v6.30.02.Linux-ubuntu22.04-x86_64-gcc11.4.tar.gz

mkdir -p $PANDA_TRB_DISTDIR/cern
cd $PANDA_TRB_DISTDIR/cern

[ -f $ROOT_FILE ] || wget --quiet https://root.cern/download/$ROOT_FILE
tar -xzf $ROOT_FILE
