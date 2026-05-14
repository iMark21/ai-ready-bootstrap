# sdd-harness — Product Requirements Document

> Version: 1.0.0-alpha (initial release).

## 1. Problem

Engineers and AI assistants drift between spec and code. Conventional "AI in your repo" tooling either (a) locks you into one AI runtime, (b) generates code without enforcing process discipline, or (c) provides templates without runtime gates. The result is artifacts that look governed but aren't.

## 2. Solution (high level)

sdd-harness is a runtime-agnostic Spec-Driven Development scaffold dropped into any repo. It provides:

1. A `.ai/` directory that is the single source of truth: vision (`PRODUCT.md`), state (`CONTEXT.md`), stories (`BACKLOG.md`), specs (`specs/`), decisions (`adrs/`), and process commands (`commands/`).
2. Root-level pointer files (`CLAUDE.md`, `AGENTS.md`, future `GEMINI.md`, etc.) that are 5-line bootloaders for each AI runtime.
3. A pre-commit hook that blocks feature commits that don't touch specs or ADRs.
4. A CLI (`sdd-harness init`) that lays this scaffold down in a clean or existing repo.

## 3. Roles

- **Repo owner**: humans driving the project, installing the harness, customizing `hooks/config.sh` to match their stack.
- **Contributor (human or AI)**: anyone opening a PR. Bound by the SDD flow.
- **AI runtime**: Claude Code, Codex, Cursor, Copilot, or any future tool. Reads `.ai/` and operates the project.

## 4. User stories (SH-NNN)

See [`BACKLOG.md`](../BACKLOG.md) for the canonical list.

v1.0.0 closes when SH-F1-001..SH-F1-006 are `done` and the meta acceptance Gherkin `SH-F1-001-init-clean-repo.feature` passes against `/tmp/test-repo-*`.

## 5. Non-functional requirements

- **Zero dependencies**: `bash` and `git`. No Python, no Node in the core layer. Consumer projects may add stack-specific tooling outside `.ai/`.
- **Runtime-agnostic**: nothing under `.ai/` may assume Claude Code or any specific AI. Adapters live at the repo root.
- **Public-repo safe**: no internal paths, emails, or timestamps leak into versioned artifacts.
- **Idempotent install**: running `sdd-harness init` twice produces the same result; the install script detects existing `.ai/` and either refuses or runs `standardize`.
- **Backward break accepted from v0.5.0**: v1.0.0 is a documented rupture, not a migration.

## 6. Out of scope (v1.0.0)

- Stack-specific test runners or build commands.
- MCP server scaffold.
- LangGraph / multi-agent orchestration.
- Auto-generated documentation for consumer projects.
- Migration shims from v0.5.0 to v1.0.0.

## 7. Contracts

- **Bootloader contract** (`CLAUDE.md`, `AGENTS.md`): ≤ 12 lines, points to `.ai/ROUTING.md`. See ADR 0008.
- **Commands contract**: every command file has `Usage`, `Inputs`, `Procedure`, `Done criteria` sections.
- **Hook contract**: `pre-commit-spec-check.sh` exits 0 unless feature code is touched without a spec/ADR touch. Configurable via `hooks/config.sh`.

## 8. Glossary

See [`glossary.md`](glossary.md).
