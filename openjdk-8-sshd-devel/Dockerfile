FROM elifarley/docker-dev-env:debian-openjdk-8-sshd-compiler
MAINTAINER Elifarley Cruz <elifarley@gmail.com>
ENV BASE_IMAGE=elifarley/docker-dev-env:debian-openjdk-8-sshd-compiler

ENV APTGET_PACKAGES="lxc"

RUN \
  xinstall save-image-info && \
  xinstall install-pkg && \
  xinstall cleanup

# Install Rocker: https://github.com/grammarly/rocker		
ENV ROCKER_VERSION 1.1.2		
RUN curl -SL https://github.com/grammarly/rocker/releases/download/"$ROCKER_VERSION"/rocker-"$ROCKER_VERSION"-linux_amd64.tar.gz | tar -xzC /bin && chmod +x /bin/rocker

WORKDIR $HOME
