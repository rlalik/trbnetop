#!/bin/bash

njobs=

if [ -n "${TRB_DOCKER_ENV+x}" ]; then
    echo "DOCKER RUN"
    true
else
    echo "LOCAL RUN"
    . ./build_files/local/environment.sh
    [ -n "$1" ] && njobs=$1
fi

echo "*** Running bootstrap using $njobs jobs ***"

mkdir -p $PANDA_TRB_DISTDIR

./build_files/scripts/install_root.sh $njobs

./build_files/scripts/install_trb3.sh $njobs

. $PANDA_TRB_DISTDIR/trb3/trb3login

./build_files/scripts/install_trbnettools.sh $njobs

./build_files/scripts/install_daqtools.sh $njobs

./build_files/scripts/install_pasttrectools.sh $njobs

##################################################
##                  post build                  ##
##################################################

echo "*** Post build ***"

if $TRB_DOCKER_ENV; then
    true
else
    . $PANDA_TRB_BASEDIR/build_files/bash_aliases
fi
