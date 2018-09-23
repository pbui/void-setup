#!/bin/sh

# setup-scripts.sh: Setup /usr/local/bin scripts
#

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Install scripts

rm -f /usr/local/bin/package /usr/local/bin/service # Delete old scripts

for script in vpm=package vsv=service; do
    src=${script%=*}
    lnk=${script#*=}

    printf "Installing $src... "
    run_check install_file usr/local/bin/$src -oroot -groot -m755 || exit 1

    printf "Symlinking $lnk... "
    run_check ln -sf $src /usr/local/bin/$lnk
done
