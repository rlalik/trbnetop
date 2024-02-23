#!/bin/bash

. $TRBOP_BASEDIR/static/runtime/environment.sh
. $TRBOP_BASEDIR/conf/profile.sh

cd $TRBOP_DISTDIR/daqtools/web
perl ./cts_gui --endpoint $CTS_ENDPOINT --quiet --noopenxterm --port $CTS_GUI_PORT
