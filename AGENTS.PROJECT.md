# AGENTS.PROJECT.md

This file defines project-specific rules and context.  
It supplements `.agents/AGENTS.GLOBAL.md` and overrides it where conflicts arise.

---

## Project entrypoint and test surface

This project is currently a **backend-first package**.

- The primary entrypoints must be **importable objects with method-based access**.
- Backend functionality should be UI-agnostic, for later integration into web and mobile apps, CLI tools, and APIs.
- Do not attempt to implement UI yet. 

## Excluded context

Unless specifically requested, do not read or derive context from:
- `.drafts/`
- `.compare/`
- older git commits or alternate branches

But if I specifically request a comparison between alternate file versions in these directories or alternate git branches, then reading them is acceptable and required. 
