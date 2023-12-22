#!/bin/bash

echo "*** Prepare container session"

cd $PANDA_TRB_BASEDIR/conf

. $PANDA_TRB_BASEDIR/runtime/environment.sh
. $PANDA_TRB_BASEDIR/conf/profile.sh

echo logging to $CONF_LOG

> $CONF_LOG

provide_trbnetd=yes
provide_cts_gui=yes
provide_vnc=no
vnc_password=
vnc_port=5902
vnc_geometry=1500x1024


#   tmux new-session -d -s x11vnc -n x11vnc "x11vnc -forever -create -rfbport 5902 #(nopasswd)"

# set paths for go4/dabc/stream
. $PANDA_TRB_DISTDIR/trb3/trb3login

### no need to touch the rest of the file ###

echo ... >> $CONF_LOG
echo DAQOPSERVER=$DAQOPSERVER >> $CONF_LOG
echo >> $CONF_LOG

if [ $provide_trbnetd == "yes" ]; then
  trbnetd -i $TRB3_PORT
  echo "*** trbnet started">> $CONF_LOG
  echo TRB3_SERVER=$TRB3_SERVER >> $CONF_LOG
  echo port $TRB3_PORT >> $CONF_LOG
  echo >> $CONF_LOG
fi

if [ $provide_cts_gui == "yes" ]; then
  tmux new-session -d -s cts_gui -n cts_gui "$PANDA_TRB_BASEDIR/runtime/start_cts.sh"
  echo started cts_gui with following parameters:>> $CONF_LOG
  echo --endpoint $CTS_ENDPOINT >> $CONF_LOG
  echo --port $CTS_GUI_PORT >> $CONF_LOG
  echo >> $CONF_LOG
fi

if [ $provide_vnc == "yes" ]; then
  mkdir -p $HOME/.vnc/
  echo $vnc_password | vncpasswd -f > $HOME/.vnc/passwd
  tmux new-session -d -s cts_gui -n cts_gui "$PANDA_TRB_BASEDIR/runtime/start_vnc.sh"
  
  echo "*** Started vnc server (e.g. for Go4 window)" >> $CONF_LOG
  echo port=$vnc_port >> $CONF_LOG
  echo DISPLAY=$DISPLAY >> $CONF_LOG
  echo password=$vnc_password >> $CONF_LOG
  echo >> $CONF_LOG
  echo "Connect with:   vncviewer localhost:$vnc_port" >> $CONF_LOG
fi

. $PANDA_TRB_BASEDIR/conf/conf.sh

echo "*** Done"
