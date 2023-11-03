#!/bin/bash

if $TRB_DOCKER_ENV; then
    echo "I'm inside matrix ;(";
else
    . scripts/environment.sh
fi

echo "*** Update system ***"

$SUDO apt-get update -qq

DEBIAN_FRONTEND=noninteractive \
DEBCONF_NONINTERACTIVE_SEEN=true \
TZ=Etc/UTC \
$SUDO apt-get install -yqq --no-install-recommends apt-utils dialog

$SUDO apt-get upgrade -yqq
$SUDO apt-get dist-upgrade -yqq
