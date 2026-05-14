# sdd-harness — Context (living state)

> Updated as the plan phases progress. Keep short and current.

## Current state

**Phase:** F2 — CLI rewrite (`bin/sdd-harness`) + templates extraction
**Branch:** `feat/sh-f2-cli-rewrite`
**Repo:** `~/Developer/sdd-harness/` (remote still `iMark21/agentlayer`, renamed to `iMark21/sdd-harness` in F4)
**Last update:** 2026-05-15

## Done

- [x] Pivot decision (2026-05-15): replace agentlayer v0.5.0 with the AI/SDD/CI layer iterated through DoorKit F0–F6
- [x] Gap-analysis: classify DoorKit `.ai/` artifacts into generic / domain / hybrid
- [x] Old `.ai/` (v0.5.0 explore→plan→code→verify flow) removed; `assistant-installer/` removed
- [x] DoorKit `.ai/` copied; domain artifacts scrubbed (BLE/NFC/Keychain ADRs, `ble-reviewer`/`security-reviewer` agents, DK-*.feature, Vapor notes, MCP scaffold)
- [x] Commands ported stack-agnostic (no iOS/Swift/Fastlane lock-in)
- [x] Hooks ported with `hooks/config.sh` for per-project code globs
- [x] Root bootloaders: `CLAUDE.md` and `AGENTS.md` rewritten for sdd-harness
- [x] Governance templates (`ROUTING.md`, `README.md`, `PRODUCT.md`, `BACKLOG.md`, `CONTEXT.md`) rewritten — dogfood

## Immediate next

F1 closed 2026-05-15 (squash-merged `develop` at `bf88d31`).

F2 in progress on `feat/sh-f2-cli-rewrite`. Scope further trimmed (TL judgment): SH-F2-002 (deterministic CI plugins) deferred to F2.5 or v1.1.0; F2 ships only the CLI rewrite plus ADR-0009 documenting the future plugin pattern.

F2 done so far:

- [x] T1: `templates/` directory created with canonical and placeholder files
- [x] T2: `bin/sdd-harness` rewritten from scratch (311 lines vs 1779)
- [x] T3: `install.sh` updated (paths, binary name)
- [x] T6: `acceptance/SH-F2-001-cli-init.feature` with 9 scenarios
- [x] T7: e2e smoke-test passed (init/install/audit verified in `/tmp/`)
- [x] T8: ADR-0009 plugin pattern for CI documented (implementation deferred)
- [x] T9: CHANGELOG entry under [Unreleased]

Remaining for F2 close:

- Verify `sdd-harness standardize` end-to-end (smoke-test only covered install/audit)
- Squash-merge `feat/sh-f2-cli-rewrite` → `develop` (local, no push)

## Active constraints

- **Strict GitFlow** (inherited from workspace): no direct commits to `develop`/`main`. Work on `feat/sh-f1-core-port`; squash-merge to `develop` when F1 closes.
- **No public push during F1–F3.** Remote `iMark21/agentlayer` is untouched. F4 handles rename + push with sanitized commit timestamps.
- **Language policy active:** all project artifacts in English.

## Decisions taken

- **Replace, not extract.** v0.5.0 `.ai/` is deleted, not preserved as legacy. CHANGELOG v1.0.0 documents the rupture.
- **Rename to `sdd-harness`.** Final form combines `sdd` (the discipline) + `harness` (engineering metaphor for support scaffolding).
- **No MCP server in F1.** DoorKit's was incomplete scaffold. Revisit only if consumer projects demand it.
- **No Gemini/Cursor/Copilot bootloaders in F1.** Claude + Codex (`CLAUDE.md` + `AGENTS.md`) prove the pattern; the others are copy-paste extensions when needed.

## Open risks

| Risk | Mitigation |
|---|---|
| Old `agentlayer init` consumers will break on v1.0.0 | CHANGELOG migration entry + clear rename of CLI/paths |
| Hooks' code globs differ across consumer stacks | `hooks/config.sh` is the per-project tuning knob |
| Public repo rename triggers redirect from `iMark21/agentlayer` | Documented in F4 release notes; users update `git remote set-url` manually |
| `feat/sh-f1-core-port` is not pushed during F1; could be lost on disk failure | Local commits only until end of F1; push to remote (still `iMark21/agentlayer`) when F1 closes for backup |
