FROM elifarley/docker-dev-env:debian-openjdk-8-sshd-compiler
MAINTAINER Elifarley Cruz <elifarley@gmail.com>

WORKDIR $HOME
COPY gemrc .gemrc
ENV GEM_SPEC_CACHE "$HOME/gemspec"
ENV GEM_HOME "$HOME/gem-home"
ENV PATH "$GEM_HOME/bin:$PATH"
