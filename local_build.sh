#!/bin/bash

cdir=$(dirname ${BASH_SOURCE[0]})

njobs=

if [ -n "${TRB_DOCKER_ENV+x}" ]; then
    echo -e "\n*** Not intended for DOCKER RUN"
    exit 2
else
    echo -e "\n*** LOCAL RUN"

    . /etc/lsb-release

    [ ${DISTRIB_ID} != "Ubuntu" ] && { echo -e "Ubuntu system required"; exit 10; }

    . static/scripts/vercomp.sh
    UBUNTY_REQ_VERSION=22.04
    vercomp ${DISTRIB_RELEASE} ${UBUNTY_REQ_VERSION}
    [ $? = "2" ] && { echo -e "Ubuntu system required at least in version ${UBUNTY_REQ_VERSION}"; exit 10; }

    [ -n "$1" ] && njobs=$1
fi

. ./static/runtime/environment.sh

echo -e "\n*** Running bootstrap using $njobs jobs ***"

mkdir -p $TRBOP_DISTDIR

$cdir/static/scripts/install_root.sh $njobs

$cdir/static/scripts/install_trb3.sh $njobs

. $TRBOP_DISTDIR/trb3/trb3login

$cdir/static/scripts/install_trbnettools.sh $njobs

$cdir/static/scripts/install_daqtools.sh $njobs

$cdir/static/scripts/install_pasttrectools.sh $njobs

##################################################
##                  post build                  ##
##################################################

echo -e "\n*** Post build ***"

if $TRB_DOCKER_ENV; then
    true
else
    . $TRBOP_BASEDIR/static/bash_aliases
fi
