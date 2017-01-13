FROM elifarley/docker-cep:debian-jdk-8-copycontext
MAINTAINER Elifarley Cruz <elifarley@gmail.com>

ENV APT_PACKAGES "\
gcc g++ make patch binutils libc6-dev \
  libjemalloc-dev libffi-dev libssl-dev libyaml-dev zlib1g-dev libgmp-dev libxml2-dev \
  libxslt1-dev libreadline-dev libsqlite3-dev \
  libpq-dev unixodbc unixodbc-dev unixodbc-bin ruby-odbc freetds-bin freetds-common freetds-dev postgresql-client \
  git lxc python python-six python-colorama \
"

RUN \
  xinstall add-pkg && \
  xinstall add maven3 3.3.9 && \
  xinstall add golang 1.7.4 && \
  xinstall add ruby 2.3.0 && gem install bundler && \
  xinstall add-pkg python-pip && pip install awscli-cwlogs && xinstall remove-pkg python-pip && \
  xinstall cleanup
