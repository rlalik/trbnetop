#!/bin/bash

export PANDA_TRB_BASEDIR=$(readlink -e $(dirname ${BASH_SOURCE[0]})/..)
export PANDA_TRB_DISTDIR=$PANDA_TRB_BASEDIR/dist

export SUDO=sudo

. $PANDA_TRB_BASEDIR/runtime/scripts/environment.sh

export PATH=$PANDA_TRB_DISTDIR/trbnettools/bin:$PATH

echo "*** Prepare virtualenv ***"
[ -d $PANDA_TRB_DISTDIR/venv ] && . $PANDA_TRB_DISTDIR/venv/bin/activate
