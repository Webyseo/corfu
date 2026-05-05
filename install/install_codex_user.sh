#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DEST="$HOME/.agents/skills/corfu"
SOURCE="$PACKAGE_ROOT/codex/corfu"

mkdir -p "$DEST"
cp -R "$SOURCE"/. "$DEST"/
chmod +x "$DEST/scripts/corfu_snapshot.sh" 2>/dev/null || true

echo "Installed Corfu for Codex user scope at: $DEST"
echo "Use in Codex with: \$corfu"
