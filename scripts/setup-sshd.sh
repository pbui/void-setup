#!/bin/sh

# setup-sshd.sh: Setup sshd 
#

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Install openssh package

if ! command -v sshd > /dev/null 2>&1; then
    printf "Installing openssh package ... "
    run_check xbps-install -Sy openssh || exit 1
fi

# Modify sshd config

printf "Modify sshd config ... "
run_check \ 
    sed -e 's/#PermitRootLogin yes/PermitRootLogin no/' \
    	-e 's/#PasswordAuthentication yes/PasswordAuthentication no/' \
    	-i /etc/ssh/sshd_config

# Enable sshd service

if [ ! -r /var/service/sshd ]; then
    printf "Enable sshd service ... "
    run_check service enable sshd || exit 1
fi
