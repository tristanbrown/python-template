#!/usr/bin/env bash
set -euo pipefail

REMOTE_NAME="agent-instructions"
PREFIX_DIR=".agents"
BRANCH="main"

git fetch "$REMOTE_NAME"
git subtree pull --prefix="$PREFIX_DIR" "$REMOTE_NAME" "$BRANCH" --squash

echo "Agents subtree updated in $PREFIX_DIR from $REMOTE_NAME/$BRANCH." 

