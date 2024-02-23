#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/../runtime/detect_host_system.sh

echo -e "\n*** Update system ***"

$SUDO apt-get update -qq

DEBIAN_FRONTEND=noninteractive \
DEBCONF_NONINTERACTIVE_SEEN=true \
TZ=Etc/UTC \
$SUDO apt-get install -yqq --no-install-recommends apt-utils dialog

$SUDO apt-get upgrade -yqq
$SUDO apt-get dist-upgrade -yqq
