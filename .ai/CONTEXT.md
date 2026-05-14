# sdd-harness — Context (living state)

> The **mirror**: this file reflects the live state of the project. Update it on every phase close via [`commands/phase-close.md`](commands/phase-close.md). See [`notes/governance-mirror.md`](notes/governance-mirror.md) for the discipline.

## Current state

**Phase:** F3 — Governance mirror
**Branch:** `feat/sh-f3-governance-mirror`
**Repo:** local clone (remote still `iMark21/agentlayer`; rename to `iMark21/sdd-harness` lands in F4)
**Last update:** 2026-05-15

## Done

### F3 — Governance mirror (in progress on this branch)
- [x] SH-F3-001: `commands/phase-close.md` walks through closing a phase (canonical + template mirror)
- [x] SH-F3-002: `templates/.ai/CONTEXT.md` formalized with the 5 required sections (Current state / Done / Immediate next / Decisions taken / Open risks)
- [x] SH-F3-003: `notes/governance-mirror.md` documents the discipline
- [ ] SH-F3-004: dogfood — close F2 and open F3 in sdd-harness's own `CONTEXT.md` using `phase-close` *(this very edit)*
- [ ] Acceptance Gherkin `acceptance/SH-F3-001-phase-close.feature`
- [ ] CHANGELOG entry + squash-merge

### F2 — CLI rewrite (closed 2026-05-15, develop @ 612fd91)
- [x] SH-F2-001: `bin/agentlayer` → `bin/sdd-harness` (1779 → 311 lines), templates/ extracted from heredocs
- [x] `install.sh` updated for the new binary name and `~/.sdd-harness` clone path
- [x] Placeholder substitution: `{{PROJECT_NAME}}` / `{{STORY_PREFIX}}` / `{{TODAY}}`
- [x] e2e smoke-test PASS in `/tmp/` (install, dry-run, audit, standardize with backup, --non-interactive fail-fast)
- [x] ADR-0009 documents the future plugin pattern for deterministic CI (implementation deferred to F2.5)

### F1 — Core SDD harness port (closed 2026-05-15, develop @ bf88d31)
- [x] `.ai/` replaced with the runtime-agnostic SDD scaffold ported from the DoorKit lineage; domain (BLE/NFC/Keychain/Vapor) scrubbed
- [x] 6 SDD commands stack-agnostic; hooks with per-project `config.sh`
- [x] ADR-0008 (runtime-agnostic AI layer) kept; root bootloaders CLAUDE.md + AGENTS.md ship as 5-line pointers
- [x] Dogfood acceptance Gherkin `SH-F1-001-dogfood.feature` — all 9 scenarios verified manually

### F0 — Gap-analysis (closed 2026-05-15)
- [x] Audited DoorKit `.ai/`, classified artifacts into Generic / Domain / Hybrid; ~70% genuinely portable.

## Immediate next

- Finish SH-F3-004 dogfood (this edit), write acceptance Gherkin, CHANGELOG, squash-merge.
- After F3: optional F2.5 (deterministic CI plugins, `SH-F2-002`) or jump to F4 (public migration).

## Decisions taken

- **F3-D1**: Governance mirror is documented practice + command, not auto-generation. Auto-generated state hides drift, which is the whole signal we want from the mirror. See `notes/governance-mirror.md`.
- **F3-D2**: No hook automation for phase transitions. Detecting a phase close from git activity is heuristic; the explicit `phase-close` command is more honest.
- **F2-D1** (carry-forward): CLI rewrite from scratch (Approach A from the F2 TL analysis) chosen over surgical edit. 311 lines vs 1779 is a clear simplification win.
- **F2-D2** (carry-forward): Deterministic CI plugins (`SH-F2-002`) split into F2.5; ADR-0009 documents the pattern without committing implementation effort.
- **F1-D1** (carry-forward): Replace agentlayer v0.5.0 wholesale; no legacy shim. Documented in CHANGELOG [1.0.0-alpha].

## Open risks

| Risk | Mitigation |
|---|---|
| F4 public push will rename `iMark21/agentlayer` → `iMark21/sdd-harness`. v0.5.0 install commands in the wild will break. | CHANGELOG migration entry explains it; old GitHub URL redirects until the user removes the repo |
| Branch `chore/agentic-governance-backlog` still on the remote with the discarded ARB-29..51 backlog | Delete in F4 along with the rename; local copy can also be removed at any time |
| Commit timestamps on `develop` reflect real-time work (workspace post-commit hook for non-iOS repos shifts to previous night, verify it's active before push) | Audit timestamps as part of F4 sanitization pass |
| No automated test suite for the harness itself; smoke-test is manual | Acceptable for v1.0.0-alpha; revisit if regressions appear |
