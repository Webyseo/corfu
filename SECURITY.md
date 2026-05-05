# Security

Corfu is audit-only.

The skills instruct AI coding agents not to edit files, write implementation code, refactor, run destructive commands, expand scope, or continue implementation after an audit unless the user explicitly asks.

## Snapshot Scripts

The snapshot scripts are intended to be read-only. They inspect local repository state with commands such as `git status`, `git diff --stat`, `find`, and `grep`.

They should not:

- make network calls
- access credentials
- install dependencies
- deploy code
- migrate data
- push commits
- modify repository files

## Telemetry

Corfu does not include telemetry, analytics, tracking, or background agents.

## Privacy

Corfu itself does not make network calls. However, snapshot output may be shown to your AI coding environment.

That output can include:

- filenames
- changed file paths
- TODO/FIXME/HACK lines
- package scripts
- branch and commit metadata
- repository status

Review your repository and AI coding environment policies before running Corfu on sensitive projects.

## Reporting Security Issues

Please report security issues privately by emailing `info@webyseo.es`.

Include:

- affected file or script
- reproduction steps
- expected impact
- suggested fix, if known
