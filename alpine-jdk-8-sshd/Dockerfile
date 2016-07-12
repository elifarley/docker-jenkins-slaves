FROM elifarley/docker-dev-env:alpine-jdk-8-sshd
MAINTAINER Elifarley Cruz <elifarley@gmail.com>
ENV BASE_IMAGE=elifarley/docker-dev-env:alpine-jdk-8-sshd

RUN \
  xinstall save-image-info && \
  xinstall add-pkg git 'libstdc++' && \
  xinstall add maven3 3.3.9 && \
  xinstall cleanup
