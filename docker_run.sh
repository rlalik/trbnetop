#!/bin/bash

# Get default names for image and container
. .docker_env.sh

# Run new container
echo Running new container $container_name...
docker run \
    --net host \
    -v $(pwd)/conf:/app/conf \
    -v $(pwd)/workdir:/app/workdir \
    -v $(pwd)/static/runtime:/app/static/runtime \
    -v ~/.bash_history:/root/.bash_history \
    --rm -it \
    --name $container_name \
    $image_name /app/workdir/session_start.sh
