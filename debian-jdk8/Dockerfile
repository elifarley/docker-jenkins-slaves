FROM elifarley/docker-cep:debian-jdk-8-copycontext
MAINTAINER Elifarley <elifarley@gmail.com>

ARG APT_PACKAGES="openssh-server time git jq"

ENV BASE_IMAGE=elifarley/docker-cep:debian-jdk-8-copycontext

# SSHD
EXPOSE 2200

WORKDIR $HOME

RUN \
  xinstall add-pkg && \
  xinstall configure sshd && \
  xinstall add maven3 3.3.9 && \
  xinstall cleanup
