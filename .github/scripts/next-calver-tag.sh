#!/usr/bin/env bash
# Print the next release tag: YYYY.M.D for the first release of a UTC day, then YYYY.M.D+N (N = 1, 2, ...) for later ones that day.
# Semver compatible: no leading zeroes, and +N is build metadata. Reads existing tags from the current repo.
# TAG_DATE (YYYY.M.D) overrides today's date, for tests.
set -euo pipefail

today="${TAG_DATE:-$(date -u +%Y.%-m.%-d)}"
re="^${today//./\\.}(\\+([0-9]+))?$"

highest=-1
while IFS= read -r tag; do
    if [[ "$tag" =~ $re ]]; then
        n="${BASH_REMATCH[2]:-0}"
        ((n > highest)) && highest=$n
    fi
done < <(git tag --list)

if ((highest < 0)); then
    echo "$today"
else
    echo "${today}+$((highest + 1))"
fi
