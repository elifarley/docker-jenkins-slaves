FROM elifarley/docker-dev-env:alpine-jdk-8-sshd
MAINTAINER Elifarley Cruz <elifarley@gmail.com>
ENV BASE_IMAGE=elifarley/docker-dev-env:alpine-jdk-8-sshd

RUN \
  xinstall save-image-info && \
  xinstall update-pkg-list && \
  xinstall add-pkg git 'libstdc++' && \
  xinstall cleanup

RUN \
  xinstall add maven3 3.3.9 '5b4c117854921b527ab6190615f9435da730ba05'
