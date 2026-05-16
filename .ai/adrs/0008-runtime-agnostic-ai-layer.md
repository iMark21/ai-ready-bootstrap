# ADR 0008 — Runtime-agnostic AI layer under `.ai/`

- **Status:** Accepted
- **Date:** 2026-05-14 (original), 2026-05-15 (generalized for sdd-harness v1.0.0)
- **Phase:** F1

## Context

Modern software projects are increasingly built with heavy AI assistance (Claude Code today, possibly other tools tomorrow). The conventional approach is to put runtime-specific instructions in runtime-specific folders: `.claude/` for Claude Code, `.cursor/rules` for Cursor, `.github/copilot-instructions.md` for Copilot, `AGENTS.md` for Codex, etc.

Each runtime defines its own format for commands, agents, hooks, settings, and permissions. Following that pattern means:

- Duplicating content across folders (or worse, letting them drift).
- Locking the project into a single AI vendor.
- Forcing every contributor (human or AI) to learn N folder layouts.
- Making AI-runtime migrations a "rewrite the docs" project.

## Decision

**`.ai/` is the single source of truth for the AI layer.** It contains:

- `commands/` — repeatable workflows as plain Markdown.
- `agents/` — reusable roles/personas as plain Markdown.
- `hooks/` — runtime-agnostic shell scripts that Git/CI/IDE can wire to.
- `specs/`, `adrs/`, `notes/`, `BACKLOG.md`, `CONTEXT.md`, `PRODUCT.md`, `ROUTING.md` — the rest of the AI/SDD contract.

Runtime-specific adapters at the repo root are **5-line pointers** to `.ai/ROUTING.md`. They contain no instructions, no commands, no logic. Examples:

- `CLAUDE.md` (Claude Code).
- `AGENTS.md` (Codex / OpenAI agents).
- `GEMINI.md`, `.cursor/rules/000-routing.mdc`, `.github/copilot-instructions.md` — added only when the corresponding runtime is in use.

Migrating to a new AI runtime means adding a new pointer. The brain of the project never moves.

## Consequences

- **Pro:** the AI workflow survives runtime changes for free.
- **Pro:** humans only learn `.ai/` once.
- **Pro:** contributors can run the project from any AI tool that can read Markdown — and that's all of them.
- **Con:** each runtime might offer features that don't map cleanly to plain Markdown (e.g. Claude Code's hooks are JSON in `.claude/settings.json`). Mitigation: keep runtime-specific *integration* files minimal and obvious, and consider them disposable adapters.
- **Con:** when a runtime evolves and offers a feature that would be useful, the harness may resist using it to keep portability. Acceptable trade-off.

## Rejected alternatives

- **Put everything in `.claude/`.** Rejected: locks in to Claude Code; loses the "any AI can operate this repo" property.
- **Maintain parallel folders for each runtime.** Rejected: drift is inevitable; doubles maintenance.
- **No formal AI layer; rely on README + ad-hoc prompts.** Rejected: forfeits Spec-Driven Development, harness reproducibility, and the value of a structured, auditable AI workflow.

## How to apply

- New commands → `.ai/commands/<name>.md`.
- New agent roles → `.ai/agents/<role>.md`.
- New automation → `.ai/hooks/<name>.sh`.
- New runtime support → 5-line pointer at the appropriate location; never duplicate content.

## References

- `.ai/ROUTING.md` — the entrypoint every AI reads.
- [Model Context Protocol (MCP)](https://modelcontextprotocol.io) — open, runtime-agnostic protocol for AI tool integration.
