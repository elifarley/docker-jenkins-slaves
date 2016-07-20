#!/bin/sh
mkdir -p ~"$_USER"/.gradle && chown -v "$_USER":"$_USER" ~"$_USER"/.gradle && ls -Falk ~"$_USER"/.gradle
