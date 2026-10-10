#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (c) 2026 Jan Michalski

# Scale down MP4 files to 720p.

set -euo pipefail
shopt -s nullglob

input_dir=${1:?Usage: $0 INPUT_DIR [OUTPUT_DIR]}
output_dir=${2:-"$input_dir/scaled"}

mkdir -p -- "$output_dir"

files=("$input_dir"/*.mp4)
if ((${#files[@]} == 0)); then
  echo "No .mp4 files found in: $input_dir" >&2
  exit 1
fi

for input in "${files[@]}"; do
  output="$output_dir/$(basename -- "$input")"

  ffmpeg -i "$input" \
    -vf "scale=-2:720" \
    -c:v libx264 -crf 23 -preset medium \
    -c:a aac -b:a 128k \
    "$output"

  touch -r "$input" "$output"
done
