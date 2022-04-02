# input-leap-docker
## Description:
 Provides a full build environment for Input Leap in a Dockerfile.

## Description:

Docker image to build barrier binaries from their latest source.

## Instructions for Automatic Build:

Once you have Docker installed, Run the following commands:

	git clone https://github.com/EdwardKrayer/input-leap-docker.git
	cd input-leap-docker
    chmod +x ./build.sh
	./build.sh

## Instructions for Manual Build:

Once you have Docker installed, Run the following commands:

    mkdir -p ~/src/input-leap-docker/bin/
    cd ~/src/
	git clone https://github.com/EdwardKrayer/input-leap-docker.git
	cd input-leap-docker
    docker build --tag=input-leap:build . < Dockerfile
    buildpath=$(realpath ./src)
    docker run \
        --tty \
        --volume=$buildpath:/tmp/install/ \
        input-leap:build
    
Whichever option you chose, the installation files will be in the ./bin/ directory.