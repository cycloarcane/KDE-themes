#!/usr/bin/env bash
set -euo pipefail

# Usage: ./replace_color.sh [path]
# Defaults to current directory if no path given.
TARGET_DIR="${1:-.}"

echo "Scanning '${TARGET_DIR}' for .svg and .qss files…"

# Backup originals with a .bak extension; remove the -i.bak if you don't want backups.
find "$TARGET_DIR" \
  -type f \( -iname '*.svg' -o -iname '*.qss' \) \
  -print0 \
| xargs -0 sed -i.bak 's/#c2c8cf/#ff0000/gi'

echo "Done. All #c2c8cf → #ff0000. Backups saved with .bak extensions."
