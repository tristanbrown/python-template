# Agent Instructions (Subtree)

This directory is managed via Git subtree (with squash) from:
  repo: git@github.com:tristanbrown/agent-instructions.git
  path: .agents/

Initialization (from repo root)
    scripts/agents-init.sh
    # or on Windows PowerShell
    scripts/agents-init.ps1

Update (pull latest changes)
    scripts/agents-update.sh
    # or on Windows PowerShell
    scripts/agents-update.ps1

Notes
- Do not edit files here directly; make changes in the source repo and pull updates.
- The root `AGENTS.md` should link to `.agents/AGENTS.GLOBAL.md` and `AGENTS.PROJECT.md`.
- If this template included only a placeholder `.agents/README.md`, the init scripts remove it before adding the subtree.

Auth/URL notes
- Scripts default to SSH. To use HTTPS instead:
  - Bash: set `REMOTE_URL=https://github.com/tristanbrown/agent-instructions.git`
  - PowerShell: pass `-UseHttps`
