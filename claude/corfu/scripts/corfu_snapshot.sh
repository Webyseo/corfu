#!/usr/bin/env bash
set -euo pipefail

echo "# Corfu Repository Snapshot"
echo

echo "## Time"
date || true
echo

echo "## Working Directory"
pwd || true
echo

echo "## Git Root"
git rev-parse --show-toplevel 2>/dev/null || true
echo

echo "## Current Branch"
git branch --show-current 2>/dev/null || true
echo

echo "## Git Status"
git status --short 2>/dev/null || true
echo

echo "## Diff Stat"
git diff --stat HEAD 2>/dev/null || true
echo

echo "## Changed Files"
git diff --name-only HEAD 2>/dev/null || true
echo

echo "## Staged Files"
git diff --cached --name-only 2>/dev/null || true
echo

echo "## Untracked Files"
git ls-files --others --exclude-standard 2>/dev/null | head -120 || true
echo

echo "## Diff Check"
git diff --check 2>/dev/null || true
echo

echo "## Recent Commits"
git log --oneline -8 2>/dev/null || true
echo

echo "## Project Manifests"
find . -maxdepth 4 \
  \( -name "package.json" \
  -o -name "composer.json" \
  -o -name "pyproject.toml" \
  -o -name "requirements.txt" \
  -o -name "Pipfile" \
  -o -name "poetry.lock" \
  -o -name "pnpm-lock.yaml" \
  -o -name "yarn.lock" \
  -o -name "package-lock.json" \
  -o -name "vite.config.*" \
  -o -name "next.config.*" \
  -o -name "astro.config.*" \
  -o -name "nuxt.config.*" \
  -o -name "tsconfig.json" \
  -o -name "phpunit.xml" \
  -o -name "playwright.config.*" \
  -o -name "cypress.config.*" \
  -o -name "Makefile" \
  \) \
  -not -path "./node_modules/*" \
  -not -path "./vendor/*" \
  -not -path "./.git/*" \
  -not -path "./.agents/*" \
  -not -path "./.claude/*" \
  -not -path "./.codex/*" \
  2>/dev/null | sort || true
echo

echo "## Package Scripts"
if [ -f package.json ]; then
  if command -v node >/dev/null 2>&1; then
    node -e '
      const fs = require("fs");
      const pkg = JSON.parse(fs.readFileSync("package.json", "utf8"));
      const scripts = pkg.scripts || {};
      for (const [name, cmd] of Object.entries(scripts)) {
        console.log(`${name}: ${cmd}`);
      }
    ' 2>/dev/null || true
  elif command -v python3 >/dev/null 2>&1; then
    python3 - <<'PYCODE' 2>/dev/null || true
import json
with open("package.json", "r", encoding="utf-8") as f:
    pkg = json.load(f)
for name, cmd in (pkg.get("scripts") or {}).items():
    print(f"{name}: {cmd}")
PYCODE
  else
    grep -A 60 '"scripts"' package.json 2>/dev/null || true
  fi
else
  echo "No package.json found at repository root."
fi
echo

echo "## Composer Scripts"
if [ -f composer.json ]; then
  if command -v python3 >/dev/null 2>&1; then
    python3 - <<'PYCODE' 2>/dev/null || true
import json
with open("composer.json", "r", encoding="utf-8") as f:
    pkg = json.load(f)
for name, cmd in (pkg.get("scripts") or {}).items():
    print(f"{name}: {cmd}")
PYCODE
  else
    grep -A 60 '"scripts"' composer.json 2>/dev/null || true
  fi
else
  echo "No composer.json found at repository root."
fi
echo

echo "## TODO / FIXME / HACK Markers"
grep -R "TODO\|FIXME\|HACK\|XXX\|TEMP\|WIP" -n \
  --exclude-dir=node_modules \
  --exclude-dir=vendor \
  --exclude-dir=.git \
  --exclude-dir=.agents \
  --exclude-dir=.claude \
  --exclude-dir=.codex \
  --exclude-dir=dist \
  --exclude-dir=build \
  --exclude-dir=.next \
  . 2>/dev/null | head -120 || true
echo

echo "## Potentially Relevant Error Logs"
find . -maxdepth 4 \
  \( -name "*.log" -o -name "npm-debug.log" -o -name "yarn-error.log" -o -name "pnpm-debug.log" \) \
  -not -path "./node_modules/*" \
  -not -path "./vendor/*" \
  -not -path "./.git/*" \
  -not -path "./.agents/*" \
  -not -path "./.claude/*" \
  -not -path "./.codex/*" \
  2>/dev/null | sort | head -50 || true
echo

echo "# End of Corfu Snapshot"
