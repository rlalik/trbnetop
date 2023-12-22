#!/bin/bash

# entry
if [ -n "${TRB_DOCKER_ENV+x}" ]; then
    # docker run
    export PANDA_TRB_BASEDIR=/
else
    # local run
    export PANDA_TRB_BASEDIR=$(readlink -e $(dirname ${BASH_SOURCE[0]})/../..)
    export SUDO=sudo
fi

export PANDA_TRB_DISTDIR=$PANDA_TRB_BASEDIR/dist
