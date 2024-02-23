#!/bin/bash

. $TRBOP_BASEDIR/static/runtime/environment.sh
. $TRBOP_BASEDIR/conf/profile.sh

cd $TRBOP_BASEDIR/workdir

rm -v *.root
go4analysis -stream localhost:6790 -http localhost:$GO4_WEB_PORT
