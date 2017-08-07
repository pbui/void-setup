#!/bin/sh

# common.sh: Set of common utility functions

_BASEDIR=$(readlink -f $(dirname $(readlink -f $0))/..)

do_root_check() {
    printf "Checking if root ... "
    run_check test $(id -u) -eq 0
}

install_file() {
    local file=$1 ; shift
    install $@ $_BASEDIR/files/$file /$file
}

run_check() {
    result=$($@ 2>&1)
    if [ $? -eq 0 ]; then
    	echo success
    	return 0
    else
    	echo failure
    	[ -n "$result" ] && echo $result
    	return 1
    fi
}

# vim: set sts=4 sw=4 ts=8 expandtab ft=sh:
