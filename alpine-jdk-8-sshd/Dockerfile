FROM frolvlad/alpine-oraclejdk8:cleaned
MAINTAINER Elifarley Cruz <elifarley@gmail.com>

RUN apk --update add --no-cache openssh rsync curl bash && \
    rm -rf /var/cache/apk/*

RUN printf "\nPort 22\nPermitRootLogin yes\nPasswordAuthentication no\nChallengeResponseAuthentication no\n" >> /etc/ssh/sshd_config && \
  cp -a /etc/ssh /etc/ssh.cache

ENV TIMEZONE Brazil/East

ENV _USER root

ENV HOME /$_USER
RUN mkdir -p $HOME/.ssh && chmod go-w $HOME && chmod 700 $HOME/.ssh && chown $_USER:$_USER -R $HOME && \
  rm -f /etc/localtime && ln -s /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime && \
  mkdir -p /var/run && touch /var/run/docker.sock && chown $_USER:$_USER /var/run/docker.sock

# Install Rocker: https://github.com/grammarly/rocker
ENV ROCKER_VERSION 1.1.2
RUN curl -SL https://github.com/grammarly/rocker/releases/download/"$ROCKER_VERSION"/rocker-"$ROCKER_VERSION"-linux_amd64.tar.gz | tar -xzC /usr/local/bin && chmod +x /usr/local/bin/rocker

WORKDIR $HOME

ENV LANG en_US.UTF-8

EXPOSE 22
#VOLUME $HOME/.rbenv

ADD https://raw.githubusercontent.com/elifarley/docker-jenkins-slaves/master/entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]

CMD ["/usr/sbin/sshd", "-D", "-f", "/etc/ssh/sshd_config"]

#TAG quay.io/elifarley/jenkins-slaves:alpine-jdk-8-sshd
#PUSH quay.io/elifarley/jenkins-slaves:alpine-jdk-8-sshd
