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

git fetch "$REMOTE_NAME"
git subtree pull --prefix="$PREFIX_DIR" "$REMOTE_NAME" "$BRANCH" --squash

echo "Agents subtree updated in $PREFIX_DIR from $REMOTE_NAME/$BRANCH." 
