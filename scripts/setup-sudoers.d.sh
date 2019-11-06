#!/bin/sh

# setup-sudoers.d.sh: Setup /etc/sudoers.d
#

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Install scripts

for conf in "umask"; do
    printf "Installing $conf ... "
    run_check install_file etc/sudoers.d/$conf -oroot -groot -m600 || exit 1
done
