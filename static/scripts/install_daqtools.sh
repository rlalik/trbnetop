#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/../runtime/environment.sh

[ -n "$1" ] && njobs=$1

mkdir -p $TRBOP_DISTDIR

##################################################
##                   daqtools                   ##
##################################################

echo -e "\n*** Prepare daqtools using $njobs jobs ***"

cd $TRBOP_DISTDIR

if [ ! -d daqtools ]; then
    git clone git://jspc29.x-matter.uni-frankfurt.de/projects/daqtools.git

    cd $TRBOP_DISTDIR/daqtools

    git checkout $DAQTOOLS_COMMIT
else
    cd $TRBOP_DISTDIR/daqtools

    git checkout $DAQTOOLS_COMMIT
    git pull
fi

cd $TRBOP_DISTDIR/daqtools/xml-db
./xml-db.pl

##################################################
##                  post build                  ##
##################################################

echo -e "\n*** Post build ***"

### replace httpi with a modified version, because the httpi in daqtools won't run as root
cp -v $TRBOP_BASEDIR/static/httpi $TRBOP_DISTDIR/daqtools/web/httpi
