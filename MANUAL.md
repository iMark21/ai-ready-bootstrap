# AI-Ready Bootstrap Manual

## Quick start

```bash
# 1. Install the CLI
git clone https://github.com/iMark21/ai-ready-bootstrap.git
cd ai-ready-bootstrap && bash install.sh

# 2. Bootstrap your project
ai-ready install /path/to/your-repo \
  --runtimes claude,generic \
  --project-type ios

# 3. Tell your AI (example for Claude Code):
# "Read CLAUDE.md and the .ai/ layer. Ground the context with real repo knowledge."
```

Done. Your AI now has architecture, conventions, and workflow memory for that repository.

## Purpose

This tool exists for a common problem:

- many repos still have no AI-Ready layer at all
- some repos already have partial files such as `AGENTS.md`, `CLAUDE.md`, or Copilot instructions
- teams want one canonical system, but different developers use different AI runtimes

The operating model is:

1. install a canonical `.ai/` layer
2. choose one, two, or several runtimes
3. generate only the adapters required for those runtimes
4. keep Git governance and repository conventions explicit
5. if the repo already has AI files, audit first and standardize instead of blindly overwriting

## Installation modes

There are now two supported ways to use AI-Ready Bootstrap.

| Mode | Best when | Result |
| --- | --- | --- |
| AI-assisted install | you already work inside an AI with local repo access and want the files grounded from the first pass | the AI audits the repo first and writes a repo-specific `.ai/` layer |
| CLI install | you want deterministic scaffolding, repeatable shell commands, or non-interactive runs | the CLI generates the canonical frame and the repo then runs the first-pass grounding workflow |

### AI-assisted install

Use the files under [`assistant-installer/`](assistant-installer/README.md):

- [`assistant-installer/SKILL.md`](assistant-installer/SKILL.md) if the runtime supports custom skills or reusable playbooks
- [`assistant-installer/PROMPT.md`](assistant-installer/PROMPT.md) if the runtime only supports pasted prompts or custom instructions

This path is intended to create the same canonical shape as the CLI, but with grounded `.ai/context*` content from repository evidence instead of template-first placeholders.

### CLI install

Use this when you want the repo bootstrapped from the shell and you are comfortable with the generated layer being grounded immediately afterward by the first-pass context bootstrap flow.

## Installing The CLI

If you have access to the repo:

```bash
git clone git@github.com:iMark21/ai-ready-bootstrap.git
cd ai-ready-bootstrap
bash install.sh
ai-ready --help
```

The installer places `ai-ready` in `~/.local/bin` by default.

You can override that:

```bash
bash install.sh --bin-dir "$HOME/bin"
```

If you prefer not to install globally yet, run:

```bash
bin/ai-ready --help
```

If you want the installed files to be repo-specific from the start instead of template-first, prefer the AI-assisted install path above.

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
- rules by language, UI, feature, testing, analytics, and data
- agent playbooks
- deterministic skills

Immediately after generation, `.ai/context.md` starts in a pending state:

- `Context Bootstrap Status | Pending first-pass grounding`

That status is the trigger for the first-pass context bootstrap workflow.

### Runtime Adapters

Adapters are intentionally thin.

| Runtime | Adapter | Purpose |
| --- | --- | --- |
| `codex` | `AGENTS.md` | Codex entry point |
| `claude` | `CLAUDE.md` | Claude Code entry point |
| `copilot` | `.github/copilot-instructions.md` plus `.github/instructions/` | GitHub Copilot entry point |
| `cursor` | `.cursor/rules/ai-ready.mdc` | Cursor entry point |
| `generic` | `AI-READY.md` | Universal adapter for any AI |

This avoids the usual failure mode where every runtime has a different truth.

## Supported Project Types

Current automatic detection:

- `android`
- `ios`
- `web`
- `backend`
- `generic`

### iOS Support

iOS is not a fallback mode.

The bootstrap treats it as a first-class project type and detects:

- `.xcodeproj`
- `.xcworkspace`
- `Package.swift`
- `Podfile`

The generated iOS guidance is Swift and SwiftUI oriented and explicitly covers:

- screen or flow-level state ownership
- structured concurrency and `async/await`
- `@MainActor` expectations for UI-facing state owners
- SwiftUI/UIKit boundaries
- preview/sample-data expectations

If detection is not what you want, force it:

```bash
bin/ai-ready install /path/to/repo \
  --project-type ios \
  --runtimes codex,claude,generic
```

## Runtime Selection

You can choose one runtime, several, or `all`.

### Single Runtime

```bash
--runtimes codex
--runtimes claude
--runtimes copilot
--runtimes cursor
--runtimes generic
```

### Multi Runtime

```bash
--runtimes codex,claude
--runtimes codex,claude,generic
--runtimes codex,claude,copilot,generic
```

### All

```bash
--runtimes all
```

This expands to:

- `codex`
- `claude`
- `copilot`
- `cursor`
- `generic`

### Universal Generic Mode

`generic` installs `AI-READY.md`.

Use it when:

- the chosen AI has no repo-native adapter format
- the team wants one common handoff file across tools
- the repo should remain usable even if the runtime choice changes later

This is the safest default when you need the setup to survive tool churn.

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
  --runtimes codex,claude,generic \
  --project-type android
```

What it does:

- detects or accepts the project type
- creates `.ai/`
- writes the canonical docs and playbooks
- writes only the runtime adapters you selected
- optionally installs Git hooks
- optionally applies local git user name and email
- prints the recommended first-pass context-bootstrap step for the selected runtimes

### 3. Standardize

Use it when the repo already has AI-related files and you want to normalize it.

Example:

```bash
bin/ai-ready standardize /path/to/repo \
  --runtimes codex,claude,copilot,generic \
  --yes
```

What it does:

- audits what is already there
- backs up known AI files under `.ai/archive/standardize-*`
- rewrites the canonical `.ai/` layer
- rewrites the selected runtime adapters
- removes unselected adapters from the active root
- preserves a backup before overwrite
- prints the recommended first-pass context-bootstrap step for the selected runtimes

## Generated Files In The Target Repo

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
- `.cursor/rules/ai-ready.mdc`
- `AI-READY.md`

## Agents, Skills, And Real Workflow

The generated `agents` and `skills` are Markdown playbooks.

They are not background services. They define which working mode the AI should use at each step.

### Generated Agents

| Agent File | Responsibility |
| --- | --- |
| `.ai/agents/proj-explore.md` | explore an unfamiliar area before planning or coding |
| `.ai/agents/proj-context-bootstrap.md` | replace the generated `.ai/context*` templates with real repository knowledge on the first pass |
| `.ai/agents/proj-feature.md` | create the file-level implementation plan for a feature |
| `.ai/agents/proj-code.md` | execute the approved plan in small steps |
| `.ai/agents/proj-verify.md` | verify acceptance criteria, run tests, and report residual risk |
| `.ai/agents/proj-fix.md` | reproduce and isolate defects before applying the smallest safe fix |
| `.ai/agents/proj-tech.md` | structure refactors and technical cleanup |
| `.ai/agents/proj-spike.md` | run a time-boxed investigation and recommend a direction |

### Generated Skills

| Skill File | Responsibility |
| --- | --- |
| `.ai/skills/context-bootstrap.md` | checklist for grounding `.ai/context*` in the real repository immediately after install |
| `.ai/skills/context-refresh.md` | refresh architecture, dependencies, features, and recent changes |
| `.ai/skills/feature-scaffold.md` | create the minimum feature scaffold in the repository style |
| `.ai/skills/migration-audit.md` | estimate and structure a migration before execution |

### First-Pass Context Bootstrap Workflow

This is the first workflow the runtime should execute if `Context Bootstrap Status` is still pending.

| Step | Agent / File | Result |
| --- | --- | --- |
| 1 | runtime adapter such as `AGENTS.md`, `CLAUDE.md`, or `AI-READY.md` | the AI is redirected into `.ai/` |
| 2 | `.ai/context.md` | pending bootstrap status is detected |
| 3 | `.ai/agents/proj-context-bootstrap.md` | real architecture, dependencies, features, and repo workflow are gathered from evidence |
| 4 | `.ai/skills/context-bootstrap.md` | consistent checklist is applied to the first pass |
| 5 | `.ai/context.md` and `.ai/context/recent-changes.md` | bootstrap status is changed from pending to grounded and the pass is recorded |

This first pass should update documentation, not product code, unless the user explicitly asks for code changes too.

### Real Feature Workflow

| Step | Agent / File | Result |
| --- | --- | --- |
| 1 | runtime adapter such as `AGENTS.md`, `CLAUDE.md`, or `AI-READY.md` | the AI is redirected into `.ai/` |
| 2 | `.ai/agents/proj-context-bootstrap.md` if bootstrap is still pending | generated templates are grounded in the real repo |
| 3 | `.ai/agents/proj-explore.md` | relevant files, architecture pattern, and risks are identified |
| 4 | `.ai/agents/proj-feature.md` | the implementation plan is created |
| 5 | `.ai/agents/proj-code.md` | the code is written |
| 6 | `.ai/agents/proj-verify.md` and `.ai/rules/testing.md` | tests and checks are run |
| 7 | `.ai/skills/context-refresh.md` and `.ai/context/recent-changes.md` | the repo memory is updated |

### Real Bug Workflow

| Step | Agent / File | Result |
| --- | --- | --- |
| 1 | `.ai/agents/proj-fix.md` | reproduction and root-cause framing |
| 2 | `.ai/agents/proj-code.md` | smallest safe code change |
| 3 | `.ai/agents/proj-verify.md` | regression and risk check |
| 4 | `.ai/context/recent-changes.md` | bug and constraint memory recorded |

### Real Refactor Or Migration Workflow

| Step | Agent / File | Result |
| --- | --- | --- |
| 1 | `.ai/agents/proj-spike.md` or `.ai/skills/migration-audit.md` | options, effort, and risk |
| 2 | `.ai/agents/proj-tech.md` | sequence and safety net |
| 3 | `.ai/agents/proj-code.md` | incremental refactor or migration |
| 4 | `.ai/agents/proj-verify.md` | regression validation |

### Practical Interpretation

If the runtime supports sub-agents, these phases can be split.

If it does not, the same runtime still follows the same sequence:

- understand the area
- ground the generated AI context in the real repo when needed
- plan
- code
- verify
- update memory

That is the intended operating workflow after bootstrap.

## Operating Modes For Teams

### Mode A: Read First, Then Apply

Use this when a teammate wants to review the plan before any files are generated.

1. run `audit`
2. share the report plus this manual
3. choose one or more runtimes
4. run `install` or `standardize`

### Mode B: Execute Directly

Use this when the repo clearly needs an AI-Ready layer now.

1. choose runtimes
2. run `install` or `standardize`
3. commit the generated layer
4. let the teammate refine the placeholders with real repo knowledge

## Android Example

```bash
bin/ai-ready install ~/Developer/android-repo \
  --runtimes codex,claude,generic \
  --project-type android \
  --git-name "Your Name" \
  --git-email "you@example.com" \
  --apply-git-config
```

## iOS Example

```bash
bin/ai-ready install ~/Developer/ios-repo \
  --runtimes codex,claude,generic \
  --project-type ios \
  --git-name "Your Name" \
  --git-email "you@example.com" \
  --apply-git-config
```

## Generic Any-AI Example

```bash
bin/ai-ready install ~/Developer/tech-repo \
  --runtimes generic \
  --project-type generic
```

That gives the repository:

- a canonical `.ai/` layer
- `AI-READY.md` as a universal adapter
- documented Git workflow
- a handoff path that does not depend on a single AI vendor

## What To Ask The AI After Install

If the repository still has placeholder text under `.ai/context/`, that is expected. The next step is to make the AI read the repo and replace placeholders with real project knowledge.

### Codex Prompt

```text
Read AGENTS.md and the canonical .ai layer. Audit the repository, map the real architecture and dependencies, replace the placeholder AI context with repo-specific information, and only then propose the smallest safe implementation plan.
```

### Claude Code Prompt

```text
Read CLAUDE.md and the canonical .ai layer. Summarize the real module layout, identify missing context, update the AI-Ready docs so they match the repository, and then suggest the next safe changes.
```

### Generic AI Prompt

```text
Read AI-READY.md and .ai/README.md. Use the repository itself to infer the true architecture, dependencies, and workflows, update the placeholder AI context files, and propose a minimal-risk plan before making code changes.
```

These prompts are important when the repository had no AI system before bootstrap. The tool creates the frame; the AI still needs to ground that frame in the real codebase.

## Git Governance

This tool mirrors the same discipline used in `ai-workspace`.

### Installed Rules

- block direct commits on `main`, `develop`, and `master`
- encourage short-lived `feature/*`, `fix/*`, `chore/*`, `docs/*`, and `refactor/*` branches
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
  --runtimes generic \
  --git-name "Your Name" \
  --git-email "you@example.com" \
  --apply-git-config
```

## CI

GitHub Actions validates:

- shell syntax for `bin/ai-ready`
- Android fresh-install smoke tests
- iOS fresh-install smoke tests
- standardize-mode smoke tests including `AI-READY.md`

## Practical Recommendation

If you do not know yet which AI will own the repo, install at least:

```bash
--runtimes generic
```

If the team already knows it will use Codex or Claude, prefer:

```bash
--runtimes codex,claude,generic
```

That gives you:

- first-class adapters for the chosen tools
- a universal fallback adapter for any other AI
- a single `.ai/` canon that survives runtime changes

## The core idea

The system is runtime-agnostic. AI-Ready works on any tech project if you define these five things well:

1. Product context and architecture
2. Precise rules by file type or module
3. A decision framework for common changes
4. Specialized agents or flows by task type
5. Useful memory of what has already been done

The stack, the language, and the AI runtime can all change. These five pieces are what makes a repository legible to any assistant from the first session.
