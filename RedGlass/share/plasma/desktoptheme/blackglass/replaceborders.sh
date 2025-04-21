#!/usr/bin/env bash
set -euo pipefail

# Usage: ./replace_borders.sh [theme-dir]
THEME_DIR="${1:-.}"
NEW_COLOR="#ff0000"

echo "Patching window‑border gradients in ${THEME_DIR}…"

# 1) In-range replace inside the <linearGradient id="edge"> block
find "$THEME_DIR" -type f -iname '*.svg' -print0 | \
  xargs -0 sed -i.bak \
    -e '/<linearGradient[^>]*id="edge"/,/<\/linearGradient>/ s/stop-color:[#[:alnum:]]\{6\}/stop-color:'"$NEW_COLOR"'/gi'

# 2) In-range replace inside the <linearGradient id="activeborder"> block
find "$THEME_DIR" -type f -iname '*.svg' -print0 | \
  xargs -0 sed -i.bak \
    -e '/<linearGradient[^>]*id="activeborder"/,/<\/linearGradient>/ s/stop-color:[#[:alnum:]]\{6\}/stop-color:'"$NEW_COLOR"'/gi'

# 3) Fallback: replace any hard‑coded stroke="#7c7c7c" or stroke="#121212"
find "$THEME_DIR" -type f \( -iname '*.svg' -o -iname '*.qss' \) -print0 | \
  xargs -0 sed -i.bak \
    -e 's/stroke="#7c7c7c"/stroke="'"$NEW_COLOR"'"/gi' \
    -e 's/stroke="#121212"/stroke="'"$NEW_COLOR"'"/gi'

echo "Done. Backups saved as .bak. Reload Plasma to see changes:"
echo "  kquitapp5 plasmashell && kstart5 plasmashell"
