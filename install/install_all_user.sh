#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
VERSION_FILE="$PACKAGE_ROOT/VERSION"
DRY_RUN=0

usage() {
  cat <<'USAGE'
Usage: install/install_all_user.sh [--dry-run]

Install Corfu globally for both Codex and Claude Code.

Options:
  --dry-run    Show what would be installed without copying files.
  -h, --help   Show this help message.
USAGE
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run)
      DRY_RUN=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
  shift
done

VERSION="unknown"
[ -f "$VERSION_FILE" ] && VERSION="$(tr -d '[:space:]' < "$VERSION_FILE")"

if [ "$DRY_RUN" -eq 1 ]; then
  bash "$SCRIPT_DIR/install_codex_user.sh" --dry-run
  bash "$SCRIPT_DIR/install_claude_user.sh" --dry-run
  echo "Dry run: would install Corfu $VERSION globally for both Codex and Claude Code."
  exit 0
fi

bash "$SCRIPT_DIR/install_codex_user.sh"
bash "$SCRIPT_DIR/install_claude_user.sh"

echo "Installed Corfu $VERSION globally for both Codex and Claude Code."
