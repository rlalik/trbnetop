Docker image for running TRB3/TRB5 crate for Panda Straws and Pasttrec systems.

# Docker image

## Requirements
1. Docker buildx
   ```bash
   sudo apt install docker-buildx
   ```

## Building
There are several ways to build and run the container:
   ```bash
   ./docker_build.sh
   ./docker_build_and_run.sh
   ./docker_build_and_shell.sh
   ./docker_run.sh
   ```

### Build
This way, it will build the image only. It is recommended if you hust want to make the image.

### Build and run
This way the image will be build, and then executed. Use this option if you want to start local operator system.

### Build and shell
This way the image will be build, and then docker will enter the image shell. it is recommendend for development and trying things without need to run full operator environment.

### Run
This way the image will be just started, if available.
