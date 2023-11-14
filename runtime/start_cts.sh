#!/bin/bash

. $PANDA_TRB_BASEDIR/runtime/environment.sh
. $PANDA_TRB_BASEDIR/conf/profile.sh

cd $PANDA_TRB_DISTDIR/daqtools/web
perl ./cts_gui --endpoint $CTS_ENDPOINT --quiet --noopenxterm --port $CTS_GUI_PORT
