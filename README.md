# AI-Ready Bootstrap

Bootstrap, audit, and standardize an AI-Ready layer in an existing software repository.

Private repo: `iMark21/ai-ready-bootstrap`

This tool is deliberately runtime-neutral at the core:

- `.ai/` is the canonical layer
- `AGENTS.md` is added only if you choose `Codex`
- `CLAUDE.md` is added only if you choose `Claude Code`
- `.github/` adapters are added only if you choose `GitHub Copilot`

It is designed for the case where a project:

- has no AI-Ready setup yet and needs one from scratch
- already has mixed AI files and needs to be normalized to a single canon
- must support one, two, or several AI runtimes without creating drift

## Why a CLI and not only a skill

A Codex skill alone is too narrow for this use case.
The problem is repo bootstrapping across teams and runtimes, so the best primitive is a runnable tool that:

- works even if the target repo has no AI setup yet
- can be used by a teammate without Codex-specific features
- can install runtime adapters selectively
- can audit and standardize existing setups

## Commands

```bash
# Read-only inspection
bin/ai-ready audit /path/to/repo

# Fresh install
bin/ai-ready install /path/to/repo \
  --runtimes codex,claude \
  --project-type android

# Normalize an existing setup
bin/ai-ready standardize /path/to/repo \
  --runtimes all \
  --yes
```

## Runtime Selection

Supported runtime targets:

- `codex`
- `claude`
- `copilot`
- `cursor`
- `generic`
- `all` = `codex,claude,copilot`

Examples:

```bash
# Codex only
bin/ai-ready install ../my-repo --runtimes codex

# Codex + Claude
bin/ai-ready install ../my-repo --runtimes codex,claude

# Copilot only
bin/ai-ready install ../my-repo --runtimes copilot
```

## What It Generates

Canonical files:

- `.ai/README.md`
- `.ai/context.md`
- `.ai/context/architecture.md`
- `.ai/context/dependencies.md`
- `.ai/context/features.md`
- `.ai/context/repository.md`
- `.ai/context/recent-changes.md`
- `.ai/decision-framework.md`
- `.ai/rules/`
- `.ai/agents/`
- `.ai/skills/`

Optional adapters:

- `AGENTS.md`
- `CLAUDE.md`
- `.github/copilot-instructions.md`
- `.github/instructions/`

Optional Git governance:

- `.githooks/pre-commit`
- `core.hooksPath=.githooks`
- local `user.name` / `user.email` if you pass `--apply-git-config`

## Git Governance

The tool mirrors the ai-workspace discipline:

- no direct commits on `main`, `develop`, or `master`
- short-lived feature/fix/chore branches
- commit format: `[branch_name] type: "title"`
- no AI `Co-Authored-By` trailers

## Branch Strategy

- `develop` is the default working branch
- `main` is reserved for release-ready history
- day-to-day work should happen on `feature/*`, `fix/*`, `chore/*`, or `docs/*`
- merge back into `develop`
- promote to `main` only through an explicit release step

## CI

GitHub Actions validates:

- shell syntax for `bin/ai-ready`
- fresh-install smoke tests
- standardize-mode smoke tests

Workflow file:

- `.github/workflows/ci.yml`

## Typical Android Flow

```bash
bin/ai-ready audit ~/Developer/android-app

bin/ai-ready install ~/Developer/android-app \
  --runtimes codex,claude \
  --project-type android \
  --git-name "Michel Marques" \
  --git-email "marques.jm@icloud.com" \
  --apply-git-config
```

## Existing AI-Ready Repo Flow

```bash
bin/ai-ready audit ~/Developer/android-app \
  --report-path /tmp/android-ai-audit.md

bin/ai-ready standardize ~/Developer/android-app \
  --runtimes codex,claude,copilot \
  --yes
```

`standardize` creates backups in `.ai/archive/standardize-YYYYMMDD-HHMMSS/` before overwriting known AI files.

## Manual

See [MANUAL.md](MANUAL.md) for the longer workflow, runtime matrix, and how to use this with teammates who may either read the docs or just run the tool.
