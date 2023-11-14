#!/bin/bash

. $PANDA_TRB_BASEDIR/runtime/environment.sh
. $PANDA_TRB_BASEDIR/conf/profile.sh

firefox -new-tab -url localhost:$CTS_GUI_PORT -new-tab -url localhost:$GO4_WEB_PORT
