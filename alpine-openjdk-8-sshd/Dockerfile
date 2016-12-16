FROM elifarley/docker-dev-env:alpine-openjdk-8-sshd
MAINTAINER Elifarley Cruz <elifarley@gmail.com>
ENV BASE_IMAGE=elifarley/docker-dev-env:alpine-openjdk-8-sshd

RUN \
  xinstall save-image-info && \
  xinstall update-pkg-list && \
  xinstall add-pkg git && \
  xinstall cleanup

RUN \
  xinstall add maven3 '3.3.9'
