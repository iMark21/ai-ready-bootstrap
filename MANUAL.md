# AI-Ready Bootstrap Manual

## Purpose

This tool exists for a very specific problem:

- many repos have no AI-Ready layer at all
- some repos already have partial files such as `AGENTS.md`, `CLAUDE.md`, or Copilot instructions
- teams want one canonical system, but different people use different AI runtimes

The solution here is:

1. install a canonical `.ai/` layer
2. choose one, two, or several runtimes
3. generate only the adapters required for those runtimes
4. keep Git governance and repository conventions explicit
5. if the repo already has AI files, audit first and standardize instead of blindly overwriting

## Core Model

### Canonical Layer

`.ai/` is the source of truth.

It contains:

- context
- architecture notes
- dependency notes
- feature inventory
- repository workflow
- recent changes and gotchas
- decision framework
- rules by file or layer type
- agent playbooks
- deterministic skills

### Runtime Adapters

Adapters are thin.

- `AGENTS.md` only exists if you choose `Codex`
- `CLAUDE.md` only exists if you choose `Claude Code`
- `.github/copilot-instructions.md` and `.github/instructions/` only exist if you choose `GitHub Copilot`

This avoids the common failure mode where every runtime has a slightly different truth.

## Commands

### 1. Audit

Read-only mode.

Use it when:

- the repo has no AI setup and you want to inspect first
- the repo already has AI files and you need a gap analysis
- you want a report for another developer before changing anything

Example:

```bash
bin/ai-ready audit /path/to/repo
```

Optional report file:

```bash
bin/ai-ready audit /path/to/repo \
  --report-path /tmp/ai-ready-audit.md
```

### 2. Install

Use it when the repo does not yet have a canonical AI layer.

Example:

```bash
bin/ai-ready install /path/to/repo \
  --runtimes codex,claude \
  --project-type android
```

What it does:

- detects or accepts the project type
- creates `.ai/`
- writes the canonical docs and playbooks
- writes only the runtime adapters you selected
- optionally installs Git hooks
- optionally applies local git user name and email

### 3. Standardize

Use it when the repo already has AI-related files and you want to normalize it.

Example:

```bash
bin/ai-ready standardize /path/to/repo \
  --runtimes codex,claude,copilot \
  --yes
```

What it does:

- audits what is already there
- backs up known AI files under `.ai/archive/standardize-*`
- rewrites the canonical `.ai/` layer
- rewrites the selected runtime adapters
- preserves a backup before overwrite

## Project Type Detection

Current automatic detection:

- `android`
- `ios`
- `web`
- `backend`
- `generic`

If detection is not what you want, force it:

```bash
bin/ai-ready install /path/to/repo \
  --project-type android \
  --runtimes codex
```

## Runtime Selection

You can choose one runtime, several, or `all`.

### Single Runtime

```bash
--runtimes codex
--runtimes claude
--runtimes copilot
```

### Multi Runtime

```bash
--runtimes codex,claude
--runtimes codex,claude,copilot
```

### All

```bash
--runtimes all
```

This expands to:

- `codex`
- `claude`
- `copilot`

## Git Governance

This tool deliberately mirrors the ai-workspace conventions.

### Installed Rules

- block direct commits on `main`, `develop`, and `master`
- encourage short-lived feature/fix/chore branches
- use commit format `[branch_name] type: "title"`
- do not add AI co-author trailers

### Hook Installation

If the target repo is a git repo and you do not pass `--no-git-hook`, the tool:

- creates `.githooks/pre-commit`
- sets `core.hooksPath=.githooks`

### Git Identity

The tool records detected `user.name` and `user.email` in `.ai/context/repository.md`.

If you want the tool to apply them locally:

```bash
bin/ai-ready install /path/to/repo \
  --runtimes codex \
  --git-name "Michel Marques" \
  --git-email "marques.jm@icloud.com" \
  --apply-git-config
```

### Branch Policy

This repo itself follows GitFlow-style intent:

- `develop` is the working default branch
- `main` is kept for release-ready state
- feature work happens on short-lived branches
- changes merge back into `develop` first

## Files Generated In The Target Repo

### Canonical

```text
.ai/
|-- README.md
|-- context.md
|-- context/
|   |-- architecture.md
|   |-- dependencies.md
|   |-- features.md
|   |-- repository.md
|   `-- recent-changes.md
|-- decision-framework.md
|-- rules/
|-- agents/
|-- skills/
|-- features/
`-- archive/
```

### Optional Runtime Adapters

- `AGENTS.md`
- `CLAUDE.md`
- `.github/copilot-instructions.md`
- `.github/instructions/`

## Android Example

If you want to hand this to an Android teammate, there are two valid modes:

### Mode A: Read First, Then Apply

1. run `audit`
2. send the report plus this manual
3. let the developer decide which runtimes to enable
4. run `install` or `standardize`

### Mode B: Execute Directly

```bash
bin/ai-ready install ~/Developer/android-repo \
  --runtimes codex,claude \
  --project-type android \
  --git-name "Michel Marques" \
  --git-email "marques.jm@icloud.com" \
  --apply-git-config
```

That gives the developer:

- a canonical `.ai/` layer
- adapters only for the selected AI tools
- documented Git workflow
- a starting point that can then be refined with project-specific knowledge

## Recommended Team Workflow

1. `audit` every repo before touching anything
2. decide the runtime set
3. install or standardize
4. replace generic placeholders with real architecture and feature details
5. keep `.ai/context/recent-changes.md` and `.ai/features/` alive after real work

## Why This Is Documented Twice

The README is short and execution-oriented.
This manual is the longer explanation for teammates who want to understand the model before running the tool.

That split is intentional:

- README = quick start
- MANUAL = operating model and reasoning

## CI

The repo now includes a GitHub Actions workflow in `.github/workflows/ci.yml`.

It validates:

- `bash -n bin/ai-ready`
- install flow on a fresh Android-like temp repo
- standardize flow on a temp repo with pre-existing AI files
