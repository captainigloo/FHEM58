#!/bin/bash
# Run command for docker service fhem and sshd

# check if ssh-keys exists 
test -x /etc/ssh/ssh_host_dsa_key || dpkg-reconfigure openssh-server
/etc/init.d/ssh start
echo "Current directory : $(pwd)"
echo "Environment RUNVAR: $RUNVAR"
echo "There are $# arguments: $@"

# make pidfile rundir for fhem (because /var/run  ist tmpfs in ram)
if [ ! -d /var/run/fhem  ]; then
    mkdir /var/run/fhem
    chown -R fhem:root /var/run/fhem
fi
