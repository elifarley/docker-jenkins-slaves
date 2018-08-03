#!/bin/sh

for d in .gradle .docker; do
  if test -d "$_home/$d"; then
    chown "$_USER:$_USER" "$_home/$d"
  fi
done

for d in .npm .bundle .gem .rbenv .jenkins/cache/jars .gradle/caches .gradle/daemon .gradle/native .gradle/wrapper; do
  test -d /data/"$d" || {
    $sudo mkdir -p /data/"$d" || return
  }
done

for d in .npm .bundle .gem .rbenv .jenkins .gradle/caches .gradle/daemon .gradle/native .gradle/wrapper; do
  test -L "$_home"/"$d" -a -d "$_home"/"$d" || {
    rm -rf "$_home/$d" && $sudo ln -s /data/"$d" "$_home/$d" || return
  }
done

echo "$_home:"; ls -Falk "$_home"
echo "/data:"; ls -Falk /data

# See https://stackoverflow.com/questions/23011547/webservice-client-generation-error-with-jdk8/23012746#23012746
jaxp_props="/usr/lib/jvm/default-jvm/jre/lib/jaxp.properties"
grep -q 'accessExternalSchema' "$jaxp_props" 2>/dev/null || echo 'javax.xml.accessExternalSchema = all' >> "$jaxp_props"
