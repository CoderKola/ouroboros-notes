# Versions

Setup installs only tools marked **Install**, and turns on **Optional** ones only if the
person asked, using the exact command listed here, after a yes to the plan. Everything else is skipped and reported.

The author installed both of these versions, qmd and Graphify, on a Mac and checked that
each one runs. Both are other people's projects. Check their GitHub pages, read their
security notes and decide for yourself.

| Tool | Official source | Exact package | Version | Command | State |
|---|---|---|---|---|---|
| Obsidian | https://obsidian.md | desktop app | person's choice | the person installs it | Person installs |
| qmd | https://github.com/tobi/qmd | `@tobilu/qmd` (npm) | 2.9.0 | `npm install -g @tobilu/qmd@2.9.0` | Install |
| Graphify | https://github.com/Graphify-Labs/graphify | `graphifyy` (PyPI, two y's) | 0.9.115 | `uv tool install graphifyy==0.9.115`, or `pipx install graphifyy==0.9.115` | Install |
| Auto-refresh of search | this repo | `vault-template/.claude/nightly/` | this repo's | setup, step 4 | Optional, macOS and Linux |
| Claude Code, for hooks | https://code.claude.com | `claude` | 2.1.163 or later | already installed | Needed only for hooks |

What they need, by their own pages:

| Tool | Needs | If missing on macOS | If missing on Linux |
|---|---|---|---|
| qmd | Node 22 or later; Homebrew SQLite on macOS | `brew install node`, `brew install sqlite` | The person installs Node |
| Graphify | Python 3.11.5 to 3.14, and uv or pipx | `brew install python@3.12 uv` | The person installs Python and pipx |

- Use exact versions, never "latest". The packages they pull in are not pinned here.
- Published: qmd 2.9.0 on 2026-11-18 and Graphify 0.9.115 on 2026-11-21 (UTC).
- Changing Graphify's version here means changing it in `vault-template/CLAUDE.md` too.
- **qmd:** plain `qmd` on npm is a different owner's package. 2.8.3 is not listed
  because its dependencies have high-severity advisories.
- The `CI` lock relies on an internal switch in qmd 2.9.0, not a documented setting.
  Check it again before changing the version.
- **Graphify:** use nothing below 0.9.115 (GHSA-g6c9-j4vm-mwq4 and
  GHSA-pcc4-rvhr-2pr8).
