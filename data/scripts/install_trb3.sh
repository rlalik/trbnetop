#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/../runtime/environment.sh

[ -n "$1" ] && njobs=$1

mkdir -p $PANDA_TRB_DISTDIR

##################################################
##                     trb3                     ##
##################################################

echo -e "\n*** Prepare trb3 using $njobs jobs ***"

cd $PANDA_TRB_DISTDIR

svn checkout -q -r $DABC_TRB3_REV https://subversion.gsi.de/dabc/trb3

cd $PANDA_TRB_DISTDIR/trb3
sed -e "s/^source /. /g" -i $PANDA_TRB_DISTDIR/trb3/Makefile
make -j$njobs compile
