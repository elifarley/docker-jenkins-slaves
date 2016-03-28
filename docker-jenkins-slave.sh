#!/bin/bash
set -x
IMAGE="quay.io/elifarley/openjdk8-sshd-devel:latest"
LIBDEVMAPPER="$(dpkg -L libdevmapper1.02.1 | grep \.so)"
docker pull "$IMAGE"

exec docker run --name jenkins-slave-devel \
-d --restart=always \
-p 2222:22 \
-v /var/run/docker.sock:/var/run/docker.sock \
-v "$(which docker)":"$(which docker)":ro \
-v "$LIBDEVMAPPER":"$LIBDEVMAPPER":ro \
-v ~/data/id_rsa.pub:/app/ssh-config/authorized_keys:ro \
-v ~/data/bitbucket-private-key:/app/ssh-config/id_rsa:ro \
-v ~/data/jenkins-slave:/app/data \
"$IMAGE" "$@"
