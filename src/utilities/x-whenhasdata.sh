#!/usr/bin/env bash

if [ $# -eq 1 ] && [ "$1" == "-h" ]; then
    printf "%s COMMAND [ARGs] \n\tWhen data is piped in, it runs the supplied command line.\n\n" "$0"
    exit 1
fi

set -e
while read LINE
do
    if [ -n "$LINE" ]; then
        "$@"
        exit
    fi
done < /dev/stdin

