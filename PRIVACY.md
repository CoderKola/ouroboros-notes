# Privacy

## What leaves your machine

| Action | Leaves? |
|---|---|
| Writing in Obsidian | No, unless sync or a plugin sends it. iCloud or Dropbox folders also sync |
| qmd indexing and searching | No, unless you configure a remote model. Its models download from the internet the first time they are used. In Claude Code the vault's `.mcp.json` turns off qmd's model steps, so a search that needs them fails instead of downloading. qmd commands typed in a terminal, other agents, and a qmd connected another way are not covered |
| Claude reading a note, search result or filename | Yes, to Anthropic. Claude Code also keeps transcripts on your disk |
| Another agent or model reading the same | Yes, to the company running the model, wherever its servers are, unless it runs on your computer. The prompts and hooks below work only in Claude Code; elsewhere private folders rest on instructions, plus any setting your agent has |
| Graphify mapping notes, PDFs or images | Yes, to the AI model it uses. With `/graphify .` in your agent that is its model, but its skill says it uses Google's Gemini if `GEMINI_API_KEY` or `GOOGLE_API_KEY` is set. Ouroboros is told to stop and ask in that case; nothing enforces it |
| `graphify extract` in a terminal | Yes, to whichever AI service it finds a key for. Its README lists several, including one whose servers are in China. Ouroboros is told never to run it. Its docs list a local option, `--backend ollama` |
| Graphify questions | Its README says they are logged on your disk in `~/.cache/graphify-queries.log`; `GRAPHIFY_QUERY_LOG_DISABLE=1` turns that off. In 0.9.115 the code keeps this off unless turned on |
| Installing qmd or Graphify | Downloads other people's code, which runs with your access |
| Auto-refresh, if you turn it on | No. It runs `qmd update` on your computer. Times and errors go to `~/Library/Logs/ouroboros-refresh.log` on a Mac, or the system journal on Linux |

## What starts private

**New vault:** `documents/`, `inbox/`, `personal/finances/`, `personal/health/`,
and each company's `clients/`, `contracts/` and `finances/`.

**Existing vault:** every folder you don't mark open.

**Not private unless you say so:** `job/`, `school/`, `personal/home/`, `logs/`
outside private folders, and any new folder inside an open one. A folder named
`Finances` may not match `finances`. Keep private details out of those.

`FOLDERS.txt` holds the list. Private wins: an open folder inside a private one stays
private. A folder under no open line counts as private to
Ouroboros, the hooks and search. The map, Git and permission lists do not know about
new top-level folders, and loose notes in the vault root are skipped by search only.

| Guardrail | What it does | What it does not do |
|---|---|---|
| `.qmd/index.yml` | Searches only listed folders, minus private ones | Erase what was indexed before. `.qmd/index.sqlite` holds note text; after marking a folder private run `qmd update`, then `qmd cleanup`, then check |
| `.graphifyignore` | Skips private folders when mapping from the vault root | Protect a subfolder mapped on its own: outside Git, that can miss this list and include private notes. Always map from the vault root |
| `.claude/settings.json` | Asks on direct reads by Claude's file tools, when Claude starts at the vault root | Stop shell commands, scripts or wider searches; see below. Avoid auto and bypass modes |
| `.gitignore` | Keeps private folders out of new commits | Undo earlier commits or stop a forced add |
| Optional hooks | Look only in open folders | Anything else. They keep small markers in `~/.local/state/ouroboros-notes` and delete those after 7 days |

## What the prompts miss

**Claude can open a private file without asking you.** In the author's test on a Mac,
with auto mode off, Claude's Read tool asked first. A shell `cat` of the same file
opened it with no prompt, and `find` showed its name.

- **Searches of an open folder** can reach private folders inside it. Searching
  `personal/` also covers `personal/finances/`. An exclude pattern does not reliably
  prevent that.
- Claude is told to read private files only with the Read tool and to leave private
  folders out of searches. Those are instructions, not locks.
- Claude reads `FOLDERS.txt` in normal use, so the private folder names in it go to
  Anthropic.
- If something must never reach Claude, keep it outside the notes folder.

Claude Code's documentation lists `cat`, `find` and `grep` among commands that run
without asking in manual mode.

**Stricter option:** in `.claude/settings.json`, move only the lines that start with
`Read(` from `ask` to a `deny` list. You then open private files yourself. Claude also
cannot create or edit notes there with its file tools, except perhaps notebook files;
you do that yourself. The documentation says it also blocks file commands it
recognizes, such as `cat`, `head`, `tail`, `sed` and `tee`, when the command names the
file. It does not cover searches like `grep -r`, or scripts that open files
themselves. In the author's one test on a Mac, the Read tool, `cat` and creating a
note were refused. A `grep -r` from the folder above still searched the private file.

Claude Code's documentation describes a sandbox that can extend this to shell
commands, with its unsandboxed retry turned off. It approves sandboxed commands
without asking. This kit does not set it up.

Put passwords and identity documents in a password manager. Keep a separate
encrypted backup: none of this is a backup.
