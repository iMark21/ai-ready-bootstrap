# sdd-harness — Backlog

Stories `SH-NNN`. One story = one acceptance feature in `specs/acceptance/`.

## Status convention

- `todo` — pending
- `in-progress` — in flight (only one active per phase)
- `done` — implemented + verified against acceptance
- `parked` — postponed with reason
- `cut` — out of MVP scope

## v1.0.0 — Core SDD harness

| ID | Title | Status | Spec | Phase |
|---|---|---|---|---|
| SH-F1-001 | `.ai/` core port from DoorKit lineage (clean slate, no domain) | done | `acceptance/SH-F1-001-dogfood.feature` | F1 |
| SH-F1-002 | SDD commands ported as stack-agnostic | done | `acceptance/SH-F1-001-dogfood.feature` | F1 |
| SH-F1-003 | Hooks ported with per-project `config.sh` for code globs | done | `acceptance/SH-F1-001-dogfood.feature` | F1 |
| SH-F1-004 | Governance templates (CONTEXT/PRODUCT/ROUTING/BACKLOG/README) rewritten for sdd-harness | done | `acceptance/SH-F1-001-dogfood.feature` | F1 |
| SH-F1-005 | Runtime bootloaders (CLAUDE.md, AGENTS.md) | done | `acceptance/SH-F1-001-dogfood.feature` | F1 |
| SH-F2-001 | CLI rewrite: `bin/agentlayer` → `bin/sdd-harness` + templates/ pattern | done | `acceptance/SH-F2-001-cli-init.feature` | F2 |
| SH-F2-002 | Deterministic CI scaffolding (stack-plugin pattern: swift/python/js/go) | todo | TBD | F2.5 |
| SH-F3-001 | `phase-close` command (canonical + template) | done | `acceptance/SH-F3-001-phase-close.feature` | F3 |
| SH-F3-002 | CONTEXT.md schema formalized in templates/ | done | `acceptance/SH-F3-001-phase-close.feature` | F3 |
| SH-F3-003 | Governance mirror note explaining the practice | done | `acceptance/SH-F3-001-phase-close.feature` | F3 |
| SH-F3-004 | Dogfood: close F2 and open F3 in sdd-harness's own CONTEXT.md | done | `acceptance/SH-F3-001-phase-close.feature` | F3 |
| SH-F4-001 | Public migration: rename repo, sanitize timestamps, ship v1.0.0-alpha | done | (audit + push log in CONTEXT.md F4 block) | F4 |

## Out of scope (v1.0.0)

- Multi-AI testing harness (decision deferred)
- MCP server scaffold (DoorKit's was incomplete; revisit if user demand emerges)
- LangGraph / MAS / RAG agentic patterns (those belong in a separate "governance pack" repo, not the harness core)
- Auto-generation of stack-specific test runners (consumer project owns this)

## Next actions

1. Close SH-F1-001..005 in current sprint.
2. Start SH-F1-006 (CLI reconciliation) once T1-T5 are merged.
3. Write meta acceptance Gherkin: `acceptance/SH-F1-001-init-clean-repo.feature` validating `sdd-harness init` against a tmp repo.
