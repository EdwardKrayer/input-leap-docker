## Specify the base image.
FROM ubuntu:20.04

## Create and set working directory.
WORKDIR /tmp

## Set this mode when you need zero interaction while installing or upgrading the system via apt. It accepts the default answer for all questions.
RUN export DEBIAN_FRONTEND=noninteractive

## Set timezone information required for CMake.
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

## Update the base system.
RUN apt-get update && \
        apt-get upgrade -y

## Install packges required for compilation.
RUN apt-get install -y \
        git \
        build-essential \
        cmake \
        libcurl4-openssl-dev \
        libxtst-dev \
        libavahi-compat-libdnssd-dev \
        qtbase5-dev \
        libssl-dev

## Clone latest input-leap source.
RUN git clone \
        https://github.com/input-leap/input-leap.git


## Change build script to build the Release version instead of the Debug version.
RUN sed -i 's/Debug/Release/g' /tmp/input-leap/clean_build.sh

## Run input-leap build script.
RUN /tmp/input-leap/clean_build.sh

## Change to the build directory for installation
WORKDIR /tmp/input-leap/build/

## Run make
RUN make

## Create empty directory to "install" into.
RUN mkdir -p /tmp/install/

## This is the script that is ran by default when running the new image, in our case we want it run "make install" in the directory we've attached to our "real" system.
ENTRYPOINT make DESTDIR=/tmp/install/ install