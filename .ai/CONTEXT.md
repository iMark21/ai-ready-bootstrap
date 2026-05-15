# sdd-harness — Context (living state)

> The **mirror**: this file reflects the live state of the project. Update it on every phase close via [`commands/phase-close.md`](commands/phase-close.md). See [`notes/governance-mirror.md`](notes/governance-mirror.md) for the discipline.

## Current state

**Phase:** F4 closed — v1.0.0-alpha shipped
**Branch:** `develop`
**Remote:** `iMark21/sdd-harness` (renamed from `iMark21/agentlayer` during F4)
**Last update:** 2026-05-15

## Done

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

v1.0.0-alpha is shipped. Possible next phases (none active):

- **F2.5 / SH-F2-002**: deterministic CI plugins (`tools/ci.sh` dispatcher + per-stack plugins) — implements ADR-0009.
- **v1.0.0-beta**: harden the CLI based on adopter feedback, add Cursor/Copilot/Gemini bootloaders, expand acceptance Gherkin.
- **v1.0.0** (stable): when v1.0.0-alpha has been adopted in ≥ 1 external project and survived contact.

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
| No automated test suite for the harness itself; smoke-test is manual | Acceptable for v1.0.0-alpha; revisit if regressions appear |
| v0.5.0 users with `~/.agentlayer` clones will see redirects but the binary name changed; manual `git remote set-url` + new install required | Documented in CHANGELOG [1.0.0-alpha] "Changed" section |
