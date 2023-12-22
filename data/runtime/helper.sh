#!/bin/bash

# based on https://stackoverflow.com/questions/36498981/shell-dont-fail-git-clone-if-folder-already-exists
function yell { echo "$0: $*" >&2; }
function die { yell "$*"; exit 111; }
function try { "$@" || die "cannot $*"; }
