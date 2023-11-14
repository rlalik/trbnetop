#!/bin/bash

name=$(basename $(pwd))

docker run --net host -v $(pwd)/conf:/conf -v $(pwd)/workdir:/workdir --rm -it \
--name $name \
$name /workdir/session_start.sh
