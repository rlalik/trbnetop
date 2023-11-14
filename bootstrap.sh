#!/bin/bash

njobs=

[ -d $PANDA_TRB_DISTDIR/venv ] || virtualenv $PANDA_TRB_DISTDIR/venv

if $TRB_DOCKER_ENV; then
    true
else
    . ./build_files/scripts/environment.sh
    [ -n "$1" ] && njobs=$1
fi

echo "*** Running make with $njobs jobs ***"

mkdir -p $PANDA_TRB_DISTDIR

./build_files/scripts/install_root.sh

./build_files/scripts/install_trb3.sh

./build_files/scripts/install_trbnettools.sh

./build_files/scripts/install_daqtools.sh

./build_files/scripts/install_pasttrectools.sh

##################################################
##                  post build                  ##
##################################################

echo "*** Post build ***"

if $TRB_DOCKER_ENV; then
    true
else
    . $PANDA_TRB_BASEDIR/build_files/bash_aliases
fi
