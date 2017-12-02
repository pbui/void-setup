#!/bin/sh

# setup-cron.sh: Setup cron
#

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Install cronie package

if ! command -v cronie > /dev/null 2>&1; then
    printf "Installing cronie package ... "
    run_check xbps-install -Sy cronie || exit 1
fi

# Enable services

printf "Enable cronie service ... "
run_check service enable cronie || exit 1
