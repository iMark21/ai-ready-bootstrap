# sdd-harness — Context (living state)

> Updated as the plan phases progress. Keep short and current.

## Current state

**Phase:** F1 — Core SDD harness port from DoorKit lineage
**Branch:** `feat/sh-f1-core-port`
**Repo:** `~/Developer/sdd-harness/` (formerly `~/Developer/ai-ready-bootstrap`; remote still `iMark21/agentlayer`, renamed to `iMark21/sdd-harness` in F4)
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

**Scope-cut (2026-05-15, TL judgment)**: T7 CLI rewrite moves from F1 to F2 (SH-F2-001). Reason: `bin/agentlayer` is 1779 lines of bash with v0.5.0 `.ai/` templates embedded as heredocs; rewriting is ~3-5h work, exceeds F1 scope. F2 (originally "CI determinista") expands to include CLI distribution rewrite.

F1 remaining tasks:

- T8: write meta acceptance Gherkin (`acceptance/SH-F1-001-dogfood.feature`) — validates that an AI runtime reading `.ai/` can execute the SDD flow on this repo
- T9: rewrite `README.md` honest about v1.0.0-alpha state (CLI in reconstruction), `CHANGELOG.md` documents rupture, simplify `MANUAL.md`
- T10: manual smoke-test = read `.ai/` end-to-end as a first contributor would; verify internal consistency

After T10: F1 closes, squash-merge `feat/sh-f1-core-port` → `develop` (per workspace GitFlow). NO push to remote until F4.

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
