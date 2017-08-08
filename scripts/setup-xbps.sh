#!/bin/sh

# setup-xbps.sh: Setup XBPS repositories and settings
#

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Install scripts

for conf in $(ls $_BASEDIR/files/etc/xbps.d); do
    conf=etc/xbps.d/$conf
    if echo $conf | grep -q multilib && xbps-uhelper arch | grep -q armv; then
    	continue
    fi
    printf "Installing $conf ... "
    run_check install_file $conf -oroot -groot -m644 || exit 1
done
