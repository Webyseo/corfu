# Contributing

Corfu is a closure, forecast, and stop-loss auditor for AI coding agents.

Keep the project focused: Corfu exists to help users decide whether agentic coding work should close, validate, narrow, revert, or stop. It is not a general productivity framework.

## Good Contributions

Good contributions make Corfu safer, clearer, or more useful without expanding the product surface:

- clearer audit criteria
- better closure examples
- safer installer behavior
- safer snapshot behavior
- documentation improvements
- support for another agent platform as a small, explicit skill variant

## Not Yet

Do not add these unless the project direction changes explicitly:

- SaaS
- telemetry
- analytics
- package manager integration
- web app
- background agents
- automatic code modification

Corfu must stay audit-only.

## Validation

Run local validation before opening a pull request:

```bash
bash scripts/validate.sh
```

If you change shell scripts, also run:

```bash
bash -n install/*.sh codex/corfu/scripts/corfu_snapshot.sh claude/corfu/scripts/corfu_snapshot.sh
```

## Skill Logic Changes

If you change audit logic, update both skill files:

- `codex/corfu/SKILL.md`
- `claude/corfu/SKILL.md`

The Codex and Claude Code variants should make the same closure decisions unless there is a platform-specific reason to differ.

## Script Safety

Scripts must be safe by default.

- Do not delete destination directories.
- Do not use `rm -rf` in installers.
- Do not make network calls.
- Do not install dependencies.
- Do not access credentials.
- Do not deploy, migrate, push, or mutate project source code.

Installers may only copy Corfu files into the requested skill destination.
