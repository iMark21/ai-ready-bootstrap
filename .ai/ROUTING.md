# sdd-harness — AI Routing

This file tells **any AI** (Claude Code, Codex, Cursor, Copilot, future tools) how to operate this project. It is not specific to any runtime.

## Guiding principle

`.ai/` is the **single source of truth**. Every AI must:

1. Read this file.
2. Read `PRODUCT.md` (vision).
3. Read `BACKLOG.md` (what is pending).
4. Read `CONTEXT.md` (current state).
5. For any feature, read the corresponding spec in `specs/` before touching code.

There are no `.claude/`, `.cursor/`, `.github/copilot/` directories with instructions. If a specific runtime needs a bootloader (e.g. Claude Code reads `CLAUDE.md`), that file exists at the repo root and is a **5-line pointer** redirecting here.

## Language policy

- **All artifacts in English**: code, comments, specs, ADRs, agents, commands, hooks, READMEs.
- Project owners using sdd-harness in their own codebase may localize their own specs; the harness itself remains English.

## Folders

| Folder | Contents | When to read |
|---|---|---|
| `specs/` | PRD, glossary, threat model, protocol specs, Gherkin acceptance | Before implementing any feature |
| `adrs/` | Architecture decisions with "what I rejected and why" | Before proposing any architectural change |
| `commands/` | Markdown commands: `spec`, `story`, `implement`, `verify`, `review`, `release` | When the user asks to run one |
| `agents/` | Reusable roles/personas (start with `spec-writer`; add stack-specific reviewers as needed) | When a task matches the agent's domain |
| `hooks/` | Runtime-agnostic shell scripts (Git, CI, IDE) for automatic SDD enforcement | Install with `./.ai/hooks/install.sh` |
| `notes/` | Distilled mini-tutorials (not transcripts) | To learn a focused concept |

## Mandatory SDD flow

Every feature goes through:

```
spec  →  review (human + agent)  →  implement  →  verify-against-spec  →  merge
```

If code and spec diverge, the spec is updated first. The hook `pre-commit-spec-check.sh` blocks feature commits that don't touch `specs/` or `adrs/`.

## Conventions

- Stories: `SH-NNN`. One story = one acceptance feature in `specs/acceptance/`.
- ADRs: numbered `NNNN-kebab-title.md`, lightweight MADR format.
- Commits: `[branch] type: "title"`.
- Test naming (when adopting in your project): every test function is `testGivenXxxWhenYyyThenZzz()` and its body uses three explicit comment blocks: `// GIVEN`, `// WHEN`, `// THEN`. This mirrors the Gherkin features under `specs/acceptance/` and keeps test intent visible at the function-name level.

## For new contributors (humans or AIs)

1. Read `PRODUCT.md`.
2. Read `specs/glossary.md` to align vocabulary.
3. Read the ADRs in numeric order (start with `0008-runtime-agnostic-ai-layer.md`).
4. Look at `BACKLOG.md` to find an open story.
5. Follow the SDD flow.
