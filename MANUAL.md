# sdd-harness — Manual

> **v1.0.0-alpha** — This manual is intentionally minimal. The detailed v0.5.0 manual covered the previous CLI and a `.ai/` layout that no longer exists. A full manual returns in v1.0.0-beta.

## Where to read

All authoritative documentation is now under [`.ai/`](.ai/). Start there.

| Topic | File |
|---|---|
| How any AI operates the project | [`.ai/ROUTING.md`](.ai/ROUTING.md) |
| Vision and non-goals | [`.ai/PRODUCT.md`](.ai/PRODUCT.md) |
| Current state (phase, branch, decisions) | [`.ai/CONTEXT.md`](.ai/CONTEXT.md) |
| Backlog (`SH-NNN` stories) | [`.ai/BACKLOG.md`](.ai/BACKLOG.md) |
| SDD discipline primer | [`.ai/notes/spec-driven-development.md`](.ai/notes/spec-driven-development.md) |
| Runtime-agnostic AI layer rationale | [`.ai/adrs/0008-runtime-agnostic-ai-layer.md`](.ai/adrs/0008-runtime-agnostic-ai-layer.md) |
| Glossary | [`.ai/specs/glossary.md`](.ai/specs/glossary.md) |
| Product Requirements | [`.ai/specs/PRD.md`](.ai/specs/PRD.md) |

## Commands (when invoked by a human or AI)

Each command is a Markdown procedure in `.ai/commands/`. Read the file before running it.

| Command | Purpose |
|---|---|
| [`spec`](.ai/commands/spec.md) | Write or update a spec for a story |
| [`story`](.ai/commands/story.md) | Expand a spec into a concrete implementation plan |
| [`implement`](.ai/commands/implement.md) | Execute the plan against the codebase |
| [`verify`](.ai/commands/verify.md) | Verify code matches spec and acceptance criteria |
| [`review`](.ai/commands/review.md) | Security + architecture review of the current diff |
| [`release`](.ai/commands/release.md) | Drive a release through your project's release toolchain |

## Installing the pre-commit hook

```bash
# 1. Customize the code globs to match your stack
$EDITOR .ai/hooks/config.sh

# 2. Install the hook
./.ai/hooks/install.sh
```

The hook blocks `feat/*` commits that touch declared code globs without touching `.ai/specs/` or `.ai/adrs/`. Bypass for documented exceptions: `SH_SDD_SKIP=1 git commit ...`.

## CLI

`bin/sdd-harness` ships in this release. Install it via `bash install.sh`, then run `sdd-harness init` inside any target repo to lay down the canonical `.ai/` layer plus bootloaders.

## Roadmap to v1.0.0

See [CHANGELOG.md](CHANGELOG.md) for the rupture rationale and [README.md](README.md#roadmap) for the phased path to v1.0.0.
