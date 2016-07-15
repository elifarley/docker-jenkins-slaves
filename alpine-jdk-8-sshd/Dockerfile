FROM elifarley/docker-cep:alpine-jdk-8-copycontext
MAINTAINER Elifarley <elifarley@gmail.com>

ARG APK_PACKAGES="openssh git libstdc++"

# SSHD
EXPOSE 2200

RUN \
  xinstall add-pkg && \
  xinstall configure sshd && \
  xinstall add maven3 3.3.9 && \
  xinstall cleanup
