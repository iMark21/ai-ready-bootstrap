# sdd-harness

> **v1.0.0-alpha** — Framework pivot from `agentlayer` v0.5.0. CLI distribution under reconstruction; the core `.ai/` layer is complete and dogfooded in this repo.

A runtime-agnostic **Spec-Driven Development harness** that any AI can operate. Drop it into a repo and the team — humans and AIs alike — follow the same disciplined loop: **spec first, code second, verify against spec**.

## Status

This repository is in transition. The `.ai/` layer (the *brain* of the harness) has been ported from a battle-tested production lineage and is ready to read, adapt, and adopt. The CLI that distributes it into other repos (`bin/sdd-harness` once renamed, currently `bin/agentlayer` on disk) is still wired to the v0.5.0 templates and will be rewritten in **v1.0.0-beta**.

If you arrived from `iMark21/agentlayer` looking for the v0.5.0 `agent-explore → plan → code → verify` flow: that has been replaced. See [CHANGELOG.md](CHANGELOG.md) for the rupture rationale and migration guidance.

## What sdd-harness gives you

A `.ai/` directory that is the single source of truth for any AI runtime:

```
.ai/
├── ROUTING.md      — how any AI operates the project
├── PRODUCT.md      — vision and non-goals
├── CONTEXT.md      — living state
├── BACKLOG.md      — stories (SH-NNN format)
├── README.md       — entrypoint map
├── adrs/           — architecture decisions, MADR format
├── agents/         — reusable AI roles (spec-writer to start)
├── commands/       — repeatable workflows (spec, story, implement, verify, review, release)
├── hooks/          — runtime-agnostic shell scripts; config.sh per-project tunable
├── notes/          — distilled mini-tutorials
└── specs/          — PRD, glossary, acceptance Gherkin, your protocol contracts
```

Plus 5-line bootloaders at the repo root: [`CLAUDE.md`](CLAUDE.md), [`AGENTS.md`](AGENTS.md), and the same pattern for any future AI runtime.

## The discipline

```
spec  →  human + agent review  →  implement (TDD-light)  →  verify-against-spec  →  merge
```

Enforced by `.ai/hooks/pre-commit-spec-check.sh`: feature branches that touch code must also touch a spec or ADR. The path globs are project-configurable in [`.ai/hooks/config.sh`](.ai/hooks/config.sh).

See [`.ai/notes/spec-driven-development.md`](.ai/notes/spec-driven-development.md) for the full primer.

## Lineage

sdd-harness extracts the disciplined `.ai/` layer iterated through 6 phases in a real production codebase (a smart-lock iOS prototype with BLE/NFC/hardware constraints). The discipline survived contact with hardware, mocks, simulators, and CI — which is the bar for shipping a framework rather than a template. Domain-specific artifacts (BLE, NFC, Keychain, Vapor) are excluded; only the generic SDD discipline is kept.

## Adopting it (manual path, v1.0.0-alpha)

While the CLI is being rewritten:

```bash
# Copy the .ai/ structure into your repo
cp -R .ai/ /path/to/your-repo/.ai/
cp CLAUDE.md AGENTS.md /path/to/your-repo/

# Tune the code globs to your stack
$EDITOR /path/to/your-repo/.ai/hooks/config.sh

# Install the SDD pre-commit hook
cd /path/to/your-repo && ./.ai/hooks/install.sh
```

Then rewrite `.ai/PRODUCT.md`, `.ai/BACKLOG.md`, `.ai/CONTEXT.md` for your project. ADR 0008 (runtime-agnostic AI layer) stays as-is; add your own ADRs starting at 0009 or higher.

## Roadmap

- **v1.0.0-alpha** (current) — Framework core ported and dogfooded.
- **v1.0.0-beta** — CLI rewrite: `sdd-harness init` lays down the new `.ai/` in a target repo. Plugin-based CI scaffolding per stack (Swift/Python/JS/Go).
- **v1.0.0** — Public migration: repo renamed to `iMark21/sdd-harness`, commit timestamps sanitized, CHANGELOG migration guide for v0.5.0 users.
- **v1.1.0+** — Governance mirror (auto-update `CONTEXT.md` on phase close), additional reviewer agents, optional integrations.

## License

MIT. See [LICENSE](LICENSE).

## Read more

- [`.ai/ROUTING.md`](.ai/ROUTING.md) — start here for any AI
- [`.ai/PRODUCT.md`](.ai/PRODUCT.md) — vision and non-goals
- [`.ai/notes/spec-driven-development.md`](.ai/notes/spec-driven-development.md) — SDD primer
- [`.ai/adrs/0008-runtime-agnostic-ai-layer.md`](.ai/adrs/0008-runtime-agnostic-ai-layer.md) — why `.ai/` and not `.claude/`
- [CHANGELOG.md](CHANGELOG.md) — version history
