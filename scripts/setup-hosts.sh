#!/bin/sh

# setup-hosts.sh: Setup /etc/hosts
#

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Install /etc/hosts

printf "Installing /etc/hosts ... "
run_check install_file etc/hosts -oroot -groot -m644 || exit 1

# Adjusting host-specific mappings

printf "Adjusting host-specific mappings ... "
case $(hostname) in
weasel|xavier)
    sed -i -e '/192.168/d' -e 's/bx612/cable/' /etc/hosts
;;
esac

if [ $? = 0 ]; then
    echo "success"
else
    echo "failure"
fi
