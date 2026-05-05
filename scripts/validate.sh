#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

pass() {
  echo "OK: $*"
}

require_file() {
  local file="$1"
  [ -f "$file" ] || fail "Required file missing: $file"
}

require_executable() {
  local file="$1"
  [ -x "$file" ] || fail "Required executable bit missing: $file"
}

require_contains() {
  local file="$1"
  local text="$2"
  grep -Fq "$text" "$file" || fail "$file must contain: $text"
}

reject_contains() {
  local file="$1"
  local text="$2"
  if grep -Fq "$text" "$file"; then
    fail "$file contains forbidden text: $text"
  fi
}

required_files=(
  README.md
  LICENSE
  VERSION
  CHANGELOG.md
  CONTRIBUTING.md
  SECURITY.md
  docs/manual-smoke-tests.md
  docs/release-checklist.md
  docs/workflows.md
  .github/workflows/validate.yml
  .github/PULL_REQUEST_TEMPLATE.md
  .github/ISSUE_TEMPLATE/bug_report.md
  .github/ISSUE_TEMPLATE/feature_request.md
  codex/corfu/SKILL.md
  codex/corfu/scripts/corfu_snapshot.sh
  codex/corfu/agents/openai.yaml
  claude/corfu/SKILL.md
  claude/corfu/scripts/corfu_snapshot.sh
  install/install_codex_repo.sh
  install/install_codex_user.sh
  install/install_claude_project.sh
  install/install_claude_user.sh
  install/install_all_user.sh
  install/install_windows.ps1
  examples/sample_closure_audit.md
  examples/before_after_loop.md
  prompts/usage_prompts.md
)

for file in "${required_files[@]}"; do
  require_file "$file"
done
pass "required files exist"

VERSION="$(tr -d '[:space:]' < VERSION)"
require_contains CHANGELOG.md "## $VERSION"
require_contains README.md "Current version: \`v$VERSION\`"
pass "release version references match VERSION"

while IFS= read -r script; do
  bash -n "$script"
done < <(find . -type f -name "*.sh" -not -path "./.git/*" | sort)
pass "bash syntax is valid"

critical_executables=(
  scripts/validate.sh
  codex/corfu/scripts/corfu_snapshot.sh
  claude/corfu/scripts/corfu_snapshot.sh
  install/install_codex_repo.sh
  install/install_codex_user.sh
  install/install_claude_project.sh
  install/install_claude_user.sh
  install/install_all_user.sh
)

for file in "${critical_executables[@]}"; do
  require_executable "$file"
done
pass "critical shell scripts are executable"

require_contains codex/corfu/SKILL.md "name: corfu"
require_contains claude/corfu/SKILL.md "name: corfu"
require_contains claude/corfu/SKILL.md "disable-model-invocation: true"
require_contains codex/corfu/agents/openai.yaml "allow_implicit_invocation: false"

for skill_file in codex/corfu/SKILL.md claude/corfu/SKILL.md; do
  require_contains "$skill_file" "Do not edit files."
  require_contains "$skill_file" "Do not write implementation code."
  require_contains "$skill_file" "Single Next Action"
  require_contains "$skill_file" "Loop / Token-Burn Analysis"
  require_contains "$skill_file" "Default Invocation"
  require_contains "$skill_file" "Invocation Modes"
  require_contains "$skill_file" "Default Concision"
  require_contains "$skill_file" "If Corfu is invoked without additional instructions"
  require_contains "$skill_file" "Treat short text after \`\$corfu\` or \`/corfu\` as mode/context"
  require_contains "$skill_file" "ship"
  require_contains "$skill_file" "stop"
  require_contains "$skill_file" "pr"
  require_contains "$skill_file" "blocked"
done
pass "skill safety and output contract checks passed"

require_contains README.md "Simplest Use"
require_contains README.md "\$corfu"
require_contains README.md "/corfu"
require_contains README.md "When in doubt, run Corfu before asking the agent to continue."
require_contains README.md "docs/workflows.md"

require_contains prompts/usage_prompts.md "Minimal Commands"
require_contains prompts/usage_prompts.md "\$corfu ship"
require_contains prompts/usage_prompts.md "\$corfu stop"
require_contains prompts/usage_prompts.md "\$corfu pr"
require_contains prompts/usage_prompts.md "\$corfu blocked"

require_contains codex/corfu/agents/openai.yaml "allow_implicit_invocation: false"
pass "invocation UX checks passed"

for snapshot in codex/corfu/scripts/corfu_snapshot.sh claude/corfu/scripts/corfu_snapshot.sh; do
  reject_contains "$snapshot" "rm -rf"
  reject_contains "$snapshot" "sudo"
  reject_contains "$snapshot" "curl"
  reject_contains "$snapshot" "wget"
  reject_contains "$snapshot" "git push"
  reject_contains "$snapshot" "npm install"
  reject_contains "$snapshot" "pnpm install"
  reject_contains "$snapshot" "yarn install"
  reject_contains "$snapshot" "composer install"
  reject_contains "$snapshot" "docker"
  reject_contains "$snapshot" "kubectl"
  reject_contains "$snapshot" "terraform"
done
pass "snapshot scripts avoid obvious dangerous commands"

for installer in install/*.sh; do
  reject_contains "$installer" "rm -rf"
  reject_contains "$installer" "sudo"
  reject_contains "$installer" "curl"
  reject_contains "$installer" "wget"
done
pass "shell installers avoid destructive/network commands"

if command -v pwsh >/dev/null 2>&1; then
  pwsh -NoProfile -Command "\$tokens=\$null; \$errors=\$null; [System.Management.Automation.Language.Parser]::ParseFile('install/install_windows.ps1', [ref]\$tokens, [ref]\$errors) > \$null; if (\$errors.Count -gt 0) { \$errors | ForEach-Object { Write-Error \$_ }; exit 1 }"
  pass "PowerShell parser accepted install/install_windows.ps1"
else
  echo "SKIP: PowerShell parser check (pwsh not available)"
fi

echo "Corfu validation passed."
