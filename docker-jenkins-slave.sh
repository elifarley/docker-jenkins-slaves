#!/bin/bash
set -x
IMAGE="quay.io/elifarley/jenkins-slaves:alpine-openjdk-8-sshd-devel"
docker pull "$IMAGE"

DOCKER_LIBS="$(ldd $(which docker) | grep libdevmapper | cut -d' ' -f3)"
MOUNT_DOCKER="\
-v /var/run/docker.sock:/var/run/docker.sock \
-v $DOCKER_LIBS:$DOCKER_LIBS:ro \
-v $(which docker):$(which docker):ro
"

exec docker run --name jenkins-slave-devel \
-d --restart=always \
-p 2222:22 \
$MOUNT_DOCKER \
-v ~/data/id_rsa.pub:/mnt-ssh-config/authorized_keys:ro \
-v ~/data/bitbucket-private-key:/mnt-ssh-config/id_rsa:ro \
-v ~/data/jenkins-slave:/app/data \
-v ~/data/docker-config.json:/mnt-ssh-config/docker-config.json:ro \
"$IMAGE" "$@"
