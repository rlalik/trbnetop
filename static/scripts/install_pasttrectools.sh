#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/../runtime/environment.sh

[ -n "$1" ] && njobs=$1

mkdir -p $TRBOP_DISTDIR


##################################################
##                pasttrectools                 ##
##################################################

echo -e "\n*** Prepare pasttrectools using $njobs jobs ***"

pip install -U pip colorama

cd $TRBOP_DISTDIR/

if [ ! -d pasttrectools ]; then
    git clone https://github.com/HADES-Cracovia/pasttrectools
    cd pasttrectools
else
    cd pasttrectools
    git pull
fi

pip install -r requirements.txt
pip install -U .
