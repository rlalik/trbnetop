#!/bin/bash

if $TRB_DOCKER_ENV; then
    true
else
    . /scripts/environment.sh
fi

echo "*** Install build tools ***"

$SUDO apt-get update -qq

DEBIAN_FRONTEND=noninteractive \
DEBCONF_NONINTERACTIVE_SEEN=true \
TZ=Etc/UTC \
$SUDO apt-get install -yqq --no-install-recommends apt-utils dialog

$SUDO apt-get upgrade -yqq
$SUDO apt-get dist-upgrade -yqq
