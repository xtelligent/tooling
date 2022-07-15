#!/usr/bin/env bash
set -e
if [ $# -lt 1 ]; then
    printf "\n%s TOOLSET\n\tWhere toolset is 'git'. There will be other tools in the future.\n" "$0"
    exit 1
fi

MYDIR="$(cd "$(dirname "$0")" && pwd)"
cd "$MYDIR"
SCRIPTS=($(ls src/$1 | grep -E '\.sh'))

for F in "${SCRIPTS[@]}"; do
    FULLNAME="$MYDIR/src/$1/$F"
    SHORTNAME=$(basename "$FULLNAME" ".sh")
    LINKNAME="/usr/local/bin/$SHORTNAME"
    if ln -sf "$FULLNAME" "$LINKNAME" 2>/dev/null; then
        chmod +x "$LINKNAME"
    fi
    # TEST
    which "$SHORTNAME"
done
