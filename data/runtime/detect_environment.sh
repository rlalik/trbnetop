#!/bin/bash

echo -n "Detecting environment... "

# entry
if [ -n "${TRB_DOCKER_ENV+x}" ]; then
    # docker run
    echo "DOCKER"

    export TRBOP_BASEDIR=/
else
    # local run
    echo "Local"

    export TRBOP_BASEDIR=$(readlink -e $(dirname ${BASH_SOURCE[0]})/../..)

    export SUDO=sudo

    . $TRBOP_BASEDIR/data/bash_aliases
fi

export TRBOP_DISTDIR=$TRBOP_BASEDIR/dist
