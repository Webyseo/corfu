# Corfu Scoring Reference

Use this reference only when you need deeper calibration.

## Confidence Calibration

- 90-100%: Objective is explicit, diff is narrow, relevant validations passed, no material risk.
- 75-89%: Objective appears satisfied; validation is partial but adequate; risk is known and bounded.
- 60-74%: Likely closable but one meaningful evidence gap remains.
- 40-59%: Inconclusive; some evidence supports closure but important uncertainty remains.
- 20-39%: Probably not closable; must-fix or major ambiguity likely exists.
- 0-19%: Blocked, contradictory evidence, broken primary flow, or no reliable audit basis.

## Must-Fix Examples

- Relevant build/test/typecheck/lint failure.
- Broken primary user path.
- Missing acceptance criterion.
- Fatal runtime error.
- Data loss, privacy, security, or payment risk.
- Migration missing after schema change.
- Accidental unrelated file changes.
- Production configuration broken.

## Should-Fix Examples

- More elegant naming.
- Extra test coverage beyond risk profile.
- Documentation polish.
- Minor duplication.
- Wider device/browser testing when not central.
- Refactor that does not change closure risk.

## High-Signal Loop Indicators

- Same explanation repeated with no new evidence.
- New implementation attempts happen before previous hypothesis is validated.
- The diff grows but confidence does not.
- The agent cannot name the exact criterion that proves completion.
- The next step is “investigate more” rather than a finite validation.
- Product decision is missing but the agent keeps coding.

## ROI Examples

HIGH ROI:
- Run one targeted test that proves the primary flow.
- Fix one relevant failure blocking closure.
- Remove unrelated accidental diff.

MEDIUM ROI:
- Add one focused regression test.
- Run broader validation after primary evidence already exists.

LOW ROI:
- Refactor naming.
- Explore alternative architectures.
- Add documentation after enough closure evidence exists.

NEGATIVE ROI:
- Continue coding without acceptance criteria.
- Debug without reproduction.
- Add features to hide unresolved uncertainty.
- Keep changing code after the issue requires human decision.
