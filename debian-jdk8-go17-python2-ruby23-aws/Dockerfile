FROM elifarley/docker-cep:debian-jdk-8-copycontext
MAINTAINER Elifarley Cruz <elifarley@gmail.com>

ENV APT_PACKAGES="openssh-server time git jq mercurial \
gcc g++ make patch binutils libc6-dev \
  libjemalloc-dev libffi-dev libssl-dev libyaml-dev zlib1g-dev libgmp-dev libxml2-dev \
  libxslt1-dev libreadline-dev libsqlite3-dev \
  libpq-dev unixodbc unixodbc-dev unixodbc-bin freetds-bin freetds-common freetds-dev postgresql-client \
  lxc python3-six python3-colorama \
"

RUN \
  xinstall add-pkg && \
  xinstall configure sshd && \
  xinstall add maven3 3.3.9 && \
  xinstall add golang 1.7.4 && \
  xinstall add ruby 2.3.0 && gem install bundler && \
  xinstall add-pkg python3-pip && pip3 install awscli-cwlogs && xinstall remove-pkg python3-pip && \
  xinstall cleanup
