#!/bin/bash

. $PANDA_TRB_BASEDIR/runtime/environment.sh
. $PANDA_TRB_BASEDIR/conf/profile.sh

cd $PANDA_TRB_BASEDIR/workdir

rm -v *.root
go4analysis -stream localhost:6790 -http localhost:$GO4_WEB_PORT
