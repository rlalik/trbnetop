#!/bin/bash

. $PANDA_TRB_BASEDIR/runtime/environment.sh
. $PANDA_TRB_BASEDIR/conf/profile.sh

dabc_exe $PANDA_TRB_BASEDIR/workdir/TdcEventBuilder.xml
