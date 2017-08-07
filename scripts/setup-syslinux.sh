#!/bin/sh

# setup-syslinux.sh: Setup syslinux bootloader
#
# Usage: setup-syslinux [/dev/sda]
#
# Based on the documentation:
#   https://wiki.archlinux.org/index.php/syslinux#UEFI_Systems

. $(dirname $0)/common.sh

# Command line arguments

HDD=${1:-/dev/sda}

# Root Check

do_root_check || exit 1

# Install syslinux package

if ! command -v syslinux > /dev/null 2>&1; then
    printf "Installing syslinux package ... "
    run_check xbps-install -Sy syslinux || exit 1
fi

# Detect partitioning scheme

printf "Detecting partitioning scheme ... "
case $(blkid -s PTTYPE -o value $HDD) in
gpt)
    SYSLINUX_TYPE=gpt
    SYSLINUX_BOOT_DIR=/boot/efi/syslinux
    SYSLINUX_DATA_DIR=/usr/share/syslinux/efi64
    ;;
dos)
    SYSLINUX_TYPE=dos
    SYSLINUX_BOOT_DIR=/boot/syslinux
    SYSLINUX_DATA_DIR=/usr/share/syslinux
    ;;
*)
    printf "unknown\n"
    exit 1
;;
esac

printf "$SYSLINUX_TYPE\n"

# Create boot directory

printf "Creating syslinux boot directory @ $SYSLINUX_BOOT_DIR ... "
if [ ! -d $SYSLINUX_BOOT_DIR ]; then
    run_check mkdir $SYSLINUX_BOOT_DIR || exit 1
else
    echo skip
fi

# Copy data files

printf "Copying syslinux data files to boot directory ... "
run_check cp $SYSLINUX_DATA_DIR/*.c32 $SYSLINUX_BOOT_DIR || exit 1

# Install bootloader

if [ $SYSLINUX_TYPE = dos ]; then
    printf "Installing bootloader to boot directory ... "
    run_check extlinux --install $SYSLINUX_BOOT_DIR || exit 1

    printf "Installing bootloader to MBR ... "
    run_check dd bs=440 count=1 if=/usr/share/syslinux/mbr.bin of=$HDD || exit 1
fi

# TODO: handle EFI

# Install kernel hooks

printf "Installing post-install kernel hook ... "
run_check install_file etc/kernel.d/post-install/50-syslinux -oroot -groot -m755 || exit 1

printf "Installing post-remove kernel hook ... "
run_check ln -sf /etc/kernel.d/post-install/50-syslinux /etc/kernel.d/post-remove/50-syslinux || exit 1

printf "Installing kernel hook configuration ... "
run_check install_file etc/default/syslinux -oroot -groot -m644 || exit 1

printf "Setting default kernel to current version ... "
run_check sed -i "s|^SYSLINUX_DEFAULT=.*\$|SYSLINUX_DEFAULT=$(uname -r | cut -d . -f 1,2)|" /etc/default/syslinux

# Generate configuration
/etc/kernel.d/post-install/50-syslinux
