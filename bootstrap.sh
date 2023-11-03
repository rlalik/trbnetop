#!/bin/bash

njobs=

if $TRB_DOCKER_ENV; then
    echo "I'm inside matrix ;(";
else
    . scripts/environment.sh
    [ -n "$1" ] && njobs=$1
fi

echo "*** Running make with $njobs jobs ***"

mkdir -p $PANDA_TRB_DISTDIR

scripts/install_root.sh

scripts/install_trb3.sh

scripts/install_trbnettools.sh

scripts/install_daqtools.sh

scripts/install_pasttrectools.sh

##################################################
##                  post build                  ##
##################################################

echo "*** Post build ***"

if $TRB_DOCKER_ENV; then
    echo "I'm inside matrix ;(";
else
    . build_files/bash_aliases
fi
