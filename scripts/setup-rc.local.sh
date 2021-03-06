#!/bin/sh

# setup-rc.local.sh: Setup /etc/rc.local
#

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Install syslinux package

if ! command -v figlet > /dev/null 2>&1; then
    printf "Installing figlet package ... "
    run_check xbps-install -Sy figlet || exit 1
fi

# Install /etc/rc.local

printf "Installing /etc/rc.local ... "
run_check install_file etc/rc.local -oroot -groot -m755 || exit 1

# Append host specific commands

printf "Appending host-specific commands ... "
case $(hostname) in
frost|gambit|scarlet|nightcrawler)
    cat >> /etc/rc.local <<EOF
amixer set PCM 100% > /dev/null
EOF
;;
xavier)
    cat >> /etc/rc.local <<EOF
amixer set Master 80   > /dev/null
amixer set Speaker off > /dev/null
(sleep 30 ; mount -a) &
EOF
;;
esac

if [ $? = 0 ]; then
    echo "success"
else
    echo "failure"
fi
