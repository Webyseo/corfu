#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DEST="$HOME/.claude/skills/corfu"
SOURCE="$PACKAGE_ROOT/claude/corfu"

mkdir -p "$DEST"
cp -R "$SOURCE"/. "$DEST"/
chmod +x "$DEST/scripts/corfu_snapshot.sh" 2>/dev/null || true

echo "Installed Corfu for Claude Code user scope at: $DEST"
echo "Use in Claude Code with: /corfu"
