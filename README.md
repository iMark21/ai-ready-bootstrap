# AI-Ready Bootstrap

Your AI assistant writes better code when it actually knows your project.

AI-Ready Bootstrap adds a structured context layer to any existing repository so that Codex, Claude Code, Copilot, Cursor — or any AI — stops guessing and starts following your real architecture, conventions, and decisions from the first prompt.

Works with Android, iOS, web, backend, and any tech stack. No dependencies. One command. Any AI runtime.

## Before and after

| Without AI-Ready | With AI-Ready |
| --- | --- |
| Generic responses — AI ignores your patterns | Context read before every action |
| Decisions improvised per session | Explicit decision framework consulted |
| Loose prompts, no memory between tasks | Accumulated project memory |
| Each feature starts from zero | Reusable scaffold in one command |
| Migrations estimated by guesswork | Structured audits with risk and scope |
| Knowledge lives in one person's head | Documented and queryable by any AI |

## Quick start

```bash
# Install the CLI
git clone https://github.com/iMark21/ai-ready-bootstrap.git
cd ai-ready-bootstrap && bash install.sh

# Bootstrap your project
ai-ready install /path/to/your-repo \
  --runtimes claude,generic \
  --project-type ios

# Then tell your AI:
# "Read CLAUDE.md and the .ai/ layer. Ground the context with real repo knowledge."
```

That is it. Your AI now has architecture, conventions, and workflow memory.

## Who is this for

- Solo developers who use AI coding assistants daily and are tired of repeating the same context every session
- Teams where several developers use different AI runtimes on the same repository
- Tech leads who want the AI to follow team conventions, not invent its own
- Anyone building with Codex, Claude Code, Copilot, or Cursor who wants structured results instead of generic suggestions

## Choose your install path

| Path | Best when | What you get |
| --- | --- | --- |
| [Path A: install through your AI](assistant-installer/README.md) | You already work inside Codex, Claude, Cursor, or another AI with repo access | The AI inspects the repo first and writes a grounded `.ai/` layer instead of generic placeholders |
| Path B: install through the CLI | You want deterministic scaffolding, repeatable commands, or non-interactive runs | The CLI generates the canonical `.ai/` layer plus the adapters you select |

### Path A: install through your AI

Use this when you want the repository to be installed and grounded by the AI you already use.

1. Open [assistant-installer/README.md](assistant-installer/README.md).
2. If you use Codex and want the copy-here-use-there version, open [assistant-installer/addon/README.md](assistant-installer/addon/README.md).
3. If your AI supports custom skills or reusable playbooks, install [assistant-installer/SKILL.md](assistant-installer/SKILL.md).
4. If it does not, paste [assistant-installer/PROMPT.md](assistant-installer/PROMPT.md) into your AI.

This is the preferred path if you want `.ai/context*` to be filled from the real repository on the first pass.

### Path B: install through the CLI

```bash
git clone https://github.com/iMark21/ai-ready-bootstrap.git
cd ai-ready-bootstrap
bash install.sh
ai-ready --help
```

You can also run the command directly without installing globally:

```bash
bin/ai-ready --help
```

Fresh install:

```bash
ai-ready install /path/to/project \
  --runtimes codex,claude,generic \
  --project-type ios
```

Normalize an existing mixed setup:

```bash
ai-ready standardize /path/to/project \
  --runtimes all \
  --yes
```

## What gets installed

| Piece | What it contains | What you do with it |
| --- | --- | --- |
| `.ai/context*` | Project summary, architecture, dependencies, feature map, repository workflow, recent changes | Give the AI real project memory and keep it updated |
| `.ai/rules/*` | Language, UI, testing, analytics, data, and feature guardrails | Constrain edits so the AI follows the repo style and boundaries |
| `.ai/agents/*` | Playbooks such as `proj-explore`, `proj-feature`, `proj-code`, `proj-verify`, `proj-fix`, `proj-tech` | Run the right workflow for the task at hand |
| `.ai/skills/*` | Reusable checklists such as `context-bootstrap`, `context-refresh`, `feature-scaffold`, `migration-audit` | Reuse repeatable procedures without re-explaining them every time |
| Runtime adapters | `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, `.cursor/rules/ai-ready.mdc`, `AI-READY.md` | Let each AI runtime enter the same canonical `.ai/` layer |

## Use cases

| If you need to... | Use this | Result |
| --- | --- | --- |
| Add AI-Ready to a repo with no existing setup | Path A or `ai-ready install` | Canonical `.ai/` plus the runtime adapters you choose |
| Clean up a repo with mixed `AGENTS.md`, `CLAUDE.md`, Copilot, or Cursor files | `ai-ready audit` then `ai-ready standardize` | Existing files are backed up and replaced with one canonical `.ai/` layer |
| Ship a feature after bootstrap | `proj-explore` -> `proj-feature` -> `proj-code` -> `proj-verify` | Explore, plan, implement, and verify with one explicit flow |
| Fix a bug after bootstrap | `proj-fix` -> `proj-code` -> `proj-verify` | Reproduce, isolate, fix, and run regression checks |
| Refactor or run a migration | `proj-spike` or `migration-audit` -> `proj-tech` -> `proj-code` -> `proj-verify` | Decide scope first, then change structure in controlled steps |

## Workflows after install

### Feature work

1. Ground the context first if `.ai/context.md` still says `Pending first-pass grounding`.
2. Explore the relevant area with `proj-explore`.
3. Turn the request into a file-level plan with `proj-feature`.
4. Implement in small steps with `proj-code`.
5. Validate with `proj-verify`.
6. Refresh project memory in `.ai/context/recent-changes.md`.

### Bug fix work

1. Reproduce and isolate with `proj-fix`.
2. Apply the smallest safe change with `proj-code`.
3. Run focused regression checks with `proj-verify`.
4. Record the constraint or gotcha in `.ai/context/recent-changes.md`.

### Refactor or migration work

1. Investigate options with `proj-spike` or `migration-audit`.
2. Sequence the work with `proj-tech`.
3. Execute incrementally with `proj-code`.
4. Validate blast radius with `proj-verify`.

See [MANUAL.md](MANUAL.md) for the full operating guide with detailed examples.

## Runtime adapters

| Runtime | Adapter |
| --- | --- |
| `codex` | `AGENTS.md` |
| `claude` | `CLAUDE.md` |
| `copilot` | `.github/copilot-instructions.md` |
| `cursor` | `.cursor/rules/ai-ready.mdc` |
| `generic` | `AI-READY.md` |

`all` expands to `codex,claude,copilot,cursor,generic`.

Use `generic` when the team has not settled on a single assistant yet, or when the runtime has no native repo instruction format.

## Project types

| Project type | Detection hints | Primary rules generated |
| --- | --- | --- |
| `android` | `settings.gradle`, `settings.gradle.kts`, `AndroidManifest.xml` | `.ai/rules/kotlin.md`, `.ai/rules/compose.md` |
| `ios` | `.xcodeproj`, `.xcworkspace`, `Package.swift`, `Podfile` | `.ai/rules/swift.md`, `.ai/rules/swiftui.md` |
| `web` | `package.json`, `pnpm-lock.yaml`, `yarn.lock` | `.ai/rules/typescript.md`, `.ai/rules/react.md` |
| `backend` | `go.mod`, `Cargo.toml`, `pyproject.toml` | `.ai/rules/code.md`, `.ai/rules/ui.md` |
| `generic` | Fallback when nothing else matches | `.ai/rules/code.md`, `.ai/rules/ui.md` |

## The core idea

The system is runtime-agnostic. AI-Ready works on any tech project if you define these five things well:

1. Product context and architecture
2. Precise rules by file type or module
3. A decision framework for common changes
4. Specialized agents or flows by task type
5. Useful memory of what has already been done

## Read more

- [MANUAL.md](MANUAL.md) — Full operating guide with examples
- [assistant-installer/README.md](assistant-installer/README.md) — AI-assisted install path
- [CONTRIBUTING.md](CONTRIBUTING.md) — Branch, commit, and validation rules
- [CHANGELOG.md](CHANGELOG.md) — Version history
