# sdd-harness — Product Vision

## Tagline

A runtime-agnostic **Spec-Driven Development harness** that any AI can operate. Drop it into a repo and the team — humans and AIs alike — follow the same disciplined loop: spec first, code second, verify against spec.

## North Star

Any engineer or AI assistant should be able to:

1. Clone or `init` sdd-harness into a fresh repo.
2. Read `.ai/PRODUCT.md` and understand the project's vision in 5 minutes.
3. Follow the `spec → story → implement → verify → review → release` loop without coaching.
4. Trust that pre-commit hooks block drift between code and specs.
5. Swap the AI runtime (Claude Code → Codex → Cursor → Copilot → whatever's next) without rewriting anything under `.ai/`.

## Non-Goals

- **Not a code generator.** sdd-harness does not write your features; it disciplines the process around them.
- **Not stack-specific.** No Swift, Python, JS, Go opinions baked in. Stack-specific tooling (test runners, build commands, release pipelines) lives in the consuming project, not the harness.
- **Not a single-AI tool.** No `.claude/`-only artifacts. Adapters at the repo root are 5-line pointers to `.ai/`.
- **Not a project management tool.** `BACKLOG.md` tracks stories tied to specs; it is not Jira.
- **Not a documentation generator.** It scaffolds the *kinds* of docs that matter (PRD, ADRs, threat model) and enforces their presence — content is owned by the project.

## Audience

1. **Engineers starting a new repo** (primary): want SDD discipline without rolling their own templates.
2. **Engineers retrofitting an existing repo** (secondary): want to add `.ai/` to a project that already has code, without disrupting it.
3. **AI agents operating on the repo** (tertiary): need a stable, runtime-agnostic contract to read and update.

## Philosophy

- **Specs are the contract.** If code contradicts the spec, we don't patch the code: we update the spec first, then change the code. The pre-commit hook enforces this.
- **Runtime-agnostic AI.** The entire AI layer (`commands`, `agents`, `hooks`) lives under `.ai/`. Any AI can operate the project by reading `.ai/`. Adapter files at the repo root (`CLAUDE.md`, `AGENTS.md`, etc.) are 5-line pointers.
- **Harness, not framework.** sdd-harness provides discipline and gates, not opinions on architecture. Your ADRs declare your architecture; the harness ensures you follow your own ADRs.
- **Deterministic gates.** Every step (spec, story, implement, verify, review, release) has a `Done criteria` section. Either it's done or it isn't — no ambiguity.

## Lineage

sdd-harness extracts the disciplined `.ai/` layer iterated through multiple phases in a real production codebase under non-trivial constraints (multiple transports, hardware integration, end-to-end test harness, deterministic CI). The discipline survived contact with reality — which is the bar for shipping a framework rather than a template.

## Success metrics (subjective, not product KPIs)

- A new contributor (human or AI) reads `.ai/ROUTING.md` and can open a PR within an hour, knowing exactly which files to touch.
- An AI assistant given a story ID can produce a spec, plan, implementation, and verification report without asking the human "where do I put X?".
- `pre-commit-spec-check.sh` blocks ≥ 1 drift attempt per week in active projects — proving the discipline is real, not theatrical.
