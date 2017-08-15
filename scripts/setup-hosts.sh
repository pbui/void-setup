#!/bin/sh

# setup-hosts.sh: Setup /etc/hosts
#

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Install /etc/hosts

printf "Installing /etc/hosts ... "
run_check install_file etc/hosts -oroot -groot -m644 || exit 1
