#!/bin/bash

if $TRB_DOCKER_ENV; then
    true
else
    . scripts/environment.sh
    [ -n "$1" ] && njobs=$1
fi

echo "*** Running make with $njobs jobs ***"

mkdir -p $PANDA_TRB_DISTDIR


##################################################
##                  trbnettools                 ##
##################################################

echo "*** Prepare trbnettools ***"

cd $PANDA_TRB_DISTDIR

git clone git://jspc29.x-matter.uni-frankfurt.de/projects/trbnettools.git

cd $PANDA_TRB_DISTDIR/trbnettools
git checkout $TRBNET_COMMIT

patch -p1 < $PANDA_TRB_BASEDIR/build_files/libtrbnet_tirpc_includes.patch
patch -p1 < $PANDA_TRB_BASEDIR/build_files/libtrbnet_missing_symbols.patch

echo "*** Build trbnettools ***"
make distclean
make TRB3=1
make TRB3=1 install
$SUDO make -C libtrbnet_perl TRB3=1 install

cd $PANDA_TRB_DISTDIR/trbnettools/libtrbnet_python
pip install .

echo "$PANDA_TRB_DISTDIR/trbnettools/lib" | $SUDO tee /etc/ld.so.conf.d/trbnet.conf
$SUDO ldconfig
