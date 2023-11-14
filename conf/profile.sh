#!/bin/bash

cd $PANDA_TRB_BASEDIR/conf

echo "configure container"

export TRB3_PORT=35
export DAQOPSERVER=localhost:$TRB3_PORT
export TRB3_SERVER=192.168.5.24

export CTS_GUI_PORT=1148
export CTS_ENDPOINT=0xc035

export GO4_WEB_PORT=8080

export DISPLAY=:2 # go4 window will be sent to $DISPLAY, if provide_vnc == yes , then it will be this x11 display

export CONF_LOG=$PANDA_TRB_BASEDIR/conf/conf_log.txt
