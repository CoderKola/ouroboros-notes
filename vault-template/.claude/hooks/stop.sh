#!/bin/bash
# Reminds Claude to offer a log, at most once per session. Uses FOLDERS.txt.
cd "${CLAUDE_PROJECT_DIR:-.}" || exit 0
. ./.claude/hooks/open-notes.sh || exit 0
input=$(cat)
printf '%s' "$input" | grep -Eq '"stop_hook_active"[[:space:]]*:[[:space:]]*true' && exit 0
sid=$(printf '%s' "$input" | sed -n 's/.*"session_id"[[:space:]]*:[[:space:]]*"\([A-Za-z0-9-]*\)".*/\1/p' | head -1)
load_folders || exit 0

state="$HOME/.local/state/ouroboros-notes"
[ ! -L "$state" ] && [ -O "$state" ] || exit 0
start="$state/$sid.start"
[ -n "$sid" ] && [ -e "$start" ] && [ ! -e "$state/$sid.reminded" ] || exit 0

[ -n "$(open_notes -not -path '*/logs/*' -newer "$start" | head -1)" ] || exit 0
[ -z "$(open_notes -path '*/logs/*' -newer "$start" | head -1)" ] || exit 0

touch "$state/$sid.reminded" || exit 0
echo '{"hookSpecificOutput":{"hookEventName":"Stop","additionalContext":"Notes changed this session and nothing is logged. Offer the log skill once, then stop."}}'
exit 0
