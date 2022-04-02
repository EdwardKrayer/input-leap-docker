#!/bin/bash
memThresholdVeryLow='2000'
memThresholdLow='6000'
memFree=$(free -m | grep "Mem" | awk '{print $4+$6}')

if [ $memFree -lt $memThresholdVeryLow  ]; then

        echo "  Using very low memory Dockerfile"
        docker build --tag=input-leap:build . < Dockerfile.very-low-memory

elif [ $memFree -lt $memThresholdLow  ]; then

        echo "  Using low memory Dockerfile"
        docker build --tag=input-leap:build . < Dockerfile.low-memory

else

        echo "  Using normal Dockerfile"
        docker build --tag=input-leap:build . < Dockerfile

fi

mkdir ./src/
buildpath=$(realpath ./src/)

docker run \
        --tty \
        --volume=$buildpath:/tmp/install/ \
        input-leap:build