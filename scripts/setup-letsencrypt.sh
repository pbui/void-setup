#!/bin/sh

# setup-letsencrypt.sh: Setup SSL Certs from Let's Encrypt
#

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Install acme-client package

if ! command -v acme-client > /dev/null 2>&1; then
    printf "Installing acme-client package ... "
    run_check xbps-install -Sy acme-client || exit 1
fi

# Create SSL directories

printf "Creating SSL directories ... "
run_check mkdir /etc/ssl/letsencrypt /etc/letsencrypt /etc/ssl/letsencrypt/private /etc/ssl/letsencrypt/challenge

printf "Securing SSL directories ... "
run_check chmod 0700 /etc/ssl/letsencrypt/private /etc/letsencrypt

# Create SSL certificates

printf "Generate SSL certificates ... "
run_check acme-client -vNn -C /etc/ssl/letsencrypt/challenge h4x0r.space dredd.h4x0r.space weasel.h4x0r.space yld.me
