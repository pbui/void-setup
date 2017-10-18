#!/bin/sh

# setup-scripts.sh: Setup /usr/local/bin scripts
#

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Install scripts

for script in package service; do
    printf "Installing $script ... "
    run_check install_file usr/local/bin/$script -oroot -groot -m755 || exit 1
done
