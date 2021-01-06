#!/bin/sh

# setup-popcorn.sh: Setup popcorn
#

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Install PopCorn package

if ! command -v popcorn > /dev/null 2>&1; then
    printf "Installing PopCorn package ... "
    run_check xbps-install -Sy PopCorn || exit 1
fi

# Install PopCorn cronjob

printf "Install popcorn cron.daily... "
run_check install_file etc/cron.daily/popcorn -oroot -groot -m755 || exit 1
