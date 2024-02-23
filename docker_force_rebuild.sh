#!/bin/bash

# Get default names for image and container
. .docker_env.sh

export DOCKER_BUILDKIT=1

# Build image with the same image name
echo Building new image $image_name...
docker build $@ \
    --build-arg LAST_SYSTEM_DATE="$(git log -n 1 --pretty=format:%cd --date=format:'%F %T')" \
    --build-arg FORCE_UPDATE="$(date +'%F %T')" \
    -t $image_name \
    -f Dockerfile \
    --progress=plain \
    . 2>&1 | tee _build.log

# Remove existing container running old image
echo Deleting old container...
docker rm -f $container_name

# Delete old images that:
# 1. No longer have a reference
# 2. Do not currently have a container using it
echo Deleting old image...
docker image prune



