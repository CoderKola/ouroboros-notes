#!/bin/bash
# Refreshes this vault's keyword search index. No AI, no model downloads.
# Does nothing unless a schedule runs it. Usage: refresh.sh VAULT_PATH QMD_PATH
vault=$1
qmd=$2

stop() { echo "$(date '+%Y-%m-%d %H:%M') stopped: $1"; exit 1; }

case "$vault" in /*) ;; *) stop "the vault needs a full path" ;; esac
case "$qmd" in /*) ;; *) stop "qmd needs a full path" ;; esac
[ -d "$vault" ] && [ ! -L "$vault" ] || stop "vault folder not found, or it is a symlink"
[ -d "$vault/.qmd" ] && [ ! -L "$vault/.qmd" ] || stop "no search setup in the vault"
# Without this file qmd would use the person's other index, so never go on.
[ -f "$vault/.qmd/index.yml" ] && [ ! -L "$vault/.qmd/index.yml" ] || stop "no search setup in the vault"
[ -x "$qmd" ] || stop "qmd not found"
cd "$vault" || stop "cannot open the vault"

"$qmd" update >/dev/null 2>&1 || stop "qmd update failed"
echo "$(date '+%Y-%m-%d %H:%M') search refreshed"
