FROM java:openjdk-8-jre
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
RUN apt-get update && apt-get -y dist-upgrade && \
apt-get install -y --no-install-recommends $APT_PACKAGES && \
apt-get autoremove --purge -y && apt-get clean && \
rm -rf /etc/cron.daily/{apt,passwd}

RUN printf "\nUsePAM no\nPort 22\nPermitRootLogin no\nPasswordAuthentication no\nChallengeResponseAuthentication no\n" >> /etc/ssh/sshd_config && \
  cp -a /etc/ssh /etc/ssh.cache

ENV TIMEZONE Brazil/East
ENV _USER app
ENV HOME /$_USER
RUN adduser --disabled-password --home=$HOME --gecos "" $_USER && \
  mkdir -p $HOME/.ssh && chmod go-w $HOME && chmod 700 $HOME/.ssh && chown $_USER:$_USER -R $HOME && \
  rm -f /etc/localtime && ln -s /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime && \
  mkdir -p /var/run && touch /var/run/docker.sock && chown $_USER:$_USER /var/run/docker.sock

# Install Rocker: https://github.com/grammarly/rocker
ENV ROCKER_VERSION 1.1.2
RUN curl -SL https://github.com/grammarly/rocker/releases/download/"$ROCKER_VERSION"/rocker-"$ROCKER_VERSION"-linux_amd64.tar.gz | tar -xzC /usr/local/bin && chmod +x /usr/local/bin/rocker

WORKDIR $HOME
COPY gemrc .gemrc
ENV GEM_SPEC_CACHE "$HOME/gemspec"
ENV GEM_HOME "$HOME/gem-home"
ENV PATH "$GEM_HOME/bin:$PATH"

ENV LANG en_US.UTF-8

EXPOSE 22
#VOLUME $HOME/.rbenv

COPY ../entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]

CMD ["/usr/sbin/sshd", "-D", "-f", "/etc/ssh/sshd_config"]

#TAG quay.io/elifarley/jenkins-slaves:alpine-openjdk-8-sshd-devel:latest
#PUSH quay.io/elifarley/jenkins-slaves:alpine-openjdk-8-sshd-devel:latest
