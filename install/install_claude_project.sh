#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCE="$PACKAGE_ROOT/claude/corfu"
VERSION_FILE="$PACKAGE_ROOT/VERSION"
DRY_RUN=0

usage() {
  cat <<'USAGE'
Usage: install/install_claude_project.sh [--dry-run] [repo-path]

Install Corfu for Claude Code into a repository at:
  <repo-path>/.claude/skills/corfu

Arguments:
  repo-path    Target repository directory. Defaults to the current directory.

Options:
  --dry-run    Show what would be installed without copying files.
  -h, --help   Show this help message.
USAGE
}

TARGET_REPO=""
while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run)
      DRY_RUN=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    -*)
      echo "ERROR: Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
    *)
      if [ -n "$TARGET_REPO" ]; then
        echo "ERROR: Only one repo path may be provided." >&2
        usage >&2
        exit 1
      fi
      TARGET_REPO="$1"
      ;;
  esac
  shift
done

TARGET_REPO="${TARGET_REPO:-$(pwd)}"
[ -d "$SOURCE" ] || { echo "ERROR: Corfu Claude Code source directory not found: $SOURCE" >&2; exit 1; }
[ -f "$SOURCE/SKILL.md" ] || { echo "ERROR: Missing source file: $SOURCE/SKILL.md" >&2; exit 1; }
[ -f "$SOURCE/scripts/corfu_snapshot.sh" ] || { echo "ERROR: Missing source file: $SOURCE/scripts/corfu_snapshot.sh" >&2; exit 1; }
[ -d "$TARGET_REPO" ] || { echo "ERROR: Target repository directory does not exist: $TARGET_REPO" >&2; exit 1; }

TARGET_REPO="$(cd "$TARGET_REPO" && pwd)"
DEST="$TARGET_REPO/.claude/skills/corfu"
VERSION="unknown"
[ -f "$VERSION_FILE" ] && VERSION="$(tr -d '[:space:]' < "$VERSION_FILE")"

if [ "$DRY_RUN" -eq 1 ]; then
  echo "Dry run: would install Corfu $VERSION for Claude Code at: $DEST"
  exit 0
fi

mkdir -p "$DEST" || { echo "ERROR: Could not create destination: $DEST" >&2; exit 1; }
cp -R "$SOURCE"/. "$DEST"/ || { echo "ERROR: Could not copy Corfu files to: $DEST" >&2; exit 1; }
chmod +x "$DEST/scripts/corfu_snapshot.sh" 2>/dev/null || true

[ -f "$DEST/SKILL.md" ] || { echo "ERROR: Post-install validation failed: $DEST/SKILL.md missing" >&2; exit 1; }
[ -f "$DEST/scripts/corfu_snapshot.sh" ] || { echo "ERROR: Post-install validation failed: $DEST/scripts/corfu_snapshot.sh missing" >&2; exit 1; }

echo "Installed Corfu $VERSION for Claude Code project scope at: $DEST"
echo "Use in Claude Code with: /corfu"
