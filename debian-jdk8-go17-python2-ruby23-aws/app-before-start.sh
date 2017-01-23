#!/bin/sh

for d in .gradle .docker; do
  if test -d "$_home/$d"; then
    chown "$_USER:$_USER" "$_home/$d"
  fi
done

for d in .bundle .jenkins/cache/jars .gradle/caches .gradle/daemon .gradle/native .gradle/wrapper; do
  test -d /data/"$d" || {
    $sudo mkdir -p /data/"$d" || return
  }
done

for d in .bundle .jenkins .gradle/caches .gradle/daemon .gradle/native .gradle/wrapper; do
  test -L "$_home"/"$d" -a -d "$_home"/"$d" || {
    rm -rf "$_home/$d" && $sudo ln -s /data/"$d" "$_home/$d" || return
  }
done

echo "$_home:"; ls -Falk "$_home"
echo "/data:"; ls -Falk /data
