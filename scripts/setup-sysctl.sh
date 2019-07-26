#!/bin/sh

# setup-sysctl.sh: Setup /etc/sysctl.conf
#

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Install /etc/sysctl.conf

printf "Installing /etc/sysctl.conf ... "
run_check install_file etc/sysctl.conf -oroot -groot -m644 || exit 1

# Adjusting host-specific settings

printf "Adjusting host-specific settings ... "
case $(hostname) in
weasel)
    sed -i -Ee 's/vm.swappiness=(.*)/vm.swappiness=40/' /etc/sysctl.conf
;;
esac

if [ $? = 0 ]; then
    echo "success"
else
    echo "failure"
fi
