#!/bin/sh

# setup-udev.sh: Setup udev rules

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Install rules

for rules in files/etc/udev/rules.d/*.rules; do
    printf "Installing $rules... "
    run_check install_file etc/udev/rules.d/$(basename $rules) -oroot -groot -m644 -D|| exit 1
done

# Reload rules

printf "Reload rules... "
run_check udevadm control --reload

printf "Trigger rules... "
run_check udevadm trigger
