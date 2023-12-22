#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/../runtime/environment.sh

[ -n "$1" ] && njobs=$1

##################################################
##                     trb3                     ##
##################################################

echo -e "\n*** Update trb3 ***"

cd $PANDA_TRB_DISTDIR/trb3/
. $PANDA_TRB_DISTDIR/trb3/trb3login
make -j$njobs update


##################################################
##                  trbnettools                 ##
##################################################

echo -e "\n*** Update trbnettools ***"

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

echo -e "\n*** Update daqtools ***"

cd $PANDA_TRB_DISTDIR/daqtools
git pull
cd $PANDA_TRB_DISTDIR/daqtools/xml-db
./xml-db.pl


##################################################
##                pasttrectools                 ##
##################################################

echo -e "\n*** Update pasttrectools ***"

cd $PANDA_TRB_DISTDIR/pasttrectools
git pull
pip install --force-reinstall .

##################################################
##                  post build                  ##
##################################################

echo -e "\n*** Post build ***"

### replace httpi with a modified version, because the httpi in daqtools won't run as root
cp -v $PANDA_TRB_BASEDIR/data/httpi $PANDA_TRB_DISTDIR/daqtools/web/httpi

if [ -f /.dockerenv ]; then
else
    . $PANDA_TRB_BASEDIR/data/bash_aliases
fi
