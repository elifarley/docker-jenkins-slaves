#!/bin/sh

test -d /data/.bundle || {
  $sudo mkdir /data/.bundle || return
}

test -L "$_home"/.bundle -a -d "$_home"/.bundle || {
  rm -rf "$_home"/.bundle && $sudo ln -s /data/.bundle "$_home"/.bundle
}

test -d /data/.jenkins/cache/jars || {
  $sudo mkdir -p /data/.jenkins/cache/jars || return
}

test -L "$_home"/.jenkins -a -d "$_home"/.jenkins || {
  rm -rf "$_home"/.jenkins && $sudo ln -s /data/.jenkins "$_home"/.jenkins
}

if test -d "$_home"/.gradle; then
  chown "$_USER:$_USER" "$_home"/.gradle
fi

if test -d "$_home"/.docker; then
  chown "$_USER:$_USER" "$_home"/.docker
fi

echo "$_home:"; ls -Falk "$_home"
echo "/data:"; ls -Falk /data
