# Security

Plain files, a few short scripts, and no account, server or telemetry of its own.
Read them before you use them.

## How it's built

- Setup is told to show a full plan and wait for one yes. It never uses sudo.
- Tool versions are pinned in [VERSIONS.md](VERSIONS.md).
- Search leaves private folders out and uses keywords only. In Claude Code, qmd's AI
  search is switched off to prevent a surprise model download.
- If an install fails, setup is told to stop that tool, report it and finish the rest.
  Your notes work without it.

## What I ran

On macOS, with Claude Code and invented notes or files:

- Keyword search with qmd, and the block on its AI search.
- A question answered from open notes, with two planted private notes nearby. Neither
  showed up in the session record.
- A small code map with Graphify.

AI can answer differently each time.

## Know before you use it

- Privacy rules are instructions to an AI, not locks. A command such as `cat` can open
  a private file without asking. See [PRIVACY.md](PRIVACY.md).
- qmd and Graphify are other people's projects, and their installs run with your access.

Found a problem? Open an issue, without private details.
