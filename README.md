# docker-openjdk8-sshd-devel
[![Docker Repository on Quay.io](https://quay.io/repository/elifarley/openjdk8-sshd-devel/status "Docker Repository on Quay.io")](https://quay.io/repository/elifarley/openjdk8-sshd-devel) ~ 250 MB

Docker image based on 'java:openjdk-8-jre'.

Adds ssh server, git and other packags suitable for building Ruby projects in a Jenkins slave.

It also supports building Docker images via either Docker itself or via [Rocker](http://tech.grammarly.com/blog/posts/Making-Docker-Rock-at-Grammarly.html). They both use the Docker Unix socket mounted inside the container to talk to the parent Docker engine (the one controlling the container).

To avoid missing library dependencies, it was necessary to not only install lxc inside the container, but also mount the Docker executable and the libdevmapper library, as you can see in file [docker-jenkins-slave.sh](docker-jenkins-slave.sh).
Here's an excerpt:

```bash
DOCKER_LIBS="$(ldd $(which docker) | grep libdevmapper | cut -d' ' -f3)"
MOUNT_DOCKER="\
-v /var/run/docker.sock:/var/run/docker.sock \
-v $DOCKER_LIBS:$DOCKER_LIBS:ro \
-v $(which docker):$(which docker):ro
"
```

Which yields
```bash
-v /var/run/docker.sock:/var/run/docker.sock \
-v /lib/x86_64-linux-gnu/libdevmapper.so.1.02.1:/lib/x86_64-linux-gnu/libdevmapper.so.1.02.1:ro \
-v /usr/bin/docker:/usr/bin/docker:ro
```
