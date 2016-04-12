#!/bin/bash

#IMAGE="elifarley/docker-jenkins-slaves:alpine-jdk-8-sshd"
#IMAGE="elifarley/docker-jenkins-slaves:alpine-openjdk-8-sshd"
IMAGE="elifarley/docker-jenkins-slaves:openjdk-8-sshd-devel"

docker pull "$IMAGE"

DOCKER_LIBS="$(ldd $(which docker) | grep libdevmapper | cut -d' ' -f3)"
MOUNT_DOCKER="\
-v /var/run/docker.sock:/var/run/docker.sock \
-v $DOCKER_LIBS:$DOCKER_LIBS:ro \
-v $(which docker):$(which docker):ro
"

exec docker run --name jenkins-slave -p 2200:2200 \
-d --restart=always \
$MOUNT_DOCKER \
-v ~/.ssh/id_rsa.pub:/mnt-ssh-config/authorized_keys:ro \
-v ~/.ssh/id_rsa:/mnt-ssh-config/id_rsa:ro \
-v ~/.docker/config.json:/mnt-ssh-config/docker-config.json:ro \
-v ~/data/jenkins-slave:/data \
"$IMAGE" "$@"
