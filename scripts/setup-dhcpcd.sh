#!/bin/sh

# setup-dhcpcd.sh: Setup dhcpcd service
#

. $(dirname $0)/common.sh

# Root Check

do_root_check || exit 1

# Disable wpa_supplicant hook

[ -r /etc/sv/dhcpcd/conf ] && rm /etc/sv/dhcpcd/conf

if ! grep -q 'nohook wpa_supplicant' /etc/dhcpcd.conf; then
    printf "Disable wpa_supplicant hook ... "
    cat >> /etc/dhcpcd.conf <<EOF

# Disable wpa_supplicant hook
nohook wpa_supplicant
EOF
fi
