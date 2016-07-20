#!/bin/sh
_home="$(eval echo ~"$_USER")"
mkdir -p "$_home"/.gradle && chown -v "$_USER":"$_USER" "$_home"/.gradle && ls -Falkd "$_home"/.gradle
