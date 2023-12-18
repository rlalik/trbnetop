#!/bin/bash

export SUDO=sudo

export PANDA_TRB_BASEDIR=$(readlink -e $(dirname ${BASH_SOURCE[0]})/../..)

. $PANDA_TRB_BASEDIR/build_files/scripts/environment.sh

if ! command -v root-config &> /dev/null
then
    export ROOTSYS=$PANDA_TRB_DISTDIR/cern/root
else
    export ROOTSYS=$(root-config --prefix)
fi

echo "*** Prepare local perl ***"
# Install LWP and its missing dependencies to the '~/perl5' directory
perl -MCPAN -Mlocal::lib -e 'CPAN::install(LWP)'
 
# Just print out useful shell commands
perl -Mlocal::lib=$PANDA_TRB_BASEDIR/dist/perl5
eval $(perl -MCPAN -Mlocal::lib)


echo "*** Prepare virtualenv ***"
[ -d $PANDA_TRB_DISTDIR//venv ] || virtualenv $PANDA_TRB_DISTDIR/venv
. $PANDA_TRB_DISTDIR/venv/bin/activate
