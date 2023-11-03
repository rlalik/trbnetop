#!/bin/bash

if $TRB_DOCKER_ENV; then
    echo "I'm inside matrix ;(";
else
    . scripts/environment.sh
    [ -n "$1" ] && njobs=$1
fi

echo "*** Running make with $njobs jobs ***"

mkdir -p $PANDA_TRB_DISTDIR


##################################################
##                pasttrectools                 ##
##################################################

echo "*** Prepare pasttrectools ***"

cd $PANDA_TRB_DISTDIR/
[ -d pasttrectools ] || \
{
    git clone https://github.com/HADES-Cracovia/pasttrectools

    cd pasttrectools
    git checkout trb_3_5_merge

    pip install .
}
