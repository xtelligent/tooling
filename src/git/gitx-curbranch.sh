#!/usr/bin/env bash
set -e
# This is just be `git branch --show-current` after git 2.22.
# We don't have this version yet in debian buster (build image). Not sure
# why this does not keep up.
git branch -l \
    | grep '* ' \
    | awk '{print $2}'
