#!/usr/bin/env bash
# Self-test for next-calver-tag.sh, run in a throwaway repo.
set -euo pipefail

script="$(cd "$(dirname "$0")" && pwd)/next-calver-tag.sh"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
cd "$tmp"
git init -q .
git -c user.name=t -c user.email=t@t commit -q --allow-empty -m init

fail=0
check() { # check <expected> <TAG_DATE>
    local got
    got="$(TAG_DATE="$2" "$script")"
    if [[ "$got" != "$1" ]]; then
        echo "FAIL: TAG_DATE=$2 expected $1 got $got"
        fail=1
    fi
}

check "2026.11.5" "2026.11.5" # no tags at all
git tag 2026.11.5
check "2026.11.5+1" "2026.11.5" # second release the same day
git tag "2026.11.5+1"
check "2026.11.5+2" "2026.11.5"
git tag "2026.11.5+9"
git tag "2026.11.5+10"
check "2026.11.5+11" "2026.11.5" # numeric, not lexical, comparison of N
check "2026.11.6" "2026.11.6"    # a new day starts over
git tag 2026.1.1
check "2026.1.1+1" "2026.1.1"
check "2026.1.10" "2026.1.10" # 2026.1.1 must not match 2026.1.10
git tag v1.0.0
check "2026.11.7" "2026.11.7" # unrelated tags are ignored

exit "$fail"
