# Changelog

All notable changes to AI-Ready Bootstrap are documented here.

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
- Ready-to-copy add-on package at `assistant-installer/addon/ai-ready-bootstrap-installer/`

## [0.1.0] - 2026-04-16

### Added
- CLI (`bin/ai-ready`) with `audit`, `install`, and `standardize` commands
- Multi-runtime selection: Codex, Claude Code, Copilot, Cursor, generic
- Project type detection: Android, iOS, web, backend, generic
- Canonical `.ai/` layer with context, rules, agents, and skills
- AI-assisted install path (`assistant-installer/SKILL.md`, `PROMPT.md`)
- First-pass context bootstrap workflow (`proj-context-bootstrap`)
- Git governance with optional pre-commit hook and identity configuration
- GitHub Actions CI with syntax checks and smoke tests for Android, iOS, and standardize modes
- `install.sh` for external CLI adoption
