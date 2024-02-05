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

## Extending the image

This image provides the basic system for trb operation. You may be in situation that youn need co create new image for your custom system:

You may want to do it in varous cases:
* add more TRB's MAC addresses to the DHCP server configuration,
* add custom software to minitor the system,
* add more TDC ids,
* and more...

If one want to intriduce these changes, the best is to use this image as a base for the next one:

1. Create your new project directory and copy `conf` and `workidr` of this project into it:
	```bash
    mkdir ../new_project
    cp -rp copy workdir ../new_project
    cd ../new_project
    ```
1. Create `Dockerfile` with following context:
	```docker
	FROM rlalik/trbnetop:latest

	COPY your configigs to overwrite defautl configs
	RUN apt install your packages
	```
1. Build and run your new docker image (see also `docker_build_and_run.sh` how it can be done with script)
	```bash
	DOCKER_BUILDKIT=1 docker build -t your_awesome_image .
	docker run --net host -v $(pwd)/conf:/conf -v $(pwd)/workdir:/workdir --rm -it --name your_awesome_image $name /workdir/start.sh
	```

## Local vs Docker usage

This repository provides easy way to create docker. However, the whole system can be also used directly in the host compoter without virtualziation. This has however some dangers and require to be carefull. See notes below.

### DHCP
In the docker we have fully isolated DHCP server and we configure it to use only for our system. In the host the DHCP can be configured to provide services for other systems. Thus the docker `/work/start.sh` calls two configure scripts:
```bash
$TRBOP_BASEDIR/conf/system_conf.sh
. $TRBOP_BASEDIR/conf/user_conf.sh
```
The `system_conf.sh` configures the DHCP server. In the host environment, you would rather need to configure it manually (and you need root proviledges for that). Most likely you want to copy parts of `conf/dhcpd.conf` into your system configuration. We will need expxlain this operation here -- if you do not know how to do it already, you are clearly not experienced enough and consider using docker.

If anyway you decide to override the system configuration (which is very DANGER), call this script with sudo (once is enought):
```bash
sudo conf/system_conf.sh
```
then start the system with call of `/work/start.sh`.
