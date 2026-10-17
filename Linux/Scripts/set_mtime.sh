#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (c) 2026 Jan Michalski

# Fix mtime of JPG and MP4 files so it matches date/time derived from the file name.

set -euo pipefail

dir=${1:?Usage: $0 DIRECTORY}

for file in "$dir"/*; do
    [[ -f "$file" ]] || continue

    name=${file##*/}
    timestamp=
    
    if [[ $name =~ ^(IMG|VID)_([0-9]{4})([0-9]{2})([0-9]{2})_([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{3})?\.(jpg|mp4)$ ]]; then
        timestamp="${BASH_REMATCH[2]}-${BASH_REMATCH[3]}-${BASH_REMATCH[4]} ${BASH_REMATCH[5]}:${BASH_REMATCH[6]}:${BASH_REMATCH[7]}"
        [[ -n ${BASH_REMATCH[8]} ]] && timestamp+=".${BASH_REMATCH[8]}"
    elif [[ $name =~ ^mms_([0-9]{4})([0-9]{2})([0-9]{2})_([0-9]{2})([0-9]{2})([0-9]{2})\.jpg$ ]]; then
        timestamp="${BASH_REMATCH[1]}-${BASH_REMATCH[2]}-${BASH_REMATCH[3]} ${BASH_REMATCH[4]}:${BASH_REMATCH[5]}:${BASH_REMATCH[6]}"
    elif [[ $name =~ ^Screenshot_([0-9]{4})([0-9]{2})([0-9]{2})-([0-9]{2})([0-9]{2})([0-9]{2})\.jpg$ ]]; then
        timestamp="${BASH_REMATCH[1]}-${BASH_REMATCH[2]}-${BASH_REMATCH[3]} ${BASH_REMATCH[4]}:${BASH_REMATCH[5]}:${BASH_REMATCH[6]}"
    elif [[ $name =~ ^IMG-([0-9]{4})([0-9]{2})([0-9]{2})-WA[0-9]+\.jpg$ ]]; then
        timestamp="${BASH_REMATCH[1]}-${BASH_REMATCH[2]}-${BASH_REMATCH[3]} 00:00:00"
    else
        continue
    fi

    if date -d "$timestamp" >/dev/null 2>&1; then
        touch -d "$timestamp" -- "$file"
        printf 'Set mtime: %s → %s\n' "$file" "$timestamp"
    else
        printf 'Skipping invalid date/time: %s\n' "$file" >&2
    fi
done
