#!/bin/bash

if $TRB_DOCKER_ENV; then
    true
else
    . /scripts/environment.sh
    [ -n "$1" ] && njobs=$1
fi

mkdir -p $PANDA_TRB_DISTDIR


##################################################
##                pasttrectools                 ##
##################################################

echo "*** Prepare pasttrectools using $njobs jobs ***"

cd $PANDA_TRB_DISTDIR/

git clone https://github.com/HADES-Cracovia/pasttrectools

cd pasttrectools

pip install .
