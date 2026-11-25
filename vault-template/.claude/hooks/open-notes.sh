#!/bin/bash
# Shared by the hooks. Reads FOLDERS.txt as data; a missing or invalid list means stop.
shopt -s nocasematch

load_folders() {
  local list="FOLDERS.txt" rule='^(open|private) ([A-Za-z0-9._][A-Za-z0-9 ._/-]*)$'
  local line kind path o p root
  local opens=() privates=()
  root=$(pwd -P) || return 1
  [ -f "$list" ] && [ ! -L "$list" ] || return 1
  while IFS= read -r line || [ -n "$line" ]; do
    [ -n "$line" ] || continue
    LC_ALL=C
    [[ $line =~ $rule ]] || return 1
    kind=${BASH_REMATCH[1]} path=${BASH_REMATCH[2]}
    case "$path" in *..*|*//*|*/|*' '|.|./*|*/./*|*/.) return 1 ;; esac
    if [ "$kind" = open ]; then opens+=("$path"); else privates+=("$path"); fi
  done < "$list"

  start_paths=() skip=()
  for p in "${privates[@]}"; do skip+=(-o -ipath "./$p"); done
  for o in "${opens[@]}"; do
    [ -d "$o" ] && [ "$(cd "$o" && pwd -P)" = "$root/$o" ] || continue
    for p in "${privates[@]}"; do
      [[ "$o/" == "$p/"* ]] && continue 2
    done
    start_paths+=("./$o")
  done
  [ ${#start_paths[@]} -gt 0 ]
}

open_notes() {
  find "${start_paths[@]}" \( -name '.?*' "${skip[@]}" \) -prune \
    -o -type f -name '*.md' "$@" -print 2>/dev/null | sort -u
}
