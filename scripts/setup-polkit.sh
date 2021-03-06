#!/bin/sh

# setup-polkit.sh: Setup polkit rules
#
# https://github.com/void-linux/void-mklive/issues/69

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Install scripts

for rules in files/etc/polkit-1/rules.d/*.rules; do
    printf "Installing $rules... "
    run_check install_file etc/polkit-1/rules.d/$(basename $rules) -oroot -groot -m644|| exit 1
done

# Cleanup

for rules in 90-consolekit; do
    path=/etc/polkit-1/rules.d/$rules.rules
    if [ -r $path ]; then 
	printf "Removing $rules... "
	run_check rm -f $path || exit 1
    fi
done
