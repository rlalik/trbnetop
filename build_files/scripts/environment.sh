#!/bin/bash

export PANDA_TRB_DISTDIR=$PANDA_TRB_BASEDIR/dist

export PATH=$PANDA_TRB_DISTDIR/trbnettools/bin:$PATH
export LIBTRBNET=$PANDA_TRB_DISTDIR/trbnettools/lib/libtrbnet.so

if ! command -v root-config &> /dev/null
then
    export ROOTSYS=$PANDA_TRB_DISTDIR/cern/root
else
    export ROOTSYS=$(root-config --prefix)
fi

export DABC_TRB3_REV=HEAD
export TRBNET_COMMIT=master
export DAQTOOLS_COMMIT=master
