**Agent Instructions**
- Global rules: `.agents/AGENTS.GLOBAL.md`
- Project rules: `AGENTS.PROJECT.md`

Notes
- The `.agents/` folder is maintained via Git subtree (squash) from `agent-instructions`.
- To initialize or update, use the scripts in `scripts/`.
- Ensure your working tree is clean (commit or stash) before running the scripts.

Precedence
- If rules conflict, `AGENTS.PROJECT.md` overrides `.agents/AGENTS.GLOBAL.md` by default.

Commands
- Init: `scripts/agents-init.sh` or `scripts/agents-init.ps1`
- Update: `scripts/agents-update.sh` or `scripts/agents-update.ps1`
- Defaults to SSH. To use HTTPS, set `REMOTE_URL=https://...` (bash) or pass `-UseHttps` (PowerShell).
