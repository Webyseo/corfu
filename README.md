# Corfu

**Stop AI coding agents before they burn tokens.**

Corfu is a closure, forecast, and stop-loss auditor for AI-assisted software development. It helps you decide whether a task is shippable, risky, blocked, drifting in scope, or no longer worth continuing.

It works as a local skill for **Codex** and **Claude Code**.

Current version: `v0.1.1`

## Quick Install from Zero

```bash
git clone https://github.com/Webyseo/corfu.git
cd corfu
bash install/install_all_user.sh
```

Clone the repo or download the latest release archive from GitHub.

## Prerequisites

- Git
- Bash on macOS/Linux or PowerShell on Windows
- Codex and/or Claude Code installed

## The 10-Second Version

AI coding agents are good at continuing. Corfu is designed to make them stop, inspect evidence, and give one operational decision:

- close now
- run one validation
- make one narrow fix
- revert unrelated work
- stop and ask for a human decision
- do not continue

Corfu does not make agents code faster. Corfu helps you stop at the right time.

## Why Corfu Exists

Agentic coding sessions often fail in the same ways:

- The agent keeps editing after the core task is already done.
- Scope expands from a narrow fix into speculative cleanup.
- Tests are discussed but not run.
- The diff grows while confidence falls.
- The agent says "done" without enough evidence.
- A missing product decision is treated like an implementation problem.

Corfu turns that ambiguity into a closure audit.

## What Corfu Does

When invoked, Corfu audits the current repository state and returns:

- `CLOSABLE`, `CLOSABLE WITH RISK`, `NOT CLOSABLE`, or `BLOCKED`
- confidence score
- minimum viable, proper, and polished closure forecast
- evidence from the repo snapshot
- must-fix vs should-fix separation
- loop and token-burn analysis
- scope drift assessment
- exactly one next action

## Safety Model

Corfu is audit-only.

The skill instructions explicitly tell the agent:

- do not edit files
- do not write implementation code
- do not refactor
- do not run destructive commands
- do not expand scope
- do not continue implementation after the audit unless the user explicitly asks

The bundled snapshot script is read-only. It uses local commands such as `git status`, `git diff --stat`, `find`, and `grep`. It does not access credentials, make network calls, modify files, deploy, migrate data, or run package installation.

The install scripts only copy the skill files into the target skill directory.

## Privacy Note

Corfu itself does not make network calls. However, snapshot output may be shown to your AI coding environment and can include filenames, changed paths, TODO/FIXME/HACK lines, package scripts, branch metadata, and repository status.

Review your repository and AI coding environment policies before running Corfu on sensitive projects.

## Repository Layout

```text
corfu/
  README.md
  LICENSE
  VERSION
  codex/
    corfu/
      SKILL.md
      scripts/corfu_snapshot.sh
      references/
      agents/openai.yaml
  claude/
    corfu/
      SKILL.md
      scripts/corfu_snapshot.sh
      references/
  install/
    install_codex_repo.sh
    install_codex_user.sh
    install_claude_project.sh
    install_claude_user.sh
    install_all_user.sh
    install_windows.ps1
  scripts/
    validate.sh
  examples/
    sample_closure_audit.md
    before_after_loop.md
  prompts/
    usage_prompts.md
```

## Install for Codex

Recommended for daily use: install Corfu globally for your user:

```bash
bash install/install_codex_user.sh
```

This installs the skill at:

```text
~/.agents/skills/corfu
```

Advanced/project-local: install Corfu into a specific repository:

```bash
bash install/install_codex_repo.sh /path/to/your/repo
```

This installs the skill at:

```text
<repo>/.agents/skills/corfu
```

Use it in Codex:

```text
$corfu

Audit the current work. Do not edit files. Decide whether this is closable, what remains, whether we are burning tokens, and the single highest-ROI next action.
```

## Install for Claude Code

Recommended for daily use: install Corfu globally for your user:

```bash
bash install/install_claude_user.sh
```

This installs the skill at:

```text
~/.claude/skills/corfu
```

Advanced/project-local: install Corfu into a specific repository:

```bash
bash install/install_claude_project.sh /path/to/your/repo
```

This installs the skill at:

```text
<repo>/.claude/skills/corfu
```

Repo-scope installation creates `.agents/` or `.claude/` inside the target repository. These directories may appear as untracked in git status. Do not commit them unless you intentionally want to vendor Corfu into that repository.

Use it in Claude Code:

```text
/corfu

Audit the current work. Do not edit files. Decide whether this is closable, what remains, whether we are burning tokens, and the single highest-ROI next action.
```

## Install for Both

```bash
bash install/install_all_user.sh
```

All shell installers support `--help` and `--dry-run`:

```bash
bash install/install_all_user.sh --dry-run
```

## Windows

PowerShell installation is available for user or project scope:

```powershell
.\install\install_windows.ps1 -Tool codex -Scope user
.\install\install_windows.ps1 -Tool claude -Scope project -ProjectPath C:\path\to\repo
```

## Verify Installation

For Codex, confirm the skill exists at one of these paths:

```text
~/.agents/skills/corfu/SKILL.md
<repo>/.agents/skills/corfu/SKILL.md
```

For Claude Code, confirm the skill exists at one of these paths:

```text
~/.claude/skills/corfu/SKILL.md
<repo>/.claude/skills/corfu/SKILL.md
```

Then invoke it explicitly with `$corfu` in Codex or `/corfu` in Claude Code.

## Validation

Validate the repository locally:

```bash
bash scripts/validate.sh
```

This checks required files, shell syntax, executable bits, core safety text, manual invocation settings, and obvious dangerous commands in snapshot scripts.

## Manual Smoke Tests

Manual UI checks are listed in [`docs/manual-smoke-tests.md`](docs/manual-smoke-tests.md).

## Usage Examples

Stop a looping coding session:

```text
/corfu

Stop implementation. Audit the current work. Decide whether continuing has positive ROI. If not, recommend closure, validation, or human decision. Do not edit files.
```

Audit ship readiness:

```text
$corfu

Run a closure audit for this feature against the original objective. Classify the state, estimate minimum viable closure, proper closure, and polished closure. Give one next action only. Do not edit files.
```

Force a hard stop:

```text
/corfu

Assume token budget is nearly exhausted. Produce a closure audit and choose exactly one next action. If evidence is insufficient, say what single validation or human decision is required. Do not continue implementation.
```

More prompts are available in [`prompts/usage_prompts.md`](prompts/usage_prompts.md).

## Real-World Examples

- [Codex CLI read-only smoke test, v0.1.1](examples/real-world/codex-cli-readonly-v0.1.1.md)

## Sample Output

```text
# Corfu Closure Audit

## State

CLOSABLE WITH RISK

## Confidence

78%

## Closure Forecast

Minimum viable closure:
- Estimate: 1 focused turn
- Confidence: 80%
- What it includes: Run the existing build command and attach the result to the PR.

Proper closure:
- Estimate: 2-3 focused turns
- Confidence: 65%
- What it includes: Build, one targeted regression test, and PR notes.

Polished closure:
- Estimate: half day
- Confidence: 45%
- What it includes: Broader browser checks and optional cleanup.

## Must-Fix

- None.

## Loop / Token-Burn Analysis

Loop risk: MEDIUM

ROI of continuing: LOW

## Recommended Decision

Run one validation

## Single Next Action

Run `pnpm build` and close if it passes.

## Final Ruling

The work is closable if the build passes; do not spend more agent turns on polish.
```

See [`examples/sample_closure_audit.md`](examples/sample_closure_audit.md) and [`examples/before_after_loop.md`](examples/before_after_loop.md).

## When to Use Corfu

Use Corfu when you are asking:

- Are we done?
- Can this ship?
- What remains to close this?
- Is the agent going in circles?
- Are we burning tokens?
- Is this blocked on a human decision?
- What is the minimum responsible path to closure?

Do not use Corfu when you want the agent to implement a feature. Use it when you want a decision about whether implementation should continue.

## Roadmap

- v0.1.0: Codex and Claude Code skills, safe repo snapshot, install scripts, examples.
- v0.2.0: More examples from real-world web app, backend, and library tasks.
- v0.3.0: Optional GitHub PR checklist template.
- Later: Cursor and Gemini CLI variants if users request them.

Non-goals for the first release:

- SaaS
- telemetry
- analytics
- package manager integration
- background agents
- automatic code modification

## Contributing

Issues and pull requests are welcome.

Good contributions are focused on making Corfu more accurate, safer, and easier to install:

- clearer audit criteria
- better closure examples
- safer shell behavior
- additional agent platform variants
- documentation improvements

Please keep Corfu focused. It is a stop-loss and closure auditor, not a general productivity framework.

## License

MIT. See [`LICENSE`](LICENSE).
