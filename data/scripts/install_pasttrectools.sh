#!/bin/bash

. $(dirname ${BASH_SOURCE[0]})/../runtime/environment.sh

[ -n "$1" ] && njobs=$1

mkdir -p $PANDA_TRB_DISTDIR


##################################################
##                pasttrectools                 ##
##################################################

echo -e "\n*** Prepare pasttrectools using $njobs jobs ***"

pip install -U pip colorama

cd $PANDA_TRB_DISTDIR/

git clone https://github.com/HADES-Cracovia/pasttrectools

cd pasttrectools

pip install .
