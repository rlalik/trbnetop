#!/bin/bash

echo "*** Configure trbnet system"

. $TRBOP_BASEDIR/conf/profile.sh

if [ -z $TRB3_SERVER ]; then
    echo "*** ERROR: Please set \$TRB3_SERVER in conf/profile.sh before you start the container."
    exit 1
fi

trbcmd reset

$TRBOP_BASEDIR/conf/addresses.sh

$TRBOP_BASEDIR/conf/conf_cts.sh

$TRBOP_BASEDIR/conf/conf_tdcs.sh

$TRBOP_DISTDIR/daqtools/tools/loadregisterdb.pl $TRBOP_BASEDIR/conf/register_configgbe.db
$TRBOP_DISTDIR/daqtools/tools/loadregisterdb.pl $TRBOP_BASEDIR/conf/register_configgbe_ip.db
