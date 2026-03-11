#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

filename="$1"

if [ ! -f "$filename" ]; then
  echo "Error: file not found: $filename"
  exit 1
fi

docker compose exec notebook python "$filename"
