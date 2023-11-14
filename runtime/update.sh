#!/bin/bash

if $TRB_DOCKER_ENV; then
    . docker_environment.sh
else
    . scripts/environment.sh
    [ -n "$1" ] && njobs=$1
fi


##################################################
##                     trb3                     ##
##################################################

echo "*** Update trb3 ***"

cd $PANDA_TRB_DISTDIR/trb3/
. $PANDA_TRB_DISTDIR/trb3/trb3login
make -j$njobs update


##################################################
##                  trbnettools                 ##
##################################################

echo "*** Update trbnettools ***"

cd $PANDA_TRB_DISTDIR/trbnettools
git pull
make TRB3=1 -j$njobs
make -C libtrbnet install
make -C trbrich install
make -C trbnetd install

cd $PANDA_TRB_DISTDIR/trbnettools/libtrbnet_perl
perl Makefile.PL
$SUDO make

cd $PANDA_TRB_DISTDIR/trbnettools/libtrbnet_python
pip install --force-reinstall .


##################################################
##                   daqtools                   ##
##################################################

echo "*** Update daqtools ***"

cd $PANDA_TRB_DISTDIR/daqtools
git pull
cd $PANDA_TRB_DISTDIR/daqtools/xml-db
./xml-db.pl


##################################################
##                pasttrectools                 ##
##################################################

echo "*** Update pasttrectools ***"

cd $PANDA_TRB_DISTDIR/pasttrectools
git pull
pip install --force-reinstall .

##################################################
##                  post build                  ##
##################################################

echo "*** Post build ***"

### replace httpi with a modified version, because the httpi in daqtools won't run as root
cp -v $PANDA_TRB_BASEDIR/build_files/httpi $PANDA_TRB_DISTDIR/daqtools/web/httpi

if [ -f /.dockerenv ]; then
    echo "I'm inside matrix ;(";
else
    . $PANDA_TRB_BASEDIR/build_files/bash_aliases
fi
