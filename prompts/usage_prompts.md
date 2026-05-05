# Corfu Usage Prompts

Use these prompts when you want the agent to stop implementing and produce a closure decision.

## Minimal Commands

```text
$corfu
```

Default closure audit.

```text
/corfu
```

Default closure audit in Claude Code.

```text
$corfu ship
```

Ship or release readiness.

```text
$corfu product
```

Product or roadmap readiness audit. Use this when a clean repo is not enough and you want to know whether the wider project is actually complete.

```text
$corfu roadmap
```

Roadmap-level closure audit.

```text
$corfu stop
```

Stop-loss audit for loops, scope drift, and token burn.

```text
$corfu pr
```

Pre-PR or pre-commit audit.

```text
$corfu blocked
```

Check whether the task requires a human, product, or environment decision.

## Advanced Examples

### Stop Token Burn

```text
/corfu

Stop implementation. Audit the current work. Decide whether continuing has positive ROI. If not, recommend closure, validation, or human decision. Do not edit files.
```

### Ship Readiness

```text
/corfu

Run a closure audit for this feature against the original objective. Classify the state, estimate minimum viable closure, proper closure, and polished closure. Give one next action only. Do not edit files.
```

### Codex Explicit Invocation

```text
$corfu

Audit the current work. Do not edit files. Decide whether this is closable, what remains, whether we are burning tokens, and the single highest-ROI next action.
```

### Hard Stop

```text
/corfu

Assume token budget is nearly exhausted. Produce a closure audit and choose exactly one next action. If evidence is insufficient, say what single validation or human decision is required. Do not continue implementation.
```

### Pre-PR Audit

```text
$corfu

Audit this branch before PR creation. Separate must-fix from should-fix, identify any scope drift, and give exactly one next action. Do not edit files.
```

### Human Decision Check

```text
/corfu

Decide whether the remaining uncertainty requires a human product decision. If yes, stop and write the smallest question that needs to be answered. Do not edit files.
```
