FROM elifarley/docker-dev-env:alpine-jdk-8-sshd
MAINTAINER Elifarley Cruz <elifarley@gmail.com>
ENV BASE_IMAGE=elifarley/docker-dev-env:alpine-jdk-8-sshd

ENV DEBUG=1
RUN \
  install-helper.sh save-image-info && \
  install-helper.sh update-pkg-list && \
  install-helper.sh install-pkg git && \
  install-helper.sh cleanup

RUN \
  install-helper.sh install maven-3 '3.3.9' '5b4c117854921b527ab6190615f9435da730ba05' /usr/local
