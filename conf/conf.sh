#!/bin/bash

cd $PANDA_TRB_BASEDIR/conf

echo "configure trbnet"

. profile.sh

trbcmd reset

./addresses.sh

./conf_tdcs.sh

./conf_gbe.sh
