Use this prompt in any AI tool that can read and edit the target repository locally.

```text
Install the canonical agentlayer layer in this repository.

─────────────────────────────────────────
STEP 0 — MANDATORY. DO THIS BEFORE ANYTHING ELSE.
─────────────────────────────────────────
Ask the user:

  "Which AI tool or tools will you use in this repo?
   Options:
     1. Claude Code only
     2. Codex only
     3. GitHub Copilot only
     4. Cursor only
     5. Generic (any AI, no vendor-specific adapter)
     6. Several — tell me which ones
     7. All of the above

   You can also say 'just one' or 'all'. I will only create the adapters
   you actually need."

Wait for the answer. Do not create any files until you have it.
Do not assume. Do not default to all. Do not search the web.

─────────────────────────────────────────
STEP 1 — Audit before writing anything.
─────────────────────────────────────────
Inspect:
- root structure and folder layout
- build files and dependency manifests
- module, package, target, or workspace boundaries
- test directories and CI configuration
- any existing AI-related files (AGENTS.md, CLAUDE.md, .github/copilot-instructions.md,
  .cursor/rules/, AGENTLAYER.md, .ai/)

Detect the project type from evidence: android, ios, web, backend, or generic.
If AI-related files already exist, archive them under .ai/archive/ai-assisted-bootstrap-<timestamp>/
before overwriting active files.

─────────────────────────────────────────
STEP 2 — Create the canonical .ai/ structure.
─────────────────────────────────────────
Create these files:
  .ai/README.md
  .ai/context.md
  .ai/context/architecture.md
  .ai/context/dependencies.md
  .ai/context/features.md
  .ai/context/repository.md
  .ai/context/recent-changes.md
  .ai/decision-framework.md
  .ai/rules/              (at minimum: code.md, testing.md)
  .ai/agents/
    agent-explore.md
    agent-context-bootstrap.md
    agent-plan.md
    agent-code.md
    agent-verify.md
    agent-fix.md
    agent-tech.md
    agent-spike.md
  .ai/skills/
    context-bootstrap.md
    context-refresh.md
    feature-scaffold.md
    migration-audit.md
  .ai/features/
  .ai/archive/

─────────────────────────────────────────
STEP 3 — Write grounded content.
─────────────────────────────────────────
Fill .ai/context* with real repository knowledge:
- real module names or paths
- real architecture boundaries
- real dependencies
- real test commands or test directories
- real repository workflow constraints
- real feature areas

Do not leave generic placeholder text. If a detail is unclear, write an explicit
open question in that file instead of inventing details.

─────────────────────────────────────────
STEP 4 — Create only the runtime adapters the user requested.
─────────────────────────────────────────
Use EXACTLY the formats below. Do not search the web for adapter formats.

--- CLAUDE CODE adapter (file: CLAUDE.md) ---
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
--- END ---

--- CODEX adapter (file: AGENTS.md) ---
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
--- END ---

--- GITHUB COPILOT adapter (file: .github/copilot-instructions.md) ---
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
--- END ---

--- CURSOR adapter (file: .cursor/rules/agentlayer.mdc) ---
---
description: agentlayer adapter for Cursor
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
--- END ---

--- GENERIC adapter (file: AGENTLAYER.md) ---
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
- If key architecture details are still placeholders, audit the repo first and update `.ai/context/`
- After meaningful work, update `.ai/context/recent-changes.md`

## Suggested First Prompt

Audit this repository against the canonical `.ai/` layer, summarize the real architecture and gaps, and then propose the smallest safe set of updates before changing code.
--- END ---

─────────────────────────────────────────
STEP 5 — Do not do any of these.
─────────────────────────────────────────
- Do not search the web for adapter formats or AI tool documentation
- Do not edit product code during this install pass
- Do not create adapters for runtimes the user did not request
- Do not leave template filler in .ai/context* files
- Do not create a second source of truth outside .ai/

─────────────────────────────────────────
STEP 6 — When you finish, summarize and show the user what to do next.
─────────────────────────────────────────
First, summarize:
- project type detected
- runtimes installed
- key repo facts used to ground the files
- open questions that still need confirmation

Then show the user what they can do RIGHT NOW with the installed system.
Give them concrete, copy-paste-ready examples using their actual project,
not generic placeholders. For example:

  "Your agentlayer layer is installed. Try it now:

   - To add a new feature:
     'Use agent-explore. I want to add [a real feature that makes sense for this repo].'

   - To fix a bug:
     'Use agent-fix. [describe a plausible bug based on what you saw in the code].'

   - To investigate a refactor:
     'Use agent-spike. Is it worth [a real refactor opportunity you noticed during the audit]?'

   - To refresh the context after a big merge:
     'Use the context-refresh skill.'

   These agents read the .ai/ layer you just installed, so the AI already
   knows your architecture, conventions, and recent changes before acting."

Adapt the examples to the real project. Use real module names, real feature areas,
and real problems you noticed during the audit. The user should be able to copy
one of these and run it immediately.
```
