# Release Checklist

## v0.1.4

1. Run local validation:

   ```bash
   bash scripts/validate.sh
   ```

2. Confirm GitHub Actions passes.

3. Run manual smoke tests where possible:

   ```text
   docs/manual-smoke-tests.md
   ```

4. Check `CHANGELOG.md`.

5. Check `VERSION`.

6. Create an annotated tag:

   ```bash
   git tag -a v0.1.4 -m "Corfu v0.1.4"
   git push origin v0.1.4
   ```

   Do not move existing published tags. If a tag already exists, release the next patch version instead.

7. Create the GitHub Release.

8. Use this release description:

   ```text
   Corfu is a closure, forecast, and stop-loss auditor for AI coding agents. It helps developers decide whether agentic coding work should close, validate, narrow, revert, or stop.
   ```
