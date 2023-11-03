#!/bin/bash

export PANDA_TRB_BASEDIR=$PWD
export PANDA_TRB_DISTDIR=$PANDA_TRB_BASEDIR

export SUDO=sudo

. docker_environment.sh

export PATH=$PATH:$PANDA_TRB_DISTDIR/trbnettools/bin

echo "*** Prepare virtualenv ***"
[ -d $PANDA_TRB_DISTDIR/venv ] || virtualenv $PANDA_TRB_DISTDIR/venv
. $PANDA_TRB_DISTDIR/venv/bin/activate
