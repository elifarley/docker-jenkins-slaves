FROM elifarley/docker-cep:debian-jdk-8-copycontext
MAINTAINER Elifarley Cruz <elifarley@gmail.com>

ENV APT_PACKAGES="openssh-server time git jq mercurial bzip2 xz-utils \
gcc g++ make patch binutils libc6-dev \
  libjemalloc-dev libffi-dev libssl-dev libyaml-dev zlib1g-dev libgmp-dev libxml2-dev \
  libxslt1-dev libreadline-dev libsqlite3-dev \
  libpq-dev unixodbc unixodbc-dev unixodbc-bin freetds-bin freetds-common freetds-dev postgresql-client \
  lxc python3-six python3-colorama \
"

RUN mkdir -p /usr/share/man/man1 /usr/share/man/man7 && \
  xinstall add-pkg && \
  xinstall configure sshd && \
  xinstall add maven3 3.3.9 && \
  xinstall add golang 1.7.4 && \
  xinstall add-pkg python3-pip && pip3 install awscli-cwlogs && xinstall remove-pkg python3-pip && \
  xinstall cleanup
