# Sample Closure Audit

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

## Evidence

- The diff is limited to the requested UI component and one shared helper.
- The implementation matches the stated acceptance criteria.
- No unrelated files are changed.
- Build validation has not been run in the current turn.

## Must-Fix

- None.

## Should-Fix

- Add one regression test if this flow is business-critical.

## Risks

- Risk: Build failure may still exist because validation has not run.
  - Impact: Medium.
  - Likelihood: Low.
  - Mitigation: Run the existing build command before closing.

## Loop / Token-Burn Analysis

Loop risk: MEDIUM

Signals:
- The next proposed changes are polish, not closure blockers.
- The remaining uncertainty can be resolved by one validation command.

ROI of continuing: LOW

## Scope Drift

Scope drift: LOW

Explanation:
- Changes are adjacent to the requested task and do not introduce a new product direction.

## Recommended Decision

Run one validation

## Single Next Action

Run `pnpm build` and close if it passes.

## Final Ruling

The work is closable if the build passes; do not spend more agent turns on polish.
```
