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
##                     trb3                     ##
##################################################

echo "*** Prepare trb3 ***"

cd $PANDA_TRB_DISTDIR

svn checkout -r $DABC_TRB3_REV https://subversion.gsi.de/dabc/trb3

cd $PANDA_TRB_DISTDIR/trb3
sed -e "s/^source /. /g" -i $PANDA_TRB_DISTDIR/trb3/Makefile
make -j$njobs compile
