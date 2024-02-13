#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/data/runtime/environment.sh

export provide_trbnetd=yes
#export provide_cts_gui=yes
#export provide_vnc=yes

. $(dirname ${BASH_SOURCE[0]})/workdir/session_prepare.sh

NEW_PS1="(trbnetop) ${PS1-}"
if [[ "${NEW_PS1+x}" != "${TRBNET_OLD_PS1+x}" ]]; then
    export TRBNET_OLD_PS1=$PS1
    export PS1="${NEW_PS1}"
fi
