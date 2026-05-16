# SH-F4-113 — Public-readiness fixup: CI badge branch reference

> Version: 1.0. Hotfix for v1.0.0-beta launch readiness audit (2026-05-16).
> Story in `../BACKLOG.md`.

## 1. Problem

The CI status badge in `README.md:7` points to `branch=develop` instead of
`branch=main`. New visitors landing on the public repo from the LinkedIn launch
will see the development branch's CI status (which may fail, lag, or show stale
results) rather than the public/release branch's status.

**Impact:** First-time visitor perception. The repo appears unstable or
unmaintained if `develop` CI fails while `main` is passing.

**Root cause:** The hardening commit `16366ab` updated the Roadmap section of
README but did not update the badge query parameter when fixing public metadata.

## 2. Solution (high level)

Change the CI badge in `README.md` line 7 from:

```markdown
?branch=develop
```

to:

```markdown
?branch=main
```

This makes the badge reflect the public release branch's CI status, not the
development branch's.

## 3. Roles

- **Implementer (Dev)**: make the one-line change to `README.md:7`.
- **Reviewer (TL)**: verify the badge now points to `main` and renders correctly.
- **Verifier (QA)**: confirm the new badge URL loads and shows the correct CI
  status for `main`.

## 4. Functional requirements

- **FR-1** The CI badge URL query parameter changes from `branch=develop` to
  `branch=main`.
- **FR-2** The rendered badge displays CI status for the `main` branch
  (https://img.shields.io/github/actions/workflow/status/iMark21/sdd-harness/ci.yml?branch=main&label=CI).
- **FR-3** No other badge or README content changes. This is a surgical fix to
  the badge URL only.

## 5. Non-functional requirements

- Change is atomic and reversible (one-line diff).
- Commit message: `[fix/ci-badge] fix: "CI badge now shows main branch status"`
- No changes to tests, CI config, or templates required.

## 6. Acceptance criteria

See [`acceptance/SH-F4-113-ci-badge-fix.feature`](acceptance/SH-F4-113-ci-badge-fix.feature)
for the full Gherkin scenarios. Key criteria:

- CI badge URL query parameter is `branch=main` (not `branch=develop`).
- Badge renders without 404 errors on shields.io.
- No other badges or README content changed.
- Commit message follows SDD format: `[fix/ci-badge] fix: "..."`.

## 7. Out of scope

- Updating any other branch references (CI workflow still runs on both
  `develop` and `main`, intentionally).
- Changing the badge label, color, or link target.
- Refactoring the badge HTML or Markdown syntax.

## 8. Related decisions

See ADR 0008 (runtime-agnostic AI layer) and `CONTEXT.md` phase notes for
v1.0.0-beta. This fix is a reactive correction after the auditor flagged the
inconsistency.
