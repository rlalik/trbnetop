#!/bin/bash

cdir=$(dirname ${BASH_SOURCE[0]})

. $cdir/static/runtime/environment.sh

exec $cdir/static/local/start_local_session.sh
