#!/bin/bash

name=$(basename $(pwd))

DOCKER_BUILDKIT=1 docker build $@ -t $name . || exit

docker run --net host -v $(pwd)/conf:/conf -v $(pwd)/workdir:/workdir --rm -it \
--name $name \
$name /workdir/start.sh

