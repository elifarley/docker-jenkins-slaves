FROM java:openjdk-8-jdk
MAINTAINER Elifarley Cruz <elifarley@gmail.com>

ENV APT_PACKAGES "\
openssh-server gcc g++ make patch binutils libc6-dev \
  libjemalloc-dev libffi-dev libssl-dev libyaml-dev zlib1g-dev libgmp-dev libxml2-dev \
  libxslt1-dev libreadline-dev libsqlite3-dev \
  libpq-dev unixodbc unixodbc-dev unixodbc-bin ruby-odbc freetds-bin freetds-common freetds-dev postgresql-client \
  git lxc\
"

ENV RM_ITEMS "\
/tmp/* /var/tmp/* /var/lib/apt/lists/* /var/lib/apt /var/lib/dpkg /var/backups/* /usr/share/man /usr/share/doc\
"

COPY apt.conf /etc/apt/apt.conf.d/local

ENV LANG en_US.UTF-8
RUN apt-get update && apt-get -y dist-upgrade && \
apt-get install -y --no-install-recommends $APT_PACKAGES && \
apt-get autoremove --purge -y && apt-get clean && \
rm -rf /etc/cron.daily/{apt,passwd}

RUN sed -e '/Port/d;/UsePrivilegeSeparation/d;/PermitRootLogin/d;/UsePAM/d;/PasswordAuthentication/d;/ChallengeResponseAuthentication/d;/Banner/d' /etc/ssh/sshd_config > /etc/ssh/sshd_config.tmp && \
printf "\nPort 2200\nUsePrivilegeSeparation no\nPermitRootLogin no\nUsePAM no\nPasswordAuthentication no\nChallengeResponseAuthentication no\n\n#---\n" > /etc/ssh/sshd_config && cat /etc/ssh/sshd_config.tmp >> /etc/ssh/sshd_config && rm /etc/ssh/sshd_config.tmp && \
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
RUN curl -SL https://github.com/grammarly/rocker/releases/download/"$ROCKER_VERSION"/rocker-"$ROCKER_VERSION"-linux_amd64.tar.gz | tar -xzC /bin && chmod +x /bin/rocker

ENV _USER app
ENV HOME /$_USER
RUN adduser --disabled-password --home "$HOME" --shell /bin/bash --gecos "" $_USER && \
  mkdir -p $HOME/.ssh && chmod go-w $HOME && chmod 700 $HOME/.ssh && chown $_USER:$_USER -R $HOME && \
  echo 'auth requisite  pam_deny.so' > /etc/pam.d/su

WORKDIR $HOME
COPY gemrc .gemrc
ENV GEM_SPEC_CACHE "$HOME/gemspec"
ENV GEM_HOME "$HOME/gem-home"
ENV PATH "$GEM_HOME/bin:$PATH"

ENV TIMEZONE Brazil/East
RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime

EXPOSE 2200
#VOLUME $HOME/.rbenv

ADD https://raw.githubusercontent.com/elifarley/docker-jenkins-slaves/master/entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]

CMD ["/usr/sbin/sshd", "-D", "-f", "/etc/ssh/sshd_config"]
