#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/../runtime/environment.sh

[ -n "$1" ] && njobs=$1

mkdir -p $PANDA_TRB_DISTDIR

##################################################
##                   daqtools                   ##
##################################################

echo -e "\n*** Prepare daqtools using $njobs jobs ***"

cd $PANDA_TRB_DISTDIR

git clone git://jspc29.x-matter.uni-frankfurt.de/projects/daqtools.git

cd $PANDA_TRB_DISTDIR/daqtools
git checkout $DAQTOOLS_COMMIT

cd $PANDA_TRB_DISTDIR/daqtools/xml-db
./xml-db.pl

##################################################
##                  post build                  ##
##################################################

echo -e "\n*** Post build ***"

### replace httpi with a modified version, because the httpi in daqtools won't run as root
cp -v $PANDA_TRB_BASEDIR/data/httpi $PANDA_TRB_DISTDIR/daqtools/web/httpi
