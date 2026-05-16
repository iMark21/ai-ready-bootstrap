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
| SH-F1-001 | `.ai/` core port from upstream lineage (clean slate, no domain) | done | `acceptance/SH-F1-001-dogfood.feature` | F1 |
| SH-F1-002 | SDD commands ported as stack-agnostic | done | `acceptance/SH-F1-001-dogfood.feature` | F1 |
| SH-F1-003 | Hooks ported with per-project `config.sh` for code globs | done | `acceptance/SH-F1-001-dogfood.feature` | F1 |
| SH-F1-004 | Governance templates (CONTEXT/PRODUCT/ROUTING/BACKLOG/README) rewritten for sdd-harness | done | `acceptance/SH-F1-001-dogfood.feature` | F1 |
| SH-F1-005 | Runtime bootloaders (CLAUDE.md, AGENTS.md) | done | `acceptance/SH-F1-001-dogfood.feature` | F1 |
| SH-F2-001 | CLI rewrite: `bin/agentlayer` → `bin/sdd-harness` + templates/ pattern | done | `acceptance/SH-F2-001-cli-init.feature` | F2 |
| SH-F2-002 | Deterministic CI scaffolding (stack-plugin pattern: swift/python/js/go) | todo | TBD | F2.5 |
| SH-F2-003 | Multi-runtime bootloaders: Cursor (`.cursor/rules/`), Copilot (`.github/copilot-instructions.md`), Gemini (`GEMINI.md`); `--runtimes all` alias | done | CI smoke (`--runtimes all` + selective `cursor`) | F2.5 |
| SH-F3-001 | `phase-close` command (canonical + template) | done | `acceptance/SH-F3-001-phase-close.feature` | F3 |
| SH-F3-002 | CONTEXT.md schema formalized in templates/ | done | `acceptance/SH-F3-001-phase-close.feature` | F3 |
| SH-F3-003 | Governance mirror note explaining the practice | done | `acceptance/SH-F3-001-phase-close.feature` | F3 |
| SH-F3-004 | Dogfood: close F2 and open F3 in sdd-harness's own CONTEXT.md | done | `acceptance/SH-F3-001-phase-close.feature` | F3 |
| SH-F4-101 | External adoption proof: real cold-start on a legacy unmaintained repo | done | `iMark21/marvel-android@develop` (MAR-002 pager via SDD loop) | beta-gate-2 |
| SH-F4-104 | Install: stack detection from manifest (`build.gradle`/`package.json`/`Cargo.toml`/`go.mod`/`Package.swift`) → PRODUCT.md stack stub | todo | TBD | beta |
| SH-F4-105 | Install: migrate a README `## TODO`/`## Roadmap` checklist into BACKLOG.md rows | todo | TBD | beta |
| SH-F4-110 | Install completeness: glob-sanity dry-run warning + `{{GIT_BRANCH}}` CONTEXT seed + `.ai/BOOTSTRAP.md` handoff (folds in -102/-103/-106) | done | `acceptance/SH-F4-110-install-completeness.feature` | beta |
| SH-F4-107 | README rebalance: value-first, badges, TOC, synced, roadmap fixed | done | (review) | beta |
| SH-F4-108 | AI-assisted install: fetchable `assistant-installer/PROMPT.md` (install + audit + fill) + README path (c) | done | `acceptance/SH-F4-108-ai-assisted-install.feature` | beta |
| SH-F4-109 | README: post-install usage — command flows, hook rules, exemptions, override, hooks, use cases | done | (review) | beta |
| SH-F4-001 | Public migration: rename repo, sanitize timestamps, ship v1.0.0-alpha | done | (audit + push log in CONTEXT.md F4 block) | F4 |

## Out of scope (v1.0.0)

- Multi-AI testing harness (decision deferred)
- MCP server scaffold (the upstream lineage shipped an incomplete one; revisit if user demand emerges)
- LangGraph / MAS / RAG agentic patterns (those belong in a separate "governance pack" repo, not the harness core)
- Auto-generation of stack-specific test runners (consumer project owns this)

## Next actions

1. Close SH-F1-001..005 in current sprint.
2. Start SH-F1-006 (CLI reconciliation) once T1-T5 are merged.
3. Write meta acceptance Gherkin: `acceptance/SH-F1-001-init-clean-repo.feature` validating `sdd-harness init` against a tmp repo.
