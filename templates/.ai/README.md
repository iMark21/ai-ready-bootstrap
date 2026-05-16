# `.ai/` — sdd-harness

AI layer of the project. **Single source of truth** for product, architecture, and workflows. Any AI can operate the repo by reading this folder.

## Entrypoint

Read in this order:

1. [`ROUTING.md`](ROUTING.md) — how to operate the project from any AI.
2. [`PRODUCT.md`](PRODUCT.md) — vision and non-goals.
3. [`CONTEXT.md`](CONTEXT.md) — current state.
4. [`BACKLOG.md`](BACKLOG.md) — `SH-NNN` stories.
5. [`specs/`](specs/) — the spec relevant to the current task.

## Why `.ai/` and not `.claude/`?

Because we want any AI (Claude Code today, whatever comes tomorrow) to operate the project without migration. See [`adrs/0008-runtime-agnostic-ai-layer.md`](adrs/0008-runtime-agnostic-ai-layer.md).

## Quick map

```
specs/      → product and protocol contracts
adrs/       → why the architecture is the way it is
commands/   → repeatable flows (spec, story, implement, verify, review, release)
agents/     → reusable roles (start with spec-writer)
hooks/      → automatic SDD enforcement (Git/CI/IDE) — configure surface in hooks/config.sh
notes/      → distilled mini-tutorials
```

## For humans

If you arrive as a human reviewer: start with `PRODUCT.md`, then `specs/glossary.md`, then walk the `adrs/` in numeric order.
