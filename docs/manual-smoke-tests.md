# Manual Smoke Tests

Manual UI invocation is required because repository validation can prove file structure and script safety, but not agent UI behavior.

## Codex Repo Install

1. Create a temporary repository directory.
2. Run `bash install/install_codex_repo.sh /path/to/temp/repo`.
3. Open Codex in that temporary repo.
4. Invoke `$corfu`.
5. Confirm Corfu produces a closure audit.
6. Confirm no files are edited.
7. Remove the `.agents/` directory after the test unless you intentionally want to keep the repo-local installation.

## Codex User Install

1. Run `bash install/install_codex_user.sh`.
2. Open Codex in any repository.
3. Invoke `$corfu`.
4. Confirm the skill is found.

## Claude Code Project Install

1. Create a temporary repository directory.
2. Run `bash install/install_claude_project.sh /path/to/temp/repo`.
3. Open Claude Code in that temporary repo.
4. Invoke `/corfu`.
5. Confirm the live snapshot appears or failure is clearly reported.
6. Confirm no files are edited.
7. Remove the `.claude/` directory after the test unless you intentionally want to keep the repo-local installation.

## Claude Code User Install

1. Run `bash install/install_claude_user.sh`.
2. Open Claude Code in any repository.
3. Invoke `/corfu`.
4. Confirm the skill is found.

## Windows PowerShell

1. If `pwsh` is available, run a parser check for `install/install_windows.ps1`.
2. Run `.\install\install_windows.ps1 -Tool codex -Scope user -DryRun`.
3. Run `.\install\install_windows.ps1 -Tool claude -Scope project -ProjectPath C:\path\to\repo -DryRun`.
4. If a Windows test environment is available, install user and project scope for Codex and Claude Code.
5. Confirm installed `SKILL.md` and `scripts/corfu_snapshot.sh` exist.
