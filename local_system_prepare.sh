#!/bin/bash

if [ -n "${TRB_DOCKER_ENV+x}" ]; then
    exit 1
else
    true
fi

cdir=$(dirname ${BASH_SOURCE[0]})

. $cdir/static/runtime/detect_host_system.sh

$cdir/static/scripts/system_update.sh
$cdir/static/scripts/system_build_tools.sh
$cdir/static/scripts/system_user_tools.sh
