#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/../runtime/environment.sh

[ -n "$1" ] && njobs=$1

. $TRBOP_BASEDIR/static/runtime/helper.sh

mkdir -p $TRBOP_DISTDIR

##################################################
##                  trbnettools                 ##
##################################################

echo -e "\n*** Prepare trbnettools using $njobs jobs ***"

cd $TRBOP_DISTDIR

if [ ! -d trbnettools ]; then
    git clone git://jspc29.x-matter.uni-frankfurt.de/projects/trbnettools.git
    cd $TRBOP_DISTDIR/trbnettools

    git checkout $TRBNET_COMMIT

    echo -e "\n*** Patch trbnettools ***"
    patch -p1 < $TRBOP_BASEDIR/static/libtrbnet_tirpc_includes.patch
    patch -p1 < $TRBOP_BASEDIR/static/libtrbnet_missing_symbols.patch
else
    cd $TRBOP_DISTDIR/trbnettools

    git checkout $TRBNET_COMMIT
    git pull
fi

echo -e "\n*** Build trbnettools ***"
try make distclean
try make TRB3=1
try make TRB3=1 install
try make -C libtrbnet_perl TRB3=1 install

cd $TRBOP_DISTDIR/trbnettools/libtrbnet_python
try pip install .

echo -e "\n*** Update ldconfig"
echo "$TRBOP_DISTDIR/trbnettools/lib" | $SUDO tee /etc/ld.so.conf.d/trbnet.conf
$SUDO ldconfig
echo -e "\n*** [done]"
