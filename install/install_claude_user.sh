#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCE="$PACKAGE_ROOT/claude/corfu"
VERSION_FILE="$PACKAGE_ROOT/VERSION"
DRY_RUN=0

usage() {
  cat <<'USAGE'
Usage: install/install_claude_user.sh [--dry-run]

Install Corfu for Claude Code in user scope at:
  ~/.claude/skills/corfu

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

[ -n "${HOME:-}" ] || { echo "ERROR: HOME is not set." >&2; exit 1; }
[ -d "$HOME" ] || { echo "ERROR: HOME directory does not exist: $HOME" >&2; exit 1; }
[ -d "$SOURCE" ] || { echo "ERROR: Corfu Claude Code source directory not found: $SOURCE" >&2; exit 1; }
[ -f "$SOURCE/SKILL.md" ] || { echo "ERROR: Missing source file: $SOURCE/SKILL.md" >&2; exit 1; }
[ -f "$SOURCE/scripts/corfu_snapshot.sh" ] || { echo "ERROR: Missing source file: $SOURCE/scripts/corfu_snapshot.sh" >&2; exit 1; }

DEST="$HOME/.claude/skills/corfu"
VERSION="unknown"
[ -f "$VERSION_FILE" ] && VERSION="$(tr -d '[:space:]' < "$VERSION_FILE")"

if [ "$DRY_RUN" -eq 1 ]; then
  echo "Dry run: would install Corfu $VERSION for Claude Code user scope at: $DEST"
  exit 0
fi

mkdir -p "$DEST" || { echo "ERROR: Could not create destination: $DEST" >&2; exit 1; }
cp -R "$SOURCE"/. "$DEST"/ || { echo "ERROR: Could not copy Corfu files to: $DEST" >&2; exit 1; }
chmod +x "$DEST/scripts/corfu_snapshot.sh" 2>/dev/null || true

[ -f "$DEST/SKILL.md" ] || { echo "ERROR: Post-install validation failed: $DEST/SKILL.md missing" >&2; exit 1; }
[ -f "$DEST/scripts/corfu_snapshot.sh" ] || { echo "ERROR: Post-install validation failed: $DEST/scripts/corfu_snapshot.sh missing" >&2; exit 1; }

echo "Installed Corfu $VERSION for Claude Code user scope at: $DEST"
echo "Use in Claude Code with: /corfu"
