#!/usr/bin/env bash

bad_files=()
while IFS= read -r -d '' file; do
    if [[ "$file" =~ [[:space:]] ]]; then
        bad_files+=("$file")
    fi
done < <(git -c core.quotePath=false diff --cached -z --name-only)

if [[ ${#bad_files[@]} -gt 0 ]]; then
    echo "Error: Filenames cannot contain whitespace characters (spaces, tabs, etc.):"
    printf '%s\n' "${bad_files[@]}"
    exit 1
fi

exit 0
