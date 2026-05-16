# Changelog

All notable changes are documented here.

## [Unreleased]

### Added — toward v1.0.0-beta
- **AI-assisted install (SH-F4-108)**: `assistant-installer/PROMPT.md` — a self-contained, tool-agnostic workflow an AI with local repo access runs end to end: install → **audit the repo** (README, layout, manifests, git log; no fabrication) → fill PRODUCT/BACKLOG/CONTEXT/glossary → verify the hook surface if the dry-run warns → propose the first story. Paste one fetch line; the CLI still never shells out to an AI (ADR-0008 intact). README "Install" gains path (c). This is the codified form of the marvel-android cold-start that proved beta gate #2.
- **Install completeness (SH-F4-110)**: `init` now finishes the deterministic work and hands off the judgment work instead of dropping empty templates.
  - **Glob-sanity dry-run**: after installing the hook, the repo's `SH_CODE_GLOBS` are matched against `git ls-files` after `SH_CODE_EXCLUDE_GLOBS`. If nothing is protected, a prominent warning lists the repo's top-level dirs and names `.ai/hooks/config.sh` to edit. Uses the same case-pattern matcher as the hook, so the dry-run cannot disagree with it.
  - **`{{GIT_BRANCH}}` seed**: `CONTEXT.md`'s Branch line is the repo's real current branch (`git symbolic-ref`, works pre-first-commit), not a hardcoded `develop`.
  - **`.ai/BOOTSTRAP.md`**: the precise prompt that fills the judgment-layer files (PRODUCT/CONTEXT/BACKLOG/glossary) from the repo, written into the repo and referenced as post-install step 1 — no longer buried in the README/scrollback. Still zero-dep / runtime-agnostic (nothing shells out to an AI).
- **Universal code-surface default (SH-F4-111)**: fresh installs now set `SH_CODE_GLOBS=("*")` with stack-agnostic `SH_CODE_EXCLUDE_GLOBS`, so nested Android, iOS, Go, web, backend, and monorepo layouts are protected without manual glob tuning. `feature/*` branches are gated alongside `feat/*`; docs-only feature commits remain allowed.
- **Multi-runtime bootloaders**: Cursor (`.cursor/rules/sdd-harness.mdc`), Copilot (`.github/copilot-instructions.md`), Gemini (`GEMINI.md`). Each is the same 5-line pointer pattern as `CLAUDE.md` / `AGENTS.md`, just in the location each runtime expects.
- CLI accepts `--runtimes all` as an alias that expands to `claude,codex,cursor,copilot,gemini`. Default remains `claude,codex` to avoid polluting repos that don't use the other runtimes.
- `audit` now detects `GEMINI.md` as a known AI marker.
- CI workflow gains two new smoke steps: `--runtimes all` installs every bootloader; `--runtimes cursor` installs only Cursor (and no others).

## [1.0.0-alpha] - 2026-05-15

> **Project rename and rupture.** `agentlayer` is renamed to **`sdd-harness`**. v1.0.0 is a documented break from v0.5.0 — no migration shim. The `agent-explore → plan → code → verify` flow is removed entirely; the new flow is `spec → story → implement → verify → review → release`. This release ships the framework core, the rewritten CLI, and the governance mirror discipline.

### Added (F2 — CLI rewrite)
- `bin/sdd-harness` rewritten from scratch (311 lines, down from 1779 in the v0.5.0 `bin/agentlayer`). Commands: `init` (auto-routes), `install`, `standardize`, `audit`.
- `templates/` directory at the repo root: canonical `.ai/` (with framework-canonical files like commands/hooks/ROUTING/ADR-0008 and project-specific placeholders for PRODUCT/CONTEXT/BACKLOG/PRD/glossary) plus root bootloaders. The CLI does `cp -R` from here — no embedded heredocs.
- Placeholder substitution: `{{PROJECT_NAME}}`, `{{STORY_PREFIX}}` (3-letter uppercase), `{{TODAY}}` (YYYY-MM-DD) are rewritten on `install`.
- `install.sh` updated for the new binary name (`sdd-harness`) and install path (`~/.sdd-harness`).
- `.ai/adrs/0009-ci-stack-plugins.md` documents the planned plugin pattern for deterministic CI (`tools/ci.sh` dispatcher + per-stack plugins under `tools/ci/`). Implementation deferred to `SH-F2-002` (post-v1.0.0-alpha).
- `.ai/specs/acceptance/SH-F2-001-cli-init.feature` validates the rewritten CLI end-to-end.

### Added (F3 — Governance mirror)
- `.ai/commands/phase-close.md` codifies the procedure for closing a phase: verify all stories terminal, bump `CONTEXT.md` header, append done items, refresh decisions and risks, update `BACKLOG.md`. Mirrored under `templates/.ai/commands/`.
- `.ai/notes/governance-mirror.md` explains the discipline: `CONTEXT.md` is the project's mirror, updated only at phase close, never auto-generated.
- `templates/.ai/CONTEXT.md` formalized with the 5 required sections (Current state / Done / Immediate next / Decisions taken / Open risks).
- `.ai/specs/acceptance/SH-F3-001-phase-close.feature` (8 scenarios) — including "an AI assistant reading CONTEXT.md after phase-close has full context".

### Changed
- **GitHub repository renamed**: `iMark21/agentlayer` → `iMark21/sdd-harness`. GitHub serves redirects from the old URL.
- **CLI renamed**: `bin/agentlayer` → `bin/sdd-harness`. Install path: `~/.local/bin/sdd-harness`. The old name no longer ships.
- **Runtime support narrowed to claude + codex in v1.0.0-alpha**. Future runtimes (cursor, copilot, gemini) reintroduced as their bootloaders ship.
- **Drop CLI flags that no longer apply**: `--project-type`, `--project-name`, `--git-name`, `--git-email`, `--apply-git-config`, `--report-path`. The harness layout is universal; project metadata is derived from the directory name and customized post-install.

### Changed (breaking)
- **Project renamed**: `agentlayer` → `sdd-harness`. Local folder renamed `ai-ready-bootstrap` → `sdd-harness`. Remote rename to `iMark21/sdd-harness` lands at v1.0.0.
- **`.ai/` layer replaced** with the disciplined Spec-Driven Development scaffold iterated through multiple phases in a real production codebase. Domain-specific artifacts are excluded; only the generic discipline is kept.
- **Old flow removed**: `agent-explore`, `agent-plan`, `agent-code`, `agent-verify` and their related skills are deleted. New flow: `spec`, `story`, `implement`, `verify`, `review`, `release` (one Markdown command file per step).
- **Story prefix changed** from `ARB-NNN` to `SH-NNN`. Old backlog (ARB-29..51 Agentic Governance Pack roadmap) discarded as no longer applicable.
- **Bootloaders are now 5-line pointers.** `CLAUDE.md` and `AGENTS.md` at the repo root contain no instructions — they redirect to `.ai/ROUTING.md`. See ADR 0008.
- **Hook env var renamed**: `DOORKIT_SDD_SKIP` → `SH_SDD_SKIP` (inherited from upstream lineage and renamed for sdd-harness).
- **Hook code-globs are now per-project configurable** in `.ai/hooks/config.sh` instead of hardcoded.
- **`assistant-installer/`** directory removed. The PROMPT.md installer was tied to v0.5.0 and is incompatible with the new layout.

### Added
- `.ai/notes/spec-driven-development.md` — the SDD primer.
- `.ai/adrs/0008-runtime-agnostic-ai-layer.md` — the foundational architecture decision.
- `.ai/agents/spec-writer.md` — first reusable reviewer agent.
- Meta acceptance Gherkin at `.ai/specs/acceptance/SH-F1-001-dogfood.feature` — validates that the harness governs itself.

### Migration from v0.5.0
There is no automatic migration. If you have v0.5.0 installed:

```bash
# Remove the old install
rm -rf ~/.agentlayer
rm -f ~/.local/bin/agentlayer

# Wait for v1.0.0-beta for the new CLI, or copy .ai/ manually (see README.md)
```

Existing repos that were initialized with `agentlayer init` v0.5.0 will keep working — their `.ai/` is now legacy content from your perspective; the new sdd-harness `.ai/` is a different structure entirely.

### Known limitations (v1.0.0-alpha)
- The CLI (`bin/agentlayer` on disk, soon `bin/sdd-harness`) still installs v0.5.0 templates. Rewrite scheduled for v1.0.0-beta.
- No automated test suite for the harness itself yet. Validation is via the meta acceptance Gherkin read manually.
- No `GEMINI.md`, `.cursorrules`, or `.github/copilot-instructions.md` bootloaders yet — `CLAUDE.md` and `AGENTS.md` ship in v1.0.0-alpha and prove the pattern.

## [0.6.0] - 2026-04-23

### Added
- `agentlayer init` — recommended single-entrypoint command. Detects repository state (fresh vs. already has AI files), asks once which runtime(s) to use, prints a preflight summary (target repo, project type, existing AI files, chosen action, runtimes), confirms, and routes to `install` or `standardize`. Path argument is optional; defaults to the current directory. `audit`, `install`, and `standardize` remain available for advanced/scripted use.
- README recut around the first-use path (`agentlayer init`). Internal structural detail moved to MANUAL.md.
- README "Alternative — let your AI install it" section now states the prerequisites explicitly: the assistant must have local read/write access to the repository; cloud-only chat tools do not work.

### Changed (UX, breaking in edge cases)
- `agentlayer install` now refuses to run on a repository that already has any AI-related file (`.ai/`, `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, `.github/instructions/`, `.cursor/rules/agentlayer.mdc`, or `AGENTLAYER.md`). The CLI exits non-zero and points at `agentlayer standardize`. The previous behavior (warn + optional prompt to continue) could leave a repo in a mixed state.
- `agentlayer install --non-interactive` without `--runtimes` now exits non-zero with an explicit error. Previously it silently fell back to a detected default (e.g. `codex,claude,generic`) and generated adapters the user had not asked for.
- `install` and `standardize` post-run output replaced the prose guidance with visually delimited, copy-paste-ready prompt blocks — one per selected runtime, with wording aligned to MANUAL.md "What To Ask The AI After Install".

### Fixed
- `agentlayer install .` no longer renders `Project Name | .` in generated docs. The target path is normalized with `cd && pwd -P` before any path operation.
- `install.sh` now emits a non-fatal warning when run from a volatile path (`/tmp`, `/var/folders`, `/var/tmp`). Clones into those locations produced a symlink that broke on next OS cleanup.
- README CLI-install example now clones into `~/.agentlayer` instead of `/tmp/agentlayer` to avoid the same footgun.

## [0.5.0] - 2026-04-17

### Changed
- Project renamed from **AI-Ready Bootstrap** to **agentlayer**.
- GitHub repository moved to `iMark21/agentlayer`.
- CLI command renamed from `ai-ready` to `agentlayer`.

## [0.4.0] - 2026-04-17

### Changed
- `assistant-installer/SKILL.md` removed. PROMPT.md is now the single universal installer — it works identically with Codex, Claude Code, Copilot, Cursor, or any other AI, and is self-contained with all adapter formats embedded.
- `assistant-installer/addon/` removed. The Codex skill add-on was a convenience wrapper for an install that runs once per repo. The prompt is sufficient.
- `assistant-installer/README.md` simplified from a routing table to a plain explanation of PROMPT.md.
- README and MANUAL.md updated to remove all references to SKILL.md and the addon.

## [0.3.3] - 2026-04-17

### Added
- PROMPT.md and SKILL.md now end with concrete copy-paste-ready examples using real project context. After install the AI shows the user three or more prompts they can run immediately — using real module names and real opportunities noticed during the audit, not generic placeholders.
- "Done means" checklist in SKILL.md updated: install is not complete until the user has actionable next steps.

## [0.3.2] - 2026-04-16

### Fixed
- PROMPT.md and SKILL.md now require the AI to ask which runtime(s) the user wants BEFORE creating any files. Previously the `[auto]` default caused the AI to install all runtimes and search the web for Copilot and Cursor adapter formats.
- All adapter format templates are now embedded inline in PROMPT.md and SKILL.md. The AI no longer needs to search the web to know the correct format for CLAUDE.md, AGENTS.md, copilot-instructions.md, .mdc, or AGENTLAYER.md.
- Added explicit "Do not search the web" rule to both files.
- Synced addon/agentlayer-installer/SKILL.md with parent SKILL.md.

## [0.3.1] - 2026-04-16

### Changed
- README install section collapsed from four per-AI blocks into two options: "Let your AI do it (any AI)" and "Use the CLI". The AI-assisted path is now a single universal prompt that works with Codex, Claude Code, Copilot, Cursor, or any other AI — the spec is fetched from PROMPT.md and the workflow asks which runtimes to use.

## [0.2.1] - 2026-04-16

### Changed
- README rewritten as a scenario-driven guide: "Does this sound familiar?", agent flow diagram, copy-paste install blocks per runtime (Claude Code, Codex, Copilot, Cursor, generic), and three real workflow examples (feature, bug fix, investigation)
- Install section reorganised by AI tool instead of Path A / Path B — each runtime has a self-contained block with the exact prompt or command to use

## [0.2.0] - 2026-04-16

### Added
- Compelling README with Before/After table, Quick Start, and "Who is this for" section
- MANUAL.md Quick Start section at the top
- Closing section in MANUAL.md summarizing the five core pieces of the system
- CHANGELOG.md
- CODE_OF_CONDUCT.md
- SECURITY.md
- GitHub issue and PR templates

### Changed
- README restructured as a public-facing landing page
- MANUAL.md examples now use generic placeholder names instead of personal git identity
- `.gitignore` expanded with common editor and OS patterns
- `assistant-installer/README.md` now includes a context paragraph before the routing table
- `CONTRIBUTING.md` updated with external contributor welcome

### Removed
- "Private repo" reference from README

## [0.1.1] - 2026-04-16

### Added
- Explicit Codex skill-install path via `assistant-installer/addon/README.md`
- Ready-to-copy add-on package at `assistant-installer/addon/agentlayer-installer/`

## [0.1.0] - 2026-04-16

### Added
- CLI (`bin/agentlayer`) with `audit`, `install`, and `standardize` commands
- Multi-runtime selection: Codex, Claude Code, Copilot, Cursor, generic
- Project type detection: Android, iOS, web, backend, generic
- Canonical `.ai/` layer with context, rules, agents, and skills
- AI-assisted install path (`assistant-installer/SKILL.md`, `PROMPT.md`)
- First-pass context bootstrap workflow (`proj-context-bootstrap`)
- Git governance with optional pre-commit hook and identity configuration
- GitHub Actions CI with syntax checks and smoke tests for Android, iOS, and standardize modes
- `install.sh` for external CLI adoption
