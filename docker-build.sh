#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

PUSH=$1
DATE="$(date "+%Y%m%d%H%M")"
REPOSITORY_NAME="latonaio"
IMAGE_NAME="fluentd-for-containers-mongodb-kube"
DOCKERFILE_DIR="${SCRIPT_DIR}/docker"
if [ "$(uname -m)" == "x86_64" ]; then
	DOCKERFILE_NAME="Dockerfile.amd64"
elif [ "$(uname -m)" == "arm64" ]; then
	DOCKERFILE_NAME="Dockerfile.arm64"
else
	:
fi

# build servicebroker
DOCKER_BUILDKIT=1 docker build -f ${DOCKERFILE_DIR}/${DOCKERFILE_NAME} -t ${REPOSITORY_NAME}/${IMAGE_NAME}:${DATE} .
docker tag ${REPOSITORY_NAME}/${IMAGE_NAME}:"${DATE}" ${REPOSITORY_NAME}/${IMAGE_NAME}:latest

if [[ $PUSH == "push" ]]; then
    docker push ${REPOSITORY_NAME}/${IMAGE_NAME}:"${DATE}"
    docker push ${REPOSITORY_NAME}/${IMAGE_NAME}:latest
fi
