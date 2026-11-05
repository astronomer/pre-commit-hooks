#!/usr/bin/env bash
# Fail if any filename passed as an argument contains whitespace.
# pre-commit passes the files to check (never deleted ones), so this works for
# commits, --all-files, and --from-ref/--to-ref runs alike.

bad_files=()
for file in "$@"; do
    if [[ "$file" =~ [[:space:]] ]]; then
        bad_files+=("$file")
    fi
done

if [[ ${#bad_files[@]} -gt 0 ]]; then
    echo "Error: Filenames cannot contain whitespace characters (spaces, tabs, etc.):"
    printf '%s\n' "${bad_files[@]}"
    exit 1
fi

exit 0
