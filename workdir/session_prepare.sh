#!/bin/bash

echo "*** Prepare container session"

. $TRBOP_BASEDIR/static/runtime/environment.sh
. $TRBOP_BASEDIR/conf/profile.sh

echo logging to $CONF_LOG

> $CONF_LOG

# Your master script can export following variables:
#  provide_trbnetd=yes
#  provide_cts_gui=yes
#  provide_vnc=yes
# to enable certain features

FOO=${provide_trbnetd:=no}
FOO=${provide_cts_gui:=no}
FOO=${provide_vnc:=no}

echo -e "=======\nCONFIG:\n======="
echo provide_trbnetd=$provide_trbnetd
echo provide_cts_gui=$provide_cts_gui
echo provide_vnc    =$provide_vnc
echo -e "======="

vnc_password=
vnc_port=5902
vnc_geometry=1500x1024


#   tmux new-session -d -s x11vnc -n x11vnc "x11vnc -forever -create -rfbport 5902 #(nopasswd)"

# set paths for go4/dabc/stream
. $TRBOP_DISTDIR/trb3/trb3login

### no need to touch the rest of the file ###

echo ... >> $CONF_LOG
echo DAQOPSERVER=$DAQOPSERVER >> $CONF_LOG
echo >> $CONF_LOG

if [ $provide_trbnetd == "yes" ]; then
  pidof trbnetd || trbnetd -i $TRB3_PORT
  echo "*** trbnet started">> $CONF_LOG
  echo TRB3_SERVER=$TRB3_SERVER >> $CONF_LOG
  echo port $TRB3_PORT >> $CONF_LOG
  echo >> $CONF_LOG
fi

if [ $provide_cts_gui == "yes" ]; then
  tmux new-session -d -s cts_gui -n cts_gui "$TRBOP_BASEDIR/static/runtime/start_cts.sh"
  echo started cts_gui with following parameters:>> $CONF_LOG
  echo --endpoint $CTS_ENDPOINT >> $CONF_LOG
  echo --port $CTS_GUI_PORT >> $CONF_LOG
  echo >> $CONF_LOG
fi

if [ $provide_vnc == "yes" ]; then
  mkdir -p $HOME/.vnc/
  echo $vnc_password | vncpasswd -f > $HOME/.vnc/passwd
  tmux new-session -d -s cts_gui -n cts_gui "$TRBOP_BASEDIR/static/runtime/start_vnc.sh"
  
  echo "*** Started vnc server (e.g. for Go4 window)" >> $CONF_LOG
  echo port=$vnc_port >> $CONF_LOG
  echo DISPLAY=$DISPLAY >> $CONF_LOG
  echo password=$vnc_password >> $CONF_LOG
  echo >> $CONF_LOG
  echo "Connect with:   vncviewer localhost:$vnc_port" >> $CONF_LOG
fi

. $TRBOP_BASEDIR/conf/conf.sh

echo "*** Done"
