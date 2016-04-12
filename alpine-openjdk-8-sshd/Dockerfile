FROM java:openjdk-8-jdk-alpine
MAINTAINER Elifarley Cruz <elifarley@gmail.com>

RUN echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
  apk --update add --no-cache curl openssh rsync shadow bash && \
  rm -rf /var/cache/apk/*

RUN sed -e '/Port/d;/UsePrivilegeSeparation/d;/PermitRootLogin/d;/UsePAM/d;/PasswordAuthentication/d;/ChallengeResponseAuthentication/d;/Banner/d;/PrintMotd/d;/PrintLastLog/d' /etc/ssh/sshd_config > /etc/ssh/sshd_config.tmp && \
printf "\nPort 2200\nUsePrivilegeSeparation no\nPermitRootLogin no\nUsePAM no\nPasswordAuthentication no\nChallengeResponseAuthentication no\nPrintMotd no\nPrintLastLog no\n#---\n" > /etc/ssh/sshd_config && cat /etc/ssh/sshd_config.tmp >> /etc/ssh/sshd_config && rm /etc/ssh/sshd_config.tmp && \
  cp -a /etc/ssh /etc/ssh.cache

ENV TINI_SHA 066ad710107dc7ee05d3aa6e4974f01dc98f3888
ENV GOSU_SHA 18cced029ed8f0bf80adaa6272bf1650ab68f7aa

# Use tini as subreaper in Docker container to adopt zombie processes 
# Grab gosu for easy step-down from root.
RUN curl -fsSL https://github.com/krallin/tini/releases/download/v0.5.0/tini-static -o /bin/tini && chmod +x /bin/tini && \
  echo "$TINI_SHA  /bin/tini" | sha1sum -wc - && \
  curl -fsSL https://github.com/tianon/gosu/releases/download/1.5/gosu-amd64 -o /bin/gosu && chmod 755 /bin/gosu && \
  echo "$GOSU_SHA  /bin/gosu" | sha1sum -wc -

# Install Rocker: https://github.com/grammarly/rocker		
ENV ROCKER_VERSION 1.1.2		
RUN curl -fsSL https://github.com/grammarly/rocker/releases/download/"$ROCKER_VERSION"/rocker-"$ROCKER_VERSION"-linux_amd64.tar.gz | tar -xzC /bin && chmod +x /bin/rocker

ENV _USER app
ENV HOME /$_USER
RUN adduser -h "$HOME" -D $_USER && \
  mkdir -p $HOME/.ssh && chmod go-w $HOME && chmod 700 $HOME/.ssh && chown $_USER:$_USER -R $HOME && \
  echo 'auth requisite  pam_deny.so' >> /etc/pam.d/su

WORKDIR $HOME

ENV LANG en_US.UTF-8
ENV TIMEZONE Brazil/East
RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime

EXPOSE 2200

ADD https://raw.githubusercontent.com/elifarley/docker-jenkins-slaves/master/entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]

CMD ["/usr/sbin/sshd", "-D", "-f", "/etc/ssh/sshd_config"]
