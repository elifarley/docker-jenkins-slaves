FROM elifarley/docker-dev-env:debian-openjdk-8-sshd-compiler
MAINTAINER Elifarley Cruz <elifarley@gmail.com>

RUN apt-get install -y --no-install-recommends "lxc" && \
apt-get autoremove --purge -y && apt-get clean && \
rm -rf $RM_ITEMS

# Install Rocker: https://github.com/grammarly/rocker		
ENV ROCKER_VERSION 1.1.2		
RUN curl -SL https://github.com/grammarly/rocker/releases/download/"$ROCKER_VERSION"/rocker-"$ROCKER_VERSION"-linux_amd64.tar.gz | tar -xzC /bin && chmod +x /bin/rocker

WORKDIR $HOME
