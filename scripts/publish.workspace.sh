#!/bin/bash

set -e

export GOLANG_VERSION=1.14

DOCKER_REGISTRY=docker.lauber.pro

VERSION="${VERSION//v}"
SEMVER=( ${VERSION//./ } )
VERSION_LENGTH=${#SEMVER[@]}

if [ $VERSION_LENGTH -ne 3 ]; then
    echo "$VERSION is not semver."
    exit 1
fi

docker build -t thecodingmachine/gotenberg:base \
     -f build/base/Dockerfile .

docker push thecodingmachine/gotenberg:base

docker build -t thecodingmachine/gotenberg:workspace \
       --build-arg GOLANG_VERSION=${GOLANG_VERSION} \
       -f build/workspace/Dockerfile .

docker push thecodingmachine/gotenberg:workspace
