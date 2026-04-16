# AI-Ready Bootstrap installer

Use this when the user wants the current repository to receive the canonical AI-Ready layer through the AI itself instead of through the CLI.

## Goal

Create a real `.ai/` control plane for the repository and keep runtime adapters thin, but write grounded project-specific content from the start instead of leaving template filler everywhere.

## STEP 0 — MANDATORY FIRST ACTION

Before reading anything, before creating any files:

Ask the user:

> "Which AI tool or tools will you use in this repo?
> Options:
>   1. Claude Code only
>   2. Codex only
>   3. GitHub Copilot only
>   4. Cursor only
>   5. Generic (any AI, no vendor-specific adapter)
>   6. Several — tell me which ones
>   7. All of the above
>
> I will only create the adapters you actually need."

Wait for the answer. Do not proceed until the user responds.
Do not default to all. Do not search the web.

## Expected inputs (after step 0)

- repository root and folder structure
- build files and dependency manifests
- module, package, target, or workspace boundaries
- test directories and verification entry points
- existing AI-related files such as `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, `.cursor/rules/`, or `AI-READY.md`

## Install workflow

1. Audit the repository before writing files.
2. Detect the project type from evidence: `android`, `ios`, `web`, `backend`, or `generic`.
3. If AI files already exist, archive them under `.ai/archive/ai-assisted-bootstrap-<timestamp>/` before overwriting active files.
4. Create the canonical structure:
   - `.ai/README.md`
   - `.ai/context.md`
   - `.ai/context/architecture.md`
   - `.ai/context/dependencies.md`
   - `.ai/context/features.md`
   - `.ai/context/repository.md`
   - `.ai/context/recent-changes.md`
   - `.ai/decision-framework.md`
   - `.ai/rules/`
   - `.ai/agents/` — with agent-explore, agent-context-bootstrap, agent-plan, agent-code, agent-verify, agent-fix, agent-tech, agent-spike
   - `.ai/skills/` — with context-bootstrap, context-refresh, feature-scaffold, migration-audit
   - `.ai/features/`
   - `.ai/archive/`
5. Write `.ai/context*` from repository evidence:
   - real module names or paths
   - actual build and test commands when discoverable
   - real architecture boundaries
   - real feature areas
   - real workflow constraints
6. Create only the selected runtime adapters, using EXACTLY the formats below. Do not search the web for adapter formats.

### Adapter formats

**Claude Code — file: `CLAUDE.md`**
```
# Claude Adapter

Treat `.ai/` as canonical.

Read order:
1. `.ai/README.md`
2. `.ai/context.md`
3. `.ai/context/architecture.md`
4. `.ai/context/dependencies.md`
5. `.ai/context/repository.md`
6. `.ai/decision-framework.md`
7. The relevant files under `.ai/rules/`, `.ai/agents/`, and `.ai/skills/`

First pass rule:
- if `.ai/context.md` still shows `Pending first-pass grounding`, run `.ai/agents/agent-context-bootstrap.md` before implementation work

Do not duplicate routing, workflow, or checklists here.
```

**Codex — file: `AGENTS.md`**
```
# Codex Adapter

Treat `.ai/` as canonical.

Read order:
1. `.ai/README.md`
2. `.ai/context.md`
3. `.ai/context/architecture.md`
4. `.ai/context/dependencies.md`
5. `.ai/context/repository.md`
6. `.ai/decision-framework.md`
7. The relevant files under `.ai/rules/`, `.ai/agents/`, and `.ai/skills/`

First pass rule:
- if `.ai/context.md` still shows `Pending first-pass grounding`, run `.ai/agents/agent-context-bootstrap.md` before implementation work

Do not maintain duplicate workflow logic here.
```

**GitHub Copilot — file: `.github/copilot-instructions.md`**
```
# Copilot Adapter

Treat `.ai/` as canonical.

Before editing:
1. Read `.ai/README.md`
2. Read `.ai/context.md`
3. Read `.ai/context/architecture.md`
4. Read `.ai/context/dependencies.md`
5. Read `.ai/context/repository.md`
6. Read `.ai/decision-framework.md`

First pass rule:
- if `.ai/context.md` still shows `Pending first-pass grounding`, follow `.ai/agents/agent-context-bootstrap.md` before implementation work

Do not create a second source of truth under `.github/`.
```

**Cursor — file: `.cursor/rules/ai-ready.mdc`**
```
---
description: AI-Ready adapter for Cursor
globs:
alwaysApply: true
---

Treat `.ai/` as canonical.

Read order:
1. `.ai/README.md`
2. `.ai/context.md`
3. `.ai/context/architecture.md`
4. `.ai/context/dependencies.md`
5. `.ai/context/repository.md`
6. `.ai/decision-framework.md`
7. The relevant files under `.ai/rules/`, `.ai/agents/`, and `.ai/skills/`

If `.ai/context.md` still shows `Pending first-pass grounding`, run `.ai/agents/agent-context-bootstrap.md` first.
Do not duplicate workflow logic inside Cursor-specific files.
```

**Generic — file: `AI-READY.md`**
```
# Generic AI Adapter

Use this file when the runtime does not have a native repo adapter format, or when you want one universal entry point that works across multiple tools.

Treat `.ai/` as canonical.

## Read Order

1. `.ai/README.md`
2. `.ai/context.md`
3. `.ai/context/architecture.md`
4. `.ai/context/dependencies.md`
5. `.ai/context/repository.md`
6. `.ai/decision-framework.md`
7. The relevant files under `.ai/rules/`, `.ai/agents/`, and `.ai/skills/`

## Operating Rules

- Do not create a second source of truth outside `.ai/`
- Prefer existing project conventions over generic best practices
- If `.ai/context.md` still shows `Pending first-pass grounding`, run `.ai/agents/agent-context-bootstrap.md` first
- After meaningful work, update `.ai/context/recent-changes.md`

## Suggested First Prompt

Audit this repository against the canonical `.ai/` layer, summarize the real architecture and gaps, and then propose the smallest safe set of updates before changing code.
```

7. Stop after install and summarize. Then show the user what they can do right now.

   Summary:
   - project type detected
   - adapters created
   - key repo facts used to ground the files
   - open questions that still need confirmation

   Then show concrete, copy-paste-ready examples using the real project — not
   generic placeholders. Use real module names, real feature areas, and real
   problems noticed during the audit. For example:

   "Your AI-Ready layer is installed. Try it now:

    - To add a new feature:
      'Use agent-explore. I want to add [a real feature for this repo].'

    - To fix a bug:
      'Use agent-fix. [a plausible bug based on what you saw in the code].'

    - To investigate a refactor:
      'Use agent-spike. Is it worth [a real refactor opportunity you noticed]?'

    - To refresh the context after a big merge:
      'Use the context-refresh skill.'

    These agents read the .ai/ layer you just installed, so the AI already
    knows your architecture, conventions, and recent changes before acting."

   The user should be able to copy one of these and run it immediately.

## Rules

- Do not search the web for adapter formats — use the formats defined in this file
- Do not invent architecture details that are not supported by repository evidence
- Do not edit product code during the install pass unless the user explicitly asks for it
- Do not create a second source of truth outside `.ai/`
- Do not create adapters for runtimes the user did not request
- If a detail is unclear, record an explicit open question instead of hallucinating
- Keep runtime adapters thin and point them back to `.ai/`

## Done means

- the repository has a canonical `.ai/` layer
- `.ai/context.md` is grounded, not obviously template text
- the selected runtime adapters exist and point into `.ai/`
- existing AI files were archived before overwrite when needed
- no web searches were performed during the install
- the install summary clearly calls out what is still unknown
- the user has at least three concrete copy-paste prompts to try immediately
