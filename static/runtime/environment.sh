#!/bin/bash

echo -n "*** Loading environment... "

# based on https://stackoverflow.com/questions/49857332/bash-exit-from-sourced-script
if [[ "$0" != "$BASH_SOURCE" ]]; then
    sourced=1
    ret=return
else
    sourced=0
    ret=exit
fi

# detect if environment was already loaded
if [ -n "${TRBOP_BASEDIR+x}" ]; then
    $ret 0
fi


. $(dirname ${BASH_SOURCE[0]})/detect_host_system.sh

export PATH=$TRBOP_DISTDIR/trbnettools/bin:$PATH
export LIBTRBNET=$TRBOP_DISTDIR/trbnettools/lib/libtrbnet.so

export DABC_TRB3_REV=HEAD
export TRBNET_COMMIT=master
export DAQTOOLS_COMMIT=master

# init ROOT
if ! command -v root-config &> /dev/null
then
    export ROOTSYS=$TRBOP_DISTDIR/cern/root
else
    export ROOTSYS=$(root-config --prefix)
fi


# final settings
if [ -n "${TRB_DOCKER_ENV+x}" ]; then
    # docker run
    true

else
    echo -e "\n*** Prepare local perl ***"
    # Install LWP and its missing dependencies to the '~/perl5' directory
    perl -MCPAN -Mlocal::lib -e 'CPAN::install(LWP)'

    # Just print out useful shell commands
    perl -Mlocal::lib=$TRBOP_BASEDIR/dist/perl5
    eval $(perl -MCPAN -Mlocal::lib)


    echo -e "\n*** Prepare virtualenv ***"
    [ -d $TRBOP_DISTDIR/venv ] || virtualenv $TRBOP_DISTDIR/venv
    . $TRBOP_DISTDIR/venv/bin/activate
fi
