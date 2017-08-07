#!/bin/sh

# setup-profile.d.sh: Setup /etc/profile.d
#

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Install scripts

for script in "xdg-runtime-dir"; do
    printf "Installing $script ... "
    run_check install_file etc/profile.d/$script.sh -oroot -groot -m644 || exit 1
done
