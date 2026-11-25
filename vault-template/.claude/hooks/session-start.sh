#!/bin/bash
# Lists recent logs and says how many open notes changed since. Uses FOLDERS.txt.
# Deletes its own markers in ~/.local/state/ouroboros-notes after 7 days.
cd "${CLAUDE_PROJECT_DIR:-.}" || exit 0
. ./.claude/hooks/open-notes.sh || exit 0
input=$(cat)
sid=$(printf '%s' "$input" | sed -n 's/.*"session_id"[[:space:]]*:[[:space:]]*"\([A-Za-z0-9-]*\)".*/\1/p' | head -1)
[ -n "$sid" ] || exit 0
load_folders || exit 0

state="$HOME/.local/state/ouroboros-notes"
[ ! -L "$state" ] && mkdir -p "$state" && [ -O "$state" ] && chmod 700 "$state" || exit 0
find "$state" -maxdepth 1 -type f \( -name '*.start' -o -name '*.reminded' \) -mtime +7 -delete 2>/dev/null
[ -e "$state/$sid.start" ] || touch "$state/$sid.start"

logs=$(open_notes -path '*/logs/*' | LC_ALL=C grep -E '^\./[A-Za-z0-9/_-]+/logs/[0-9]{4}-[0-9]{2}-[0-9]{2}-[a-z0-9-]+\.md$')
[ -n "$logs" ] || { echo "Ouroboros: no logs yet."; exit 0; }

echo "Ouroboros: recent logs, read if relevant:"
printf '%s\n' "$logs" | awk -F/ '{print $NF "\t" $0}' | sort -r | head -3 | cut -f2

newest=""
while IFS= read -r f; do
  if [ -z "$newest" ] || [ "$f" -nt "$newest" ]; then newest=$f; fi
done <<< "$logs"
count=$(open_notes -not -path '*/logs/*' -newer "$newest" | wc -l | tr -d ' ')
[ "$count" = 0 ] || echo "$count open note(s) changed since the last log. Offer to log them."
exit 0
