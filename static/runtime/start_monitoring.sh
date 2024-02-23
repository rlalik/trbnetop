#!/bin/bash

. $TRBOP_BASEDIR/static/runtime/environment.sh
. $TRBOP_BASEDIR/conf/profile.sh

firefox -new-tab -url localhost:$CTS_GUI_PORT -new-tab -url localhost:$GO4_WEB_PORT
