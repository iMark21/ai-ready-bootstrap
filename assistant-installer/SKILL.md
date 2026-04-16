# AI-Ready Bootstrap installer

Use this when the user wants the current repository to receive the canonical AI-Ready layer through the AI itself instead of through the CLI.

## Goal

Create a real `.ai/` control plane for the repository and keep runtime adapters thin, but write grounded project-specific content from the start instead of leaving template filler everywhere.

## Expected inputs

- repository root and folder structure
- build files and dependency manifests
- module, package, target, or workspace boundaries
- test directories and verification entry points
- existing AI-related files such as `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, `.cursor/rules/`, or `AI-READY.md`
- user choice of runtimes when provided

## Default runtime choice

If the user does not specify runtimes, prefer the current runtime plus `generic`.

## Install workflow

1. Audit the repository before writing files.
2. Detect the project type from evidence: `android`, `ios`, `web`, `backend`, or `generic`.
3. If AI files already exist, archive them under `.ai/archive/ai-assisted-bootstrap-<timestamp>/` before overwriting active files.
4. Create the canonical structure:
   - `.ai/README.md`
   - `.ai/context.md`
   - `.ai/context/`
   - `.ai/decision-framework.md`
   - `.ai/rules/`
   - `.ai/agents/`
   - `.ai/skills/`
   - `.ai/features/`
   - `.ai/archive/`
5. Write `.ai/context*` from repository evidence:
   - real module names or paths
   - actual build and test commands when discoverable
   - real architecture boundaries
   - real feature areas
   - real workflow constraints
6. Create only the selected runtime adapters:
   - `AGENTS.md`
   - `CLAUDE.md`
   - `.github/copilot-instructions.md`
   - `.github/instructions/`
   - `.cursor/rules/ai-ready.mdc`
   - `AI-READY.md`
7. Stop after install and summarize:
   - project type detected
   - adapters created
   - open questions
   - recommended next workflow

## Rules

- Do not invent architecture details that are not supported by repository evidence.
- Do not edit product code during the install pass unless the user explicitly asks for it.
- Do not create a second source of truth outside `.ai/`.
- If a detail is unclear, record an explicit open question instead of hallucinating.
- Keep runtime adapters thin and point them back to `.ai/`.

## Done means

- the repository has a canonical `.ai/` layer
- `.ai/context.md` is grounded, not obviously template text
- the selected runtime adapters exist and point into `.ai/`
- existing AI files were archived before overwrite when needed
- the install summary clearly calls out what is still unknown
