#!/bin/sh
exec /usr/sbin/sshd -D -f /etc/ssh/sshd_config "$@"
