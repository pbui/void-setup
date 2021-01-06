#!/bin/sh

# setup-socklog.sh: Setup socklog
#

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Install socklog packages

if ! command -v socklog > /dev/null 2>&1; then
    printf "Installing socklog packages ... "
    run_check xbps-install -Sy socklog socklog-void || exit 1
fi

# Link services

printf "Link socklog-unix service ... "
run_check service link socklog-unix || exit 1

printf "Link nanoklogd service ... "
run_check service link nanoklogd || exit 1

# Link logs

for d in cron daemon debug errors everything kernel lpr mail messages secure user xbps; do
    printf "Linking $d log ... "
    run_check ln -s /var/log/socklog/$d/current /var/log/$d.log || exit 1
done
