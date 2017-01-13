FROM elifarley/docker-debian-jdk-8
MAINTAINER Elifarley Cruz <elifarley@gmail.com>
ENV BASE_IMAGE=elifarley/docker-debian-jdk-8

ENV \
APT_PACKAGES="openssh-server rsync sudo time git jq" \
TINI_VERSION='v0.13.2' \
GOSU_VERSION='1.6' \
_USER=app \
LANG=en_US.UTF-8 TZ=${TZ:-Brazil/East} \
TERM=xterm-256color
ENV HOME=/$_USER JAVA_TOOL_OPTIONS="-Duser.timezone=$TZ"

# SSHD
EXPOSE 2200

ENTRYPOINT ["tini", "--", "entrypoint"]
CMD ["/usr/sbin/sshd", "-D", "-f", "/etc/ssh/sshd_config"]

WORKDIR $HOME

RUN curl -fsSL https://raw.githubusercontent.com/elifarley/cross-installer/master/install.sh | sh && \
  xinstall save-image-info && \
  xinstall add tini "$TINI_VERSION" && \
  xinstall add gosu "$GOSU_VERSION" && \
  xinstall add entrypoint && \
  xinstall add-user "$_USER" && \
  xinstall add timezone && \
  xinstall add-pkg && \
  xinstall add tar && \
  xinstall configure sshd && \
  xinstall add maven3 3.3.9 && \
  xinstall cleanup
