#!/bin/bash

if [ -n "${TRB_DOCKER_ENV+x}" ]; then
    exit 1
else
    true
fi

. static/runtime/detect_environment.sh

static/scripts/system_update.sh
static/scripts/system_build_tools.sh
static/scripts/system_user_tools.sh
