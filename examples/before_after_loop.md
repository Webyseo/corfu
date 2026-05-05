# Before and After Corfu

## Before Corfu

```text
Agent: I reviewed the component and can improve the structure a bit more.
Agent: I also noticed a naming inconsistency, so I will clean that up.
Agent: The tests were not run yet, but the change should work.
Agent: I found another possible issue in the layout and will adjust it too.
Agent: Let me inspect the same files again to make sure.
```

Result:

- more code
- wider scope
- no new evidence
- unclear closure point
- higher token spend

## After Corfu

```text
# Corfu Closure Audit

## State

CLOSABLE WITH RISK

## Confidence

74%

## Must-Fix

- None.

## Loop / Token-Burn Analysis

Loop risk: HIGH

Signals:
- The agent is proposing polish after the core objective appears satisfied.
- Tests are being discussed but not run.
- The diff is likely to grow without reducing uncertainty.

ROI of continuing: LOW

## Recommended Decision

Run one validation

## Single Next Action

Run the existing targeted test or build command; if it passes, close the task.

## Final Ruling

Do not keep coding. The only valuable next step is validation.
```

Result:

- one decision
- one validation
- bounded risk
- no speculative cleanup
