#!/usr/bin/env bash
set -ex
if [ $# -lt 1 ]; then
    printf "\n%s TOOLSET\n\tWhere toolset is 'git'. There will be other tools in the future.\n" "$0"
    exit 1
fi

MYDIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPTS=($(ls src/$1 | grep -E '\.sh'))

for F in "${SCRIPTS[@]}"; do
    FULLNAME="$MYDIR/src/$1/$F"
    SHORTNAME=$(basename "$FULLNAME" ".sh")
    echo "$SHORTNAME     -> $FULLNAME"
    LINKNAME="/usr/local/bin/$SHORTNAME"
    if ln -s "$FULLNAME" "$LINKNAME"; then
        chmod +x "$LINKNAME"
    fi
    # TEST
    which "$SHORTNAME"
done
