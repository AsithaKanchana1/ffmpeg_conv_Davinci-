#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: $0 <input_file.mkv> [output_file.mov]"
  exit 1
fi

input_file="$1"

if [[ ! -f "$input_file" ]]; then
  echo "Error: input file not found: $input_file"
  exit 1
fi

if [[ $# -eq 2 ]]; then
  output_file="$2"
else
  input_name="$(basename "$input_file")"
  output_file="${input_name%.*}_edit.mov"
fi

ffmpeg -i "$input_file" -map 0 -c:v dnxhd -profile:v dnxhr_sq -c:a pcm_s16le "$output_file"
