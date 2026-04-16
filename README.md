# AI-Ready Bootstrap

Bootstrap, audit, and standardize a canonical AI layer in an existing software repository.

Private repo: `iMark21/ai-ready-bootstrap`

## Choose your install path

| Path | Best when | What you get |
| --- | --- | --- |
| [Path A: install through your AI](assistant-installer/README.md) | you already work inside Codex, Claude, Cursor, or another AI with repo access | the AI inspects the repo first and writes a grounded `.ai/` layer instead of generic placeholders |
| Path B: install through the CLI | you want deterministic scaffolding, repeatable commands, or non-interactive runs | the CLI generates the canonical `.ai/` layer plus the adapters you select, then the repo runs a first-pass grounding step |

### Path A: install through your AI

Use this when you want the repository to be installed and grounded by the AI you already use.

1. Open [assistant-installer/README.md](assistant-installer/README.md).
2. If your AI supports custom skills or reusable playbooks, install [assistant-installer/SKILL.md](assistant-installer/SKILL.md).
3. If it does not, paste [assistant-installer/PROMPT.md](assistant-installer/PROMPT.md) into your AI.

This is the preferred path if you want `.ai/context*` to be filled from the real repository on the first pass.

### Path B: install through the CLI

If you have access to the repo, the fastest CLI setup is:

```bash
git clone git@github.com:iMark21/ai-ready-bootstrap.git
cd ai-ready-bootstrap
bash install.sh
ai-ready --help
```

You can also run the command directly without exposing it in your PATH yet:

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

If you want grounded files from the start instead of template-first generation, prefer Path A.

## Use cases

| If you need to... | Use this | Result |
| --- | --- | --- |
| add AI-Ready to a repo with no existing setup | Path A or `ai-ready install` | canonical `.ai/` plus the runtime adapters you choose |
| clean up a repo with mixed `AGENTS.md`, `CLAUDE.md`, Copilot, or Cursor files | `ai-ready audit` and then `ai-ready standardize` | existing files are backed up and replaced with one canonical `.ai/` layer |
| ship a feature after bootstrap | `.ai/agents/proj-explore.md` -> `.ai/agents/proj-feature.md` -> `.ai/agents/proj-code.md` -> `.ai/agents/proj-verify.md` | explore, plan, implement, and verify with one explicit flow |
| fix a bug after bootstrap | `.ai/agents/proj-fix.md` -> `.ai/agents/proj-code.md` -> `.ai/agents/proj-verify.md` | reproduce, isolate, fix, and run regression checks |
| refactor or run a migration | `.ai/agents/proj-spike.md` or `.ai/skills/migration-audit.md` -> `.ai/agents/proj-tech.md` -> `.ai/agents/proj-code.md` -> `.ai/agents/proj-verify.md` | decide scope first, then change structure in controlled steps |

## What gets installed

| Piece | What it contains | What you do with it |
| --- | --- | --- |
| `.ai/context*` | project summary, architecture, dependencies, feature map, repository workflow, recent changes | give the AI real project memory and keep it updated |
| `.ai/rules/*` | language, UI, testing, analytics, data, and feature guardrails | constrain edits so the AI follows the repo style and boundaries |
| `.ai/agents/*` | playbooks such as `proj-explore`, `proj-feature`, `proj-code`, `proj-verify`, `proj-fix`, `proj-tech` | run the right workflow for the task at hand |
| `.ai/skills/*` | reusable checklists such as `context-bootstrap`, `context-refresh`, `feature-scaffold`, `migration-audit` | reuse repeatable procedures without re-explaining them every time |
| runtime adapters | `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, `.cursor/rules/ai-ready.mdc`, `AI-READY.md` | let each AI runtime enter the same canonical `.ai/` layer |

## How the workflows behave after install

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

## Runtime adapters

| Runtime | Adapter |
| --- | --- |
| `codex` | `AGENTS.md` |
| `claude` | `CLAUDE.md` |
| `copilot` | `.github/copilot-instructions.md` plus `.github/instructions/` |
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
| `generic` | fallback when nothing else matches | `.ai/rules/code.md`, `.ai/rules/ui.md` |

## Read more

- [assistant-installer/README.md](assistant-installer/README.md) for the AI-assisted install path
- [MANUAL.md](MANUAL.md) for the long-form operating guide
- [CONTRIBUTING.md](CONTRIBUTING.md) for branch, commit, and validation rules
