#!/bin/bash
docker build --tag=input-leap:build . < Dockerfile
mkdir ./src/
buildpath=$(realpath ./src)
docker run \
        --tty \
        --volume=$buildpath:/tmp/install/ \
        input-leap:build