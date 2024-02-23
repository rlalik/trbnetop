#!/bin/bash

. $TRBOP_BASEDIR/static/runtime/environment.sh
. $TRBOP_BASEDIR/conf/profile.sh

echo starting vnc server on port $vnc_port for display $DISPLAY
vncserver $DISPLAY -rfbauth $HOME/.vnc/passwd -rfbport $vnc_port -geometry $vnc_geometry
