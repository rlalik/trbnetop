#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/../runtime/environment.sh

[ -n "$1" ] && njobs=$1

##################################################
##                     trb3                     ##
##################################################

echo -e "\n*** Update trb3 ***"

cd $TRBOP_DISTDIR/trb3/
. $TRBOP_DISTDIR/trb3/trb3login
make -j$njobs update


##################################################
##                  trbnettools                 ##
##################################################

echo -e "\n*** Update trbnettools ***"

cd $TRBOP_DISTDIR/trbnettools
git pull
make TRB3=1 -j$njobs
make -C libtrbnet install
make -C trbrich install
make -C trbnetd install

cd $TRBOP_DISTDIR/trbnettools/libtrbnet_perl
perl Makefile.PL
$SUDO make

cd $TRBOP_DISTDIR/trbnettools/libtrbnet_python
pip install --force-reinstall .


##################################################
##                   daqtools                   ##
##################################################

echo -e "\n*** Update daqtools ***"

cd $TRBOP_DISTDIR/daqtools
git pull
cd $TRBOP_DISTDIR/daqtools/xml-db
./xml-db.pl


##################################################
##                pasttrectools                 ##
##################################################

echo -e "\n*** Update pasttrectools ***"

cd $TRBOP_DISTDIR/pasttrectools
git pull
pip install --force-reinstall .

##################################################
##                  post build                  ##
##################################################

echo -e "\n*** Post build ***"

### replace httpi with a modified version, because the httpi in daqtools won't run as root
cp -v $TRBOP_BASEDIR/data/httpi $TRBOP_DISTDIR/daqtools/web/httpi

if [ -f /.dockerenv ]; then
else
    . $TRBOP_BASEDIR/data/bash_aliases
fi
