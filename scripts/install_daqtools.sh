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
##                   daqtools                   ##
##################################################

echo "*** Prepare daqtools ***"

cd $PANDA_TRB_DISTDIR
[ -d daqtools ] || \
{
    git clone git://jspc29.x-matter.uni-frankfurt.de/projects/daqtools.git

    cd $PANDA_TRB_DISTDIR/daqtools
    git checkout $DAQTOOLS_COMMIT

    cd $PANDA_TRB_DISTDIR/daqtools/xml-db
    ./xml-db.pl
}

##################################################
##                  post build                  ##
##################################################

echo "*** Post build ***"

### replace httpi with a modified version, because the httpi in daqtools won't run as root
cp -v $PANDA_TRB_BASEDIR/build_files/httpi $PANDA_TRB_DISTDIR/daqtools/web/httpi
