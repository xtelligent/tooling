#!/usr/bin/env bash
set -e

if [ $# -lt 1 ]; then
    printf "%s PATHS [FLAGS] [COMMITNUMBER]\n" "$0" >&2
    printf "\tReturns true/0 if there's a change under one of the paths.\n" >&2
    printf "\tPATHS: Paths to files or directories in the repository to check for any changes, delimited by |.\n" >&2
    printf "\tFLAGS: Flags passed directly to gix-modlist command (-d|-n|-r).\n" >&2
    printf "\tCOMMITNUMBER: Commit passed directly to gix-modlist command.\n\n" >&2
    exit 1
fi

IFS='|' read -ra PATHS <<< "$1"
shift

THISSCRIPT=$(readlink "$0" || echo "$0")
MYDIR="$(cd "$(dirname "$THISSCRIPT")" && pwd)"

CHANGES=$("$MYDIR/gitx-modlist.sh" "$@")

if [ -z "$CHANGES" ]; then
    exit 1
fi

CHANGEAR=( $(echo "$CHANGES") )
for PATH in "${PATHS[@]}"
do
    for CH in "${CHANGEAR[@]}"; do
        LEFTPATHLEN=${#PATH}
        LEFTPATH="${CH:0:LEFTPATHLEN}"
        if [ "$LEFTPATH" = "$PATH" ]; then
            exit 0
        fi
    done
done
exit 1
