# Agent Instructions (Subtree)

This directory is managed via Git subtree (with squash) from:
  repo: git@github.com:tristanbrown/agent-instructions.git
  path: .agents/

Initialization (from repo root)
    git remote add agent-instructions git@github.com:tristanbrown/agent-instructions.git
    git fetch agent-instructions
    git subtree add --prefix=.agents agent-instructions main --squash

Update (pull latest changes)
    git fetch agent-instructions
    git subtree pull --prefix=.agents agent-instructions main --squash

Notes
- Do not edit files here directly; make changes in the source repo and pull updates.
- The root `AGENTS.md` should link to `.agents/AGENTS.GLOBAL.md` and `AGENTS.PROJECT.md`.

