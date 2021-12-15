#!/bin/bash

set -e

export GOLANG_VERSION=1.14
export TINI_VERSION=0.19.0
export VERSION="6.4.4-Jonas"

DOCKER_REGISTRY=docker.lauber.pro

VERSION="${VERSION//v}"
SEMVER=( ${VERSION//./ } )
VERSION_LENGTH=${#SEMVER[@]}

if [ $VERSION_LENGTH -ne 3 ]; then
    echo "$VERSION is not semver."
    exit 1
fi

# Needed on MacOsx
eval $(docker-machine env default) > /dev/null 2>&1

docker build \
    --build-arg VERSION=${VERSION} \
    --build-arg TINI_VERSION=${TINI_VERSION} \
    -t ${DOCKER_REGISTRY}/gotenberg:latest \
    -f build/package/Dockerfile .

docker push ${DOCKER_REGISTRY}/gotenberg:latest
