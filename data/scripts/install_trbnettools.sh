#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/../runtime/environment.sh

[ -n "$1" ] && njobs=$1

. $PANDA_TRB_BASEDIR/data/runtime/helper.sh

mkdir -p $PANDA_TRB_DISTDIR

##################################################
##                  trbnettools                 ##
##################################################

echo -e "\n*** Prepare trbnettools using $njobs jobs ***"

cd $PANDA_TRB_DISTDIR

git clone git://jspc29.x-matter.uni-frankfurt.de/projects/trbnettools.git

cd $PANDA_TRB_DISTDIR/trbnettools
git checkout $TRBNET_COMMIT

echo -e "\n*** Patch trbnettools ***"
patch -p1 < $PANDA_TRB_BASEDIR/data/libtrbnet_tirpc_includes.patch
patch -p1 < $PANDA_TRB_BASEDIR/data/libtrbnet_missing_symbols.patch

echo -e "\n*** Build trbnettools ***"
try make distclean
try make TRB3=1
try make TRB3=1 install
try make -C libtrbnet_perl TRB3=1 install

cd $PANDA_TRB_DISTDIR/trbnettools/libtrbnet_python
try pip install .

echo -e "\n*** Update ldconfig"
echo "$PANDA_TRB_DISTDIR/trbnettools/lib" | $SUDO tee /etc/ld.so.conf.d/trbnet.conf
$SUDO ldconfig
echo -e "\n*** [done]"
