#!/bin/bash

name=$(basename $(pwd))

DOCKER_BUILDKIT=1 docker build $@ -t $name . 2>&1 | tee _build.log || exit

