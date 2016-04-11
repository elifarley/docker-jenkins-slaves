# Docker Jenkins Slaves

Docker images suitable to be used as [Jenkins](https://jenkins.io/) slaves that can build Java projects and Docker images.

There are different [tags](https://hub.docker.com/r/elifarley/docker-jenkins-slaves/tags/ "List of tags on Docker Hub"), targeting different use cases.

You can build Docker images via either Docker itself or via [Rocker](http://tech.grammarly.com/blog/posts/Making-Docker-Rock-at-Grammarly.html). They both use the Docker Unix socket mounted inside the container to talk to the parent Docker engine (the one controlling the container).
To avoid missing dynamic library dependencies, it was necessary to not only install lxc inside the container, but also mount the Docker executable and the libdevmapper library, as you can see in file [docker-jenkins-slave.sh](docker-jenkins-slave.sh).
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

## Private keys and Docker credentials

You can mount your public key at **/app/ssh-config/authorized_keys** so that you can log in via SSH. Example:
```bash
-v ~/id_rsa.pub:/app/ssh-config/authorized_keys:ro
```

You can also mount a private key at **/app/ssh-config/id_rsa** so that the container can log in to Github, like this:

```bash
-v ~/github-private-key:/app/ssh-config/id_rsa:ro
```

In order to be able to push images to a Docker registry, you can mount your Docker credentials like this:
```bash
-v ~/.docker/config.json:/app/ssh-config/docker-config.json:ro
```

