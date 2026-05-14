# Changelog

All notable changes are documented here.

## [Unreleased]

## [1.0.0-alpha] - 2026-05-15

> **Project rename and rupture.** `agentlayer` is renamed to **`sdd-harness`**. v1.0.0 is a documented break from v0.5.0 — no migration shim. The `agent-explore → plan → code → verify` flow is removed entirely; the new flow is `spec → story → implement → verify → review → release`. This release ships the framework core; the CLI that distributes it into other repos is still wired to v0.5.0 templates and will be rewritten in v1.0.0-beta.

### Changed (breaking)
- **Project renamed**: `agentlayer` → `sdd-harness`. Local folder renamed `ai-ready-bootstrap` → `sdd-harness`. Remote rename to `iMark21/sdd-harness` lands at v1.0.0.
- **`.ai/` layer replaced** with the disciplined Spec-Driven Development scaffold iterated through 6 phases in a real production codebase. Domain-specific artifacts (BLE/NFC/Keychain/Vapor) are scrubbed; only the generic discipline is kept.
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
