#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/../runtime/environment.sh

[ -n "$1" ] && njobs=$1

mkdir -p $TRBOP_DISTDIR

##################################################
##                     trb3                     ##
##################################################

echo -e "\n*** Prepare trb3 using $njobs jobs ***"

cd $TRBOP_DISTDIR

if [ ! -d trb3 ]; then
    svn checkout -q -r $DABC_TRB3_REV https://subversion.gsi.de/dabc/trb3
    cd $TRBOP_DISTDIR/trb3

    sed -e "s/^source /. /g" -i $TRBOP_DISTDIR/trb3/Makefile
else
    cd $TRBOP_DISTDIR/trb3
fi

make -j$njobs compile
