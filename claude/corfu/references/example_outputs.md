# Corfu Example Outputs

## Example 1 — Closable

```text
# Corfu Closure Audit

## State

CLOSABLE

## Confidence

86%

## Closure Forecast

Minimum viable closure:
- Estimate: 0 turns
- Confidence: 86%
- What it includes: Commit or PR creation.

Proper closure:
- Estimate: 1 focused turn
- Confidence: 75%
- What it includes: Add PR summary and note validation result.

Polished closure:
- Estimate: 1 short dev session
- Confidence: 55%
- What it includes: Optional extra regression test.

## Evidence

- Diff is limited to the requested component and route.
- Build passed.
- No unresolved TODO/FIXME markers were introduced.

## Must-Fix

- None.

## Should-Fix

- Add one regression test if this flow is business-critical.

## Risks

- Risk: Browser-specific visual regression not checked.
  - Impact: Low.
  - Likelihood: Low.
  - Mitigation: Manual visual check before deploy if needed.

## Loop / Token-Burn Analysis

Loop risk: LOW

Signals:
- Next action is clear.
- No evidence of repeated failed attempts.

ROI of continuing: LOW

## Scope Drift

Scope drift: NONE

Explanation:
- Changed files match the requested scope.

## Recommended Decision

Close now

## Single Next Action

Create the PR with the validation evidence.

## Final Ruling

The work is closable now; do not spend more agent turns unless a stakeholder rejects the remaining visual risk.
```

## Example 2 — Stop-Loss

```text
# Corfu Closure Audit

## State

BLOCKED

## Confidence

42%

## Closure Forecast

Minimum viable closure:
- Estimate: unknown until the acceptance criterion is confirmed
- Confidence: 40%
- What it includes: One human decision on expected checkout behavior.

Proper closure:
- Estimate: 2-3 focused turns after decision
- Confidence: 50%
- What it includes: Implement one path, run checkout validation, document risk.

Polished closure:
- Estimate: half day
- Confidence: 35%
- What it includes: Cross-browser check and regression test.

## Evidence

- The diff touches checkout, cart, and unrelated layout files.
- No validation has passed.
- The intended behavior differs across prior agent messages.

## Must-Fix

- Confirm the expected checkout behavior before coding further.

## Should-Fix

- Remove unrelated layout changes after the decision is made.

## Risks

- Risk: Agent may implement the wrong checkout behavior.
  - Impact: High.
  - Likelihood: Medium.
  - Mitigation: Stop and obtain a product decision.

## Loop / Token-Burn Analysis

Loop risk: CRITICAL

Signals:
- Scope expanded from checkout to layout.
- The agent cannot state what proves the task done.

ROI of continuing: NEGATIVE

## Scope Drift

Scope drift: HIGH

Explanation:
- Current changes include unrelated layout work.

## Recommended Decision

Stop and ask for human decision

## Single Next Action

Ask the owner to choose the expected checkout behavior in one sentence.

## Final Ruling

Do not continue coding; the task is blocked on a product decision and further implementation has negative ROI.
```
