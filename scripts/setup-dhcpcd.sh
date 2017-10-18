#!/bin/sh

# setup-dhcpcd.sh: Setup dhcpcd service
#

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Install /etc/sv/dhcpcd/conf

printf "Installing /etc/sv/dhcpcd/conf... "
run_check install_file etc/sv/dhcpcd/conf -oroot -groot -m644 || exit 1
