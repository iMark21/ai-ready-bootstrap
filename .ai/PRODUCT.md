# agentlayer — Product Brief

## Product Vision

agentlayer gives any existing repository a canonical AI context layer so coding
agents stop guessing and start from project-specific architecture, conventions,
decisions, and workflows. It is intentionally local-first, dependency-free, and
usable from any AI runtime.

## Target Users

| Persona | Description | Key Need |
| --- | --- | --- |
| Solo developer | Uses Codex, Claude Code, Copilot, Cursor, or mixed tools | One repo-native source of truth for AI behavior |
| Maintainer | Has contributors and partial AI docs already | Standardize drifting adapter files safely |
| Team lead | Wants AI work to follow team conventions | Reproducible rules, context, agents, and skills |
| AI tool evaluator | Tests multiple runtimes on the same repo | Thin adapters pointing at one canonical layer |

## Core Product Surface

- `agentlayer init` as the recommended first-use command.
- `audit`, `install`, and `standardize` commands for inspect-first workflows,
  fresh installs, and cleanup of existing AI files.
- Universal AI-assisted installer prompt for users who prefer to bootstrap
  through their current AI tool.
- Runtime adapters for Codex, Claude Code, Copilot, Cursor, and generic AI
  tools.
- Canonical `.ai/` structure with context, rules, agents, skills, and recent
  changes.

## Product Principles

- The `.ai/` layer is the canonical source of truth.
- Runtime-specific files stay thin and route back to `.ai/`.
- No cloud account or dependency install is required for the core flow.
- Generated context must be grounded against the real repository before serious
  implementation work.
- Public documentation must avoid private org assumptions.

## Monetization Model

- None. The project is MIT-licensed open source.
- Strategic value comes from public adoption, reusable conventions, and
  improving AI-assisted engineering quality.

## Story Ownership

Stories are stored in `stories/` when detailed specs are needed and tracked in
`BACKLOG.md`. Product changes should keep the first-use path short and
inspectable.

## References

- **CONTEXT.md**: `.ai/CONTEXT.md` — current state, architecture, release history, and roadmap
- **BACKLOG.md**: `.ai/BACKLOG.md` — task tracker and release backlog
