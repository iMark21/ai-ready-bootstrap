# sdd-harness — Context (living state)

> The **mirror**: this file reflects the live state of the project. Update it on every phase close via [`commands/phase-close.md`](commands/phase-close.md). See [`notes/governance-mirror.md`](notes/governance-mirror.md) for the discipline.

## Current state

**Phase:** v1.0.0-beta shipped (2026-05-16); v1.0.0 planning
**Branch:** `develop` → `main` (release/v1.0.0-beta in flight)
**Remote:** `iMark21/sdd-harness` (renamed from `iMark21/agentlayer` during F4)
**Last update:** 2026-05-16

## Done

### F2.5 — Deterministic CI plugins (2026-05-16)
- [x] SH-F2-002: `tools/ci.sh` dispatcher (~130 lines) reads stack from CONTEXT.md or `--stack` flag
- [x] Dispatcher supports: `--list`, `--all`, `--stack override`, explicit plugin routing
- [x] `tools/ci/common.sh` shared helpers: logging (log/warn/die), timing (step_start/step_done)
- [x] 4 initial stack plugins: swift (XcodeGen), python (ruff/pytest), js (npm), go (go test/vet)
- [x] Each plugin implements: `plugin_check`, `plugin_lint`, `plugin_test`, `plugin_build`
- [x] Acceptance spec `SH-F2-002-ci-stack-plugins.feature` covers 20+ scenarios (dispatcher, plugins, integration)

### Beta install helpers — stack detection + README migration (2026-05-16)
- [x] SH-F4-104: `--stack` flag (explicit, not heuristic) for swift, android, python, node, go, rust, generic
- [x] SH-F4-105: README `## TODO` / `## Roadmap` sections auto-migrate to `.ai/BACKLOG.md` rows
- [x] Acceptance spec `SH-F4-104-105-install-helpers.feature` covers all scenarios
- [x] Templates updated: PRODUCT.md "Tech Stack" section + CONTEXT.md "Stack:" line both use `{{STACK}}` placeholder
- [x] All acceptance scenarios verified manually (stack selection, rejection, migration, listing)

### Beta hardening — universal hook surface (2026-05-16)
- [x] SH-F4-111: default hook surface now protects every tracked non-documentation path via `SH_CODE_GLOBS=("*")` plus `SH_CODE_EXCLUDE_GLOBS`, so nested Android, iOS, Go, web, backend, and monorepo layouts no longer need manual stack-specific glob tuning.
- [x] `pre-commit-spec-check.sh`, `post-edit-trace.sh`, and the CLI glob-sanity dry-run now share include/exclude case-pattern semantics; missing `SH_CODE_EXCLUDE_GLOBS` in older configs is treated as empty for compatibility.
- [x] `feature/*` branches are gated alongside `feat/*`; docs-only feature commits remain allowed by default.
- [x] CI covers docs-only warning, conventional layout silence, nested Android, iOS, Go, blocked code-only commits, and spec+code commits.

### F4 — Public migration (closed 2026-05-15)
- [x] SH-F4-001: security audit passed (no secrets, no co-authored, no internal path leaks, all commits authored as `marques.jm@icloud.com`)
- [x] Commit timestamps sanitized via rebase + cherry-pick + `--amend --date` (all 3 commits shifted to late-evening/early-night)
- [x] GitHub repo renamed: `iMark21/agentlayer` → `iMark21/sdd-harness` (GitHub serves redirects from the old URL)
- [x] Local origin URL updated
- [x] `develop` pushed; `v1.0.0-alpha` tagged and pushed
- [x] CHANGELOG `[1.0.0-alpha]` entry consolidates F1+F2+F3 deliverables under a single release date

### Beta gate #2 — external adoption (proven 2026-05-16)
- [x] SH-F4-101: real cold-start adoption on `iMark21/marvel-android` (legacy, unmaintained since 2021). Context bootstrapped from source; README TODO → backlog; `MAR-002` pager shipped through the full SDD loop; hook verified (code-only blocked, spec+code passed).
- **Finding**: default `SH_CODE_GLOBS` did not match the repo's `Marvel/app/*` nesting — the hook would have silently passed code-only commits. Filed SH-F4-102..107 for beta (install should pre-fill the deterministic ~60% and dry-run the hook to catch this).
- **Analysis (TL)**: install is template-drop only; the valuable bootstrap (the AI reading the repo) is out-of-band. Beta should make install fill what is deterministic (branch, stack, README→backlog, glob sanity) and hand off judgment via `.ai/BOOTSTRAP.md`, without breaking zero-dep / runtime-agnostic (no shelling to an AI).

### F3 — Governance mirror (closed 2026-05-15)
- [x] SH-F3-001: `commands/phase-close.md` walks through closing a phase (canonical + template mirror)
- [x] SH-F3-002: `templates/.ai/CONTEXT.md` formalized with the 5 required sections
- [x] SH-F3-003: `notes/governance-mirror.md` documents the discipline
- [x] SH-F3-004: dogfood — sdd-harness's own `CONTEXT.md` restructured per the new schema

### F2 — CLI rewrite (closed 2026-05-15, develop @ 612fd91)
- [x] SH-F2-001: `bin/agentlayer` → `bin/sdd-harness` (1779 → 311 lines), templates/ extracted from heredocs
- [x] `install.sh` updated for the new binary name and `~/.sdd-harness` clone path
- [x] Placeholder substitution: `{{PROJECT_NAME}}` / `{{STORY_PREFIX}}` / `{{TODAY}}`
- [x] e2e smoke-test PASS in `/tmp/` (install, dry-run, audit, standardize with backup, --non-interactive fail-fast)
- [x] ADR-0009 documents the future plugin pattern for deterministic CI (implementation deferred to F2.5)

### F1 — Core SDD harness port (closed 2026-05-15, develop @ bf88d31)
- [x] `.ai/` replaced with the runtime-agnostic SDD scaffold ported from the upstream lineage; domain artifacts scrubbed
- [x] 6 SDD commands stack-agnostic; hooks with per-project `config.sh`
- [x] ADR-0008 (runtime-agnostic AI layer) kept; root bootloaders CLAUDE.md + AGENTS.md ship as 5-line pointers
- [x] Dogfood acceptance Gherkin `SH-F1-001-dogfood.feature` — all 9 scenarios verified manually

### F0 — Gap-analysis (closed 2026-05-15)
- [x] Audited the upstream lineage's `.ai/`, classified artifacts into Generic / Domain / Hybrid; ~70% genuinely portable.

## Immediate next

- **Push v1.0.0-beta to GitHub**: tag and announce the release
- **v1.0.0 criteria**: full `MANUAL.md`, contributor playbook, explicit SemVer/deprecation policy
- **Adopter outreach**: confirm ≥ 3 external adopters across different stacks (Swift, Android, Python, Node, Go) before v1.0.0 GA
- **Optional enhancements** (post-v1.0.0): android/rust CI plugins, GitHub Actions template, IDE extensions

## Decisions taken

- **F4-D1**: Commit timestamps sanitized only for the 3 unpushed v1.0.0-alpha commits, not for the v0.5.0 history (which was already public). Discipline applies going forward.
- **F4-D2**: GitHub repo rename is non-destructive — GitHub serves automatic redirects, so v0.5.0 users with the old URL keep working until they update their remote.
- **F3-D1**: Governance mirror is documented practice + command, not auto-generation. Auto-generated state hides drift, which is the whole signal we want from the mirror. See `notes/governance-mirror.md`.
- **F3-D2**: No hook automation for phase transitions. Detecting a phase close from git activity is heuristic; the explicit `phase-close` command is more honest.
- **F2-D1** (carry-forward): CLI rewrite from scratch (Approach A from the F2 TL analysis) chosen over surgical edit. 311 lines vs 1779 is a clear simplification win.
- **F2-D2** (carry-forward): Deterministic CI plugins (`SH-F2-002`) split into F2.5; ADR-0009 documents the pattern without committing implementation effort.
- **F1-D1** (carry-forward): Replace agentlayer v0.5.0 wholesale; no legacy shim. Documented in CHANGELOG [1.0.0-alpha].

## Open risks

| Risk | Mitigation |
|---|---|
| Branch `chore/agentic-governance-backlog` still on the remote with the discarded ARB-29..51 backlog | Delete after v1.0.0-alpha tag is announced; not a blocker |
| CI is still shell smoke coverage rather than a dedicated unit-test harness | Acceptable for beta; add a focused test harness if shell scenarios become hard to maintain |
| v0.5.0 users with `~/.agentlayer` clones will see redirects but the binary name changed; manual `git remote set-url` + new install required | Documented in CHANGELOG [1.0.0-alpha] "Changed" section |
