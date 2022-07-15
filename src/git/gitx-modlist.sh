#!/usr/bin/env bash
set -e
THISSCRIPT=$(readlink "$0" || echo "$0")
MYDIR="$(cd "$(dirname "$THISSCRIPT")" && pwd)"
ROOTDIR="$(cd "$MYDIR/../.." && pwd)"

DORECENT=yes
NEWFILES=( git ls-files --others --exclude-standard )
DIRTY=( git diff-files --name-only )

while getopts 'dnr' OPTION; do
  case "$OPTION" in
    d)
      DIRTY=( printf "%s" "" )
      ;;
    n)
      NEWFILES=( printf "%s" "" )
      ;;
    r)
      DORECENT=no
      ;;
    ?)
      printf "script usage: $(basename \$0) [-d] [-n] [-r] [COMMITNUMBER]\n" >&2
      printf "\td: exclude dirty files (tracked files with changes) from output\n" >&2
      printf "\tn: exclude new/untracked files from output\n" >&2
      printf "\tr: exclude recent commit changes from output; show only new/dirty files\n" >&2
      printf "\tCOMMITNUMBER: optional commit to use as the start of history.\n\n" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

if [ $# -gt 0 ]; then
    BASE="$1"
else
    BRANCH=$("$MYDIR/gitx-curbranch.sh")
    HEADCOMMIT=$(git name-rev --name-only --exclude=tags/* HEAD)
    if [ "$BRANCH" = 'main' ] || [ "$HEADCOMMIT" = 'main' ]; then
        BASE=HEAD~1
        if ! git rev-parse $BASE 1>/dev/null 2>&1; then
            BASE=HEAD
        fi
    else
        BASE=origin/main
    fi
fi
CNUM=$(git rev-parse $BASE)


if [ "$DORECENT" = "yes" ]; then
    RECENTCOMMITS=( git diff-index --name-only $CNUM )
else
    RECENTCOMMITS=( printf "%s" "" )
fi

FILES=$( \
    ${RECENTCOMMITS[@]} \
    && ${NEWFILES[@]} \
    && ${DIRTY[@]} )

# Skip over any deleted files.
GITROOT="$("$MYDIR/gitx-root.sh")"
ULIST=( $(echo "$FILES" | sort | uniq) )
for F in "${ULIST[@]}"; do
    if [ -e "$GITROOT/$F" ]; then
        echo "$F"
    fi
done
