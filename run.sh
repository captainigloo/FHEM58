#!/bin/bash
# Run command for docker service fhem and sshd
usr/bin/supervisord
# check if ssh-keys exists 
test -x /etc/ssh/ssh_host_dsa_key || dpkg-reconfigure openssh-server
/etc/init.d/ssh start
