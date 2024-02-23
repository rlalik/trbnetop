#!/bin/bash

# Get default names for image and container
. .docker_env.sh

# Run new container
echo Running shell for container $container_name...
docker run \
    --net host \
    -v $(pwd)/conf:/conf \
    -v $(pwd)/workdir:/workdir \
    -v ~/.bash_history:/root/.bash_history \
    --rm -it \
    --name $container_name \
    $image_name /bin/bash

