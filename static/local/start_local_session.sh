#!/bin/bash

echo "start local session"

echo "run /conf/user_conf.sh"

. $TRBOP_BASEDIR/workdir/session_prepare.sh

. $TRBOP_BASEDIR/static/bash_aliases

cd $TRBOP_BASEDIR/workdir

echo "create main tmux session"

# create new tmux session named "main"
tmux new -d -s main

# display some info
tmux new-window -t main -n "info" "cat $TRBOP_BASEDIR/conf/conf_log.txt; cat info.txt; /bin/bash"

tmux link-window -s cts_gui:cts_gui -t main  # attach window opened by conf.sh
tmux link-window -s vnc:vnc -t main          # attach window opened by conf.sh

### start a dabc service
tmux new-window -t main -n "dabc" "$TRBOP_BASEDIR/static/runtime/start_dabc.sh;/bin/bash"

### start a go4 session
#tmux new-window -t main -n "go4" "rm *.root;  go4 my_hotstart.hotstart;/bin/bash"

### start a go4analysis session with web server
tmux new-window -t main -n "go4_ana" "$TRBOP_BASEDIR/static/runtime/start_go4.sh; /bin/bash"

### some new tabs to use for ... whatever
tmux new-window -t main -n "new" "/bin/bash"
tmux new-window -t main -n "new" "/bin/bash"
tmux new-window -t main -n "new" "/bin/bash"
tmux new-window -t main -n "new" "/bin/bash"
tmux new-window -t main -n "new" "/bin/bash"

# open CTS GUI and GO4 Web interface in firefox (running in VNC)
# tmux new-window -t main -n "x11_apps" "firefox -new-tab -url localhost:$CTS_GUI_PORT -new-tab -url localhost:$GO4_WEB_PORT& /bin/bash"
tmux new-window -t main -n "x11_apps" "$TRBOP_BASEDIR/static/runtime/start_monitoring.sh & /bin/bash"

### select info tab
tmux select-window -t main:info

### finally attach tmux to the above configured session
tmux a -t main

echo "terminate local session"

cd -
