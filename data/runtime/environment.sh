#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/detect_environment.sh


export PANDA_TRB_DISTDIR=$PANDA_TRB_BASEDIR/dist

export PATH=$PANDA_TRB_DISTDIR/trbnettools/bin:$PATH
export LIBTRBNET=$PANDA_TRB_DISTDIR/trbnettools/lib/libtrbnet.so

export DABC_TRB3_REV=HEAD
export TRBNET_COMMIT=master
export DAQTOOLS_COMMIT=master

# init ROOT
if ! command -v root-config &> /dev/null
then
    export ROOTSYS=$PANDA_TRB_DISTDIR/cern/root
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
    perl -Mlocal::lib=$PANDA_TRB_BASEDIR/dist/perl5
    eval $(perl -MCPAN -Mlocal::lib)


    echo -e "\n*** Prepare virtualenv ***"
    [ -d $PANDA_TRB_DISTDIR//venv ] || virtualenv $PANDA_TRB_DISTDIR/venv
    . $PANDA_TRB_DISTDIR/venv/bin/activate
fi
