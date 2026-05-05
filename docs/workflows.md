# Corfu Workflows

## Before Commit

1. Finish the intended change.
2. Run the relevant validation if available.
3. Run `$corfu pr` or `/corfu pr`.
4. Commit only if Corfu says `CLOSABLE` or `CLOSABLE WITH RISK`.
5. If Corfu says `NOT CLOSABLE`, do only the single next action.
6. If Corfu says `BLOCKED`, stop and resolve the blocker first.

## When the Agent Loops

1. Stop implementation.
2. Run `$corfu stop` or `/corfu stop`.
3. If ROI is `LOW` or `NEGATIVE`, do not continue coding.
4. Follow only the single next action.

## Before Release

1. Confirm version metadata and changelog.
2. Run validation.
3. Run `$corfu release` or `/corfu release`.
4. Release only if Corfu says `CLOSABLE` or `CLOSABLE WITH RISK`.
5. Do not polish after release readiness is already established unless there is a must-fix.
