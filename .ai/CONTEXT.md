# AI-Ready Bootstrap — Context

**Last Verified:** 2026-04-29

## General Info

- **What:** Structured context layer for any existing repo so that Codex, Claude Code, Copilot, Cursor, or any AI stops guessing and follows real architecture, conventions, and decisions from the first prompt
- **Name:** agentlayer (formerly AI-Ready Bootstrap)
- **Repo:** [iMark21/agentlayer](https://github.com/iMark21/agentlayer) (public)
- **Local checkout:** configured in machine-level `projects.local.yaml`
- **Status:** Published (OSS)
- **Version:** 0.5.0 + cover preview on main
- **License:** MIT

## Concept

Many repos have no AI-Ready system or have partial, drifting runtime files such as `AGENTS.md`, `CLAUDE.md`, or Copilot instructions. The AI wastes the first ten minutes re-learning the project from scratch every session.

agentlayer installs a canonical `.ai/` layer into any existing repo — a single source of truth that every AI reads before acting. It supports two install paths:

1. AI-assisted: paste `assistant-installer/PROMPT.md` into any AI, which asks which runtimes to use and generates the layer interactively
2. CLI: `bin/agentlayer audit|install|standardize` for deterministic scripted setup

After install the AI knows the product, follows conventions, and remembers decisions from the first prompt — with no dependencies and no cloud account required.

## Stack

| Category | Technology |
| --- | --- |
| Language | Bash 3.2+ |
| Output | Markdown + thin runtime adapters |
| Dependencies | None |
| Execution | Local CLI |
| Scope | Existing repos (mobile, web, backend, generic) |

## Components

| Component | Path | Description |
| --- | --- | --- |
| CLI | `bin/agentlayer` | Main entry point with `audit`, `install`, and `standardize` commands |
| Installer | `install.sh` | Optional local installer that exposes `agentlayer` in a user-selected bin directory |
| AI installer | `assistant-installer/PROMPT.md` | Universal AI-assisted install prompt — works with Codex, Claude Code, Copilot, Cursor, or any AI. Self-contained with all adapter formats embedded |
| README | `README.md` | Scenario-driven landing page with runtime-specific install blocks |
| Manual | `MANUAL.md` | Longer operating guide |

## Key Features

- **Multi-runtime selection** — one, two, or several runtimes (`codex`, `claude`, `copilot`, `cursor`, `generic`)
- **Canonical `.ai/` layer** — single source of truth for context, rules, agents, and skills
- **Universal fallback adapter** — `AI-READY.md` gives any AI tool a stable repo entry point
- **Audit mode** — inspect before changing a repo
- **Standardize mode** — back up existing AI files and normalize them
- **Git governance** — optional hook installation plus local git identity application
- **Project type detection** — Android, iOS, web, backend, generic

## Current Status

- Project renamed to **agentlayer**; GitHub repo moved to `iMark21/agentlayer` (public)
- CLI command renamed from `ai-ready` to `agentlayer`
- Repo is public since v0.2.0; CONTRIBUTING.md, CHANGELOG, CODE_OF_CONDUCT, SECURITY, and GH templates added
- AI-assisted install path simplified: `PROMPT.md` is the single universal installer (works with any AI, no SKILL.md dependency)
- Generated agents renamed from `proj-` prefix to `agent-` prefix
- Install runtime selection is now required before any files are created (prompt blocking fix)
- All adapter formats (CLAUDE.md, AGENTS.md, copilot-instructions.md, .mdc, AGENTLAYER.md) embedded inline in PROMPT.md — no web search needed
- PROMPT.md generates copy-paste-ready next-step prompts using real project context after install
- Workspace marketing assets under `other-bets/ai-ready-bootstrap/marketing/`: paste-ready LinkedIn ES/EN copy, landscape A5 HTML brochure, PDF export script
- Current release: `v0.6.0` on `main` with a live GitHub Release. `develop` is synced with `main` after the release closeout.
- Next roadmap: ARB-29 (PR3 agentlayer + OpenSpec positioning). ARB-30 (refresh + `.ai/changes/` bridge) optional, gated on PR2 validation. ARB-06 (release automation + semantic versioning) remains pending, although this release already established manual git tag + GitHub Release flow for `v0.6.0`.

## Recent Activity

| Date | Activity |
| --- | --- |
| 2026-04-29 | Added standalone publishable `.ai/` layer with `agentlayer.yaml` v2, project context, product brief, backlog, and stories directory |
| 2026-04-23 | **v0.6.0 released.** `release/0.6.0` cut from `develop`, `CHANGELOG.md` sealed (`Unreleased` reopened, `0.6.0` section dated, missing `0.5.0` section backfilled), merged to `main`, tagged `v0.6.0`, pushed, and published as a live GitHub Release. Ships ARB-27 trust fixes and ARB-28 unified onboarding (`agentlayer init` + README first-use recut). `develop` synced back with the release changelog closeout and merged branches were deleted. |
| 2026-04-23 | **ARB-28 merged (PR #3)** — PR2 unified onboarding: `agentlayer init` added as the recommended single-entrypoint command, with optional path defaulting to cwd, preflight summary, interactive runtime prompt, confirmation step, and automatic routing to `install` on fresh repos or `standardize` when AI files already exist. README recut around the first-use flow, AI-assisted prerequisites made explicit, MANUAL updated with `init` as the recommended command, 3 CI cases added (`init` routes to `install`, `init` routes to `standardize`, `init` with no path defaults to cwd). CHANGELOG `[Unreleased]` updated. |
| 2026-04-23 | **ARB-27 merged (PR #2)** — PR1 trust fixes: path normalization (`install .` no longer renders `Project Name | .`), `--non-interactive` fail-fast without `--runtimes`, centralized `has_existing_ai_files` helper (includes `.github/instructions/`), `install` refuses mixed-state repos and points at `standardize`, post-install output replaced with per-runtime paste-ready blocks aligned with `MANUAL.md`, `install.sh` warns on volatile clone paths (`/tmp`, `/var/folders`), README clones into `~/.agentlayer`. 3 new CI cases covering fail-fast paths. CHANGELOG `[Unreleased]` opened. |
| 2026-04-16 | Initial build: CLI scaffold, audit/install/standardize modes, runtime selection, Git hook generation, README and MANUAL. Validated against fresh and pre-existing temp repos |
| 2026-04-16 | Extracted to standalone local repo; GitHub repo created at `iMark21/ai-ready-bootstrap` (private -> made public at v0.2.0) |
| 2026-04-16 | GitHub Actions CI added; repo default branch set to `develop`; iOS support, Cursor and generic adapters added; AI-assisted install path added (`PROMPT.md` + `SKILL.md`) |
| 2026-04-16 | Released `v0.1.0` on `main`. Released `v0.1.1` (Codex add-on + explicit skill-install path) on `main` |
| 2026-04-16 | **v0.2.0** — public launch overhaul: CONTRIBUTING.md, CHANGELOG, CODE_OF_CONDUCT, SECURITY, GH templates, Before/After README, removed private-repo mention |
| 2026-04-16 | **v0.2.1** — README rewritten as scenario-driven guide with runtime-specific install blocks (Claude Code, Codex, Copilot, Cursor, generic) and three real workflow examples |
| 2026-04-16 | **v0.3.0** — generated agents renamed from `proj-` prefix to `agent-` prefix across all templates |
| 2026-04-16 | **v0.3.1** — install section collapsed to one universal prompt that works with any AI; no more per-runtime routing table |
| 2026-04-16 | **v0.3.2** — PROMPT.md now requires AI to ask which runtimes before creating files; all adapter formats embedded inline; "Do not search the web" rule added |
| 2026-04-17 | **v0.3.3** — PROMPT.md generates copy-paste-ready next-step prompts using real project context after install |
| 2026-04-17 | **v0.4.0** — SKILL.md and addon removed; PROMPT.md is the single universal installer |
| 2026-04-17 | **v0.5.0** — project renamed to **agentlayer**; GitHub repo moved to `iMark21/agentlayer`; CLI binary renamed to `agentlayer` |
| 2026-04-17 | Cover preview image added to README via PR #1; merged into `main` |
| 2026-04-17 | Marketing assets added to workspace `marketing/`: paste-ready LinkedIn ES/EN copy, landscape A5 HTML brochure, ES/EN PDF export script, and refined brochure around agents/skills/rules/day-2 workflows |
