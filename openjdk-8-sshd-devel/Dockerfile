FROM elifarley/docker-dev-env:debian-openjdk-8-sshd-compiler
MAINTAINER Elifarley Cruz <elifarley@gmail.com>

RUN apt-get install -y --no-install-recommends "lxc" && \
apt-get autoremove --purge -y && apt-get clean && \
rm -rf $RM_ITEMS

# Install Maven
ENV MAVEN_VERSION 3.3.9
ENV MAVEN_SHA 5b4c117854921b527ab6190615f9435da730ba05
RUN curl -fsSL http://www-us.apache.org/dist/maven/maven-3/"$MAVEN_VERSION"/binaries/apache-maven-"$MAVEN_VERSION"-bin.tar.gz -o /tmp/maven.tgz && \
  echo "$MAVEN_SHA  /tmp/maven.tgz" | sha1sum -wc - && \
  tar -xzf /tmp/maven.tgz -C /usr/local && rm /tmp/maven.tgz && \
  ln -s apache-maven-"$MAVEN_VERSION" /usr/local/maven-3 && ln -s ../maven-3/bin/mvn ../maven-3/bin/mvnDebug ../maven-3/bin/mvnyjp /usr/local/bin

# Install Rocker: https://github.com/grammarly/rocker		
ENV ROCKER_VERSION 1.1.2		
RUN curl -SL https://github.com/grammarly/rocker/releases/download/"$ROCKER_VERSION"/rocker-"$ROCKER_VERSION"-linux_amd64.tar.gz | tar -xzC /bin && chmod +x /bin/rocker

WORKDIR $HOME
