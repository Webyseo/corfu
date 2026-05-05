#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bash "$SCRIPT_DIR/install_codex_user.sh"
bash "$SCRIPT_DIR/install_claude_user.sh"

echo "Installed Corfu globally for both Codex and Claude Code."
