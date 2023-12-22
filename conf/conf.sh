#!/bin/bash

cd $PANDA_TRB_BASEDIR/conf

echo "*** Configure trbnet system"

. profile.sh

if [ -z $TRB3_SERVER ]; then
    echo "*** ERROR: Please set \$TRB3_SERVER in conf/profile.sh before you start the container."
    exit 1
fi

trbcmd reset

./addresses.sh

./conf_cts.sh

./conf_tdcs.sh

$PANDA_TRB_DISTDIR/daqtools/tools/loadregisterdb.pl register_configgbe.db
$PANDA_TRB_DISTDIR/daqtools/tools/loadregisterdb.pl register_configgbe_ip.db
