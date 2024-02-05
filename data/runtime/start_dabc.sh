#!/bin/bash

. $TRBOP_BASEDIR/runtime/environment.sh
. $TRBOP_BASEDIR/conf/profile.sh

dabc_exe $TRBOP_BASEDIR/workdir/TdcEventBuilder.xml
