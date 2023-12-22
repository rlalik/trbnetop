#!/bin/bash

if [ -n "${TRB_DOCKER_ENV+x}" ]; then
    exit 1
else
    true
fi

. data/runtime/detect_environment.sh

data/scripts/system_update.sh
data/scripts/system_build_tools.sh
data/scripts/system_user_tools.sh
