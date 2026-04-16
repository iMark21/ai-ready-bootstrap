# Changelog

All notable changes to agentlayer are documented here.

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
