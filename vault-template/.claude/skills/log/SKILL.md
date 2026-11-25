---
name: log
description: Record a session or a decision in the vault. Use when the person says "log this" or "save this", or when something was decided, finished, broken or left open.
---

1. Choose the group's `logs/` folder, inside an open folder in `FOLDERS.txt`. If two
   fit, ask.
2. Choose the type:
   - **Decision:** someone would later ask "why?", and it is hard to undo or had
     real alternatives. Use `templates/decision.md`, one decision per file.
   - **Session:** anything else worth finding again. Use `templates/session-log.md`.
3. Record the reasoning and the open items: what the person said, or what you checked
   just now. Nothing from memory of earlier in the chat without checking it again.
   Lasting facts go in the topic's own note, with a link. Keep private details in
   private folders. Just before writing, check that each linked file exists.
4. For a reversed decision, write a new one. Propose setting the old one to
   `status: replaced` with a link.
5. Find notes this made outdated, searching as `CLAUDE.md` says. Show each change and
   wait for a yes.
6. Run `qmd update` in the vault if `.qmd/index.yml` exists. If it fails, say so.

Done when the log exists, each link was checked after writing, and every note it
contradicts is updated or was left by the person's choice. Say a link works only
if you checked it.
