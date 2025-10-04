#!/usr/bin/env bash
set -euo pipefail

REMOTE_NAME=${REMOTE_NAME:-agent-instructions}
REMOTE_URL=${REMOTE_URL:-git@github.com:tristanbrown/agent-instructions.git}
PREFIX_DIR=${PREFIX_DIR:-.agents}
BRANCH=${BRANCH:-main}

if ! git remote get-url "$REMOTE_NAME" >/dev/null 2>&1; then
  git remote add "$REMOTE_NAME" "$REMOTE_URL"
elif [ "${FORCE:-}" = "1" ]; then
  git remote set-url "$REMOTE_NAME" "$REMOTE_URL"
fi

# Require clean working tree
if [ -n "$(git status --porcelain)" ]; then
  echo "Working tree has modifications. Commit or stash changes before initializing the agents subtree." >&2
  exit 1
fi

# If prefix exists and only contains placeholder README.md, remove it
if [ -d "$PREFIX_DIR" ]; then
  shopt -s nullglob dotglob
  files=("$PREFIX_DIR"/*)
  if [ ${#files[@]} -eq 1 ] && [ "$(basename "${files[0]}")" = "README.md" ]; then
    rm -rf "$PREFIX_DIR"
  elif [ ${#files[@]} -gt 0 ]; then
    echo "Directory '$PREFIX_DIR' already exists and is not empty. Use scripts/agents-update.sh or set FORCE=1 to attempt pull."
    if [ "${FORCE:-}" != "1" ]; then
      exit 1
    fi
  fi
fi

git fetch "$REMOTE_NAME"
if [ -d "$PREFIX_DIR" ]; then
  git subtree pull --prefix="$PREFIX_DIR" "$REMOTE_NAME" "$BRANCH" --squash
else
  git subtree add --prefix="$PREFIX_DIR" "$REMOTE_NAME" "$BRANCH" --squash
fi

echo "Agents subtree initialized/updated at $PREFIX_DIR from $REMOTE_NAME/$BRANCH." 
