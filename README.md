# sdd-harness

> **v1.0.0-alpha** — Framework rewrite. Repo renamed from `agentlayer` v0.5.0. Core `.ai/` layer ported and dogfooded; CLI rewritten end-to-end.

A runtime-agnostic **Spec-Driven Development harness** that any AI can operate. Drop it into a repo and the team — humans and AIs alike — follow the same disciplined loop: **spec first, code second, verify against spec**.

## Status

v1.0.0-alpha ships the framework core (`.ai/` layer + 5-line bootloaders) and a rewritten CLI that lays it down in any target repository. Templates live under `templates/` and are copied verbatim with placeholder substitution.

If you arrived from `iMark21/agentlayer` looking for the v0.5.0 `agent-explore → plan → code → verify` flow: that has been replaced. See [CHANGELOG.md](CHANGELOG.md) for the rupture rationale and migration guidance.

## Demo — installing into a real Android repo

The result of this walkthrough lives on a public branch of a real Android project (Marvel API client, last commit 2021, no prior AI layer):

> [`iMark21/marvel-android` — `feat/marvel-login`](https://github.com/iMark21/marvel-android/tree/feat/marvel-login) — [commit](https://github.com/iMark21/marvel-android/commit/95d194c)

### 1. Install in a clean repo

```bash
$ cd marvel-android        # last commit Oct 2021, no AI files
$ sdd-harness init . --yes

Fresh repo detected. Routing to 'install'.
Installing sdd-harness 1.0.0-alpha into /Users/.../marvel-android
  Project name: marvel-android
  Runtimes: claude,codex
[install.sh] linked pre-commit -> .../.ai/hooks/pre-commit-spec-check.sh
[install.sh] linked post-commit -> .../.ai/hooks/post-edit-trace.sh
[install.sh] done.

Done. Next steps:
  1. Edit .ai/PRODUCT.md and .ai/BACKLOG.md for your project.
  2. Customize .ai/hooks/config.sh to match your stack's code paths.
  3. Read .ai/ROUTING.md (it tells any AI how to operate the project).
```

`sdd-harness init` lays down `.ai/` (commands, hooks, ADRs, agents, notes, specs), root bootloaders (`CLAUDE.md`, `AGENTS.md`), and the SDD pre-commit hook.

A handful of files ship as **empty templates** waiting for your project's content: `.ai/PRODUCT.md`, `.ai/BACKLOG.md`, `.ai/CONTEXT.md`, `.ai/specs/PRD.md`, `.ai/specs/glossary.md`. You have the same two paths as for any other authoring step:

**a) By hand.** Open them in your editor and fill them in — see the [concrete examples above](#concrete-example-after-install) for the shape.

**b) Ask your AI to bootstrap them.** Paste this into your AI runtime:

> Read `.ai/ROUTING.md` first, then bootstrap the project templates from what you can infer about this repository (README, source structure, dependencies, recent commits): fill `.ai/PRODUCT.md` (tagline, audience, non-goals), `.ai/BACKLOG.md` with 3–5 candidate stories using a short uppercase project prefix, and `.ai/CONTEXT.md` (current phase F0, active branch, any decisions already taken). Keep entries short — the SDD loop will refine them. Ask me before guessing anything the repo doesn't make obvious.

Whichever path you choose, you're ready to start the first feature once `PRODUCT.md` and at least one row of `BACKLOG.md` are filled.

### 2. Start a feature

```bash
$ git checkout -b feat/marvel-login
```

### 3. Try to commit code without a spec — the hook refuses

```bash
$ cat > src/LoginViewModel.kt <<'KT'
package com.imark.marvel.auth

class LoginViewModel(private val auth: AuthRepository) : ViewModel() {
  fun login(email: String, password: String): Result<Session> = auth.login(email, password)
}
KT

$ git add src/LoginViewModel.kt && git commit -m 'feat: login view-model'
```

The pre-commit hook fires and exits non-zero:

```
[sdd-check] Spec-Driven Development violation.

This feature commit changes code under one of: src/* lib/* app/* apps/* packages/* services/*
but does not touch any file under .ai/specs/ or .ai/adrs/.

sdd-harness requires every feature change to be accompanied by a spec or
ADR update. Either:

  1. Update the relevant spec in .ai/specs/ and re-stage it, or
  2. Add a new ADR under .ai/adrs/ that justifies the change, or
  3. If this is a one-off documented exception (e.g. typo fix), retry with:
        SH_SDD_SKIP=1 git commit ...

See .ai/ROUTING.md and .ai/adrs/0008-runtime-agnostic-ai-layer.md.
```

### 4. Write the spec first

Two paths — pick whichever fits your flow.

**a) By hand.** Open the file in your editor:

```bash
$ cat > .ai/specs/SH-001-marvel-login.md <<'MD'
# SH-001 — Marvel login

## 1. Problem
Users see anonymous content. Favorites and last-read comics need a session
tied to a Marvel API account.

## 2. Solution
Email + password screen against the Marvel public API. Session token
encrypted in EncryptedSharedPreferences, 24h expiry.

## 3. Acceptance
- Empty email or password disables the Login button.
- HTTP 200 navigates to the comics list.
- HTTP 401 shows a clear error.
MD
```

**b) Ask your AI to draft it.** sdd-harness was designed so any AI (Claude Code, Codex, Cursor, Copilot, …) can operate the project by reading `.ai/`. Paste a prompt like this into your AI:

> Read `.ai/commands/spec.md`, then draft a spec for **SH-001 — Marvel login**: an Android login screen that authenticates against the Marvel public API, stores the session token in `EncryptedSharedPreferences` with a 24-hour expiry, navigates to the comics list on HTTP 200, and shows a clear error on HTTP 401. Save it to `.ai/specs/SH-001-marvel-login.md` and follow the section structure that `spec.md` documents (Problem, Solution, Roles, Functional requirements, Non-functional, Out of scope, Acceptance criteria). The product context lives in `.ai/PRODUCT.md` and the glossary in `.ai/specs/glossary.md` — read those first to align vocabulary.

Whichever path you choose, the spec file is what unblocks the next commit.

### 5. Commit spec and code together — passes

```bash
$ git add .ai/specs/SH-001-marvel-login.md src/LoginViewModel.kt
$ git commit -m 'feat: login spec + view-model'
[feat/marvel-login 95d194c] feat: login spec + view-model
 2 files changed, 19 insertions(+)
 create mode 100644 .ai/specs/SH-001-marvel-login.md
 create mode 100644 src/LoginViewModel.kt
```

The spec lands with the code in the same commit. From this point on, every subsequent feature on `feat/*` branches will go through the same gate. The result is at the link at the top of this section — open the spec, open the code, and verify the discipline yourself.

A short GIF of the same flow is available at [`docs/demo.gif`](docs/demo.gif) for those who prefer to watch.

## What sdd-harness gives you

A `.ai/` directory that is the single source of truth for any AI runtime. Files marked **canonical** ship ready and you usually leave them alone; files marked **you fill** are templates waiting for your project's content:

```
.ai/
├── ROUTING.md      — canonical: how any AI operates the project
├── PRODUCT.md      — you fill: vision and non-goals
├── CONTEXT.md      — you fill: phase, branch, decisions, risks
├── BACKLOG.md      — you fill: your stories (SH-NNN by default)
├── README.md       — canonical: entrypoint map
├── adrs/           — ships ADR 0008; you add 0009+ as decisions land
├── agents/         — ships spec-writer; you add stack-specific reviewers
├── commands/       — canonical: spec, story, implement, verify, review, release, phase-close
├── hooks/          — canonical scripts; you customize config.sh code globs
├── notes/          — canonical: SDD primer, governance mirror; you add your own
└── specs/          — you fill: PRD, glossary, acceptance Gherkin, protocol contracts
```

Plus 5-line bootloaders at the repo root: [`CLAUDE.md`](CLAUDE.md), [`AGENTS.md`](AGENTS.md), and the same pattern for any future AI runtime.

### Concrete example after install

For an Android client like the one in the demo, the files you fill in might look like:

**`.ai/PRODUCT.md`**

```markdown
# marvel-android — Product Vision

## Tagline
Native Android client for browsing Marvel comics, characters, and stories
against the public Marvel API.

## Non-Goals
- No in-app comic reader in v1 (link out to marvel.com).
- No offline mode beyond image-thumbnail cache.
- No social features (favorites stay device-local).

## Audience
Marvel fans, primary; Android developers reviewing the codebase, secondary.
```

**`.ai/BACKLOG.md`**

```markdown
| ID     | Title                                            | Status | Spec                                    | Phase |
|--------|--------------------------------------------------|--------|-----------------------------------------|-------|
| MA-001 | Marvel API login (email + password)              | done   | acceptance/MA-001-login.feature         | F0    |
| MA-002 | List characters from /v1/public/characters       | todo   | TBD                                     | F0    |
| MA-003 | Character detail with comics list                | todo   | TBD                                     | F1    |
```

**`.ai/CONTEXT.md`** (after the first phase closes)

```markdown
**Phase:** F1 — character browsing
**Branch:** develop
**Last update:** 2026-06-02

## Done
- [x] MA-001: login flow against Marvel public API (see acceptance/MA-001-login.feature)

## Immediate next
- MA-002: characters list. Pagination = 20 per page, cache thumbnails 7 days.
```

**`.ai/specs/glossary.md`**

```markdown
| Term      | Definition                                                                  |
|-----------|-----------------------------------------------------------------------------|
| Hero      | A character with at least one comic appearance.                             |
| Creator   | Writer or artist credited on a comic. Disjoint from Hero in this domain.    |
| Storyline | A multi-issue narrative arc grouping Comics.                                |
```

Don't write all of this on day one — start with `PRODUCT.md` and the first row of `BACKLOG.md`, then let the SDD loop drive the rest.

## The discipline

```
spec  →  human + agent review  →  implement (TDD-light)  →  verify-against-spec  →  merge
```

Enforced by `.ai/hooks/pre-commit-spec-check.sh`: feature branches that touch code must also touch a spec or ADR. The path globs are project-configurable in [`.ai/hooks/config.sh`](.ai/hooks/config.sh).

See [`.ai/notes/spec-driven-development.md`](.ai/notes/spec-driven-development.md) for the full primer.

## Lineage

sdd-harness extracts the disciplined `.ai/` layer iterated through multiple phases in a real production codebase under non-trivial constraints (multiple transports, hardware integration, end-to-end test harness, deterministic CI). The discipline survived contact with reality — which is the bar for shipping a framework rather than a template. Domain-specific artifacts are excluded; only the generic SDD discipline is kept.

## Adopting it

```bash
# 1. Get the CLI (clone somewhere persistent)
git clone https://github.com/iMark21/sdd-harness.git ~/.sdd-harness
cd ~/.sdd-harness && bash install.sh

# 2. In your target repo
cd /path/to/your-repo
sdd-harness init
```

`sdd-harness init` auto-routes:

- **Fresh repo** → lays down `.ai/` plus root bootloaders (`CLAUDE.md`, `AGENTS.md`).
- **Repo already has AI files** → routes to `standardize`, which backs them up under `.ai-backup-<timestamp>/` and installs the new layout.

Then customize `.ai/PRODUCT.md`, `.ai/BACKLOG.md`, `.ai/CONTEXT.md` for your project. ADR 0008 (runtime-agnostic AI layer) stays as-is; add your own ADRs starting at 0009 or higher. Tune `.ai/hooks/config.sh` to match your stack's code paths.

## Roadmap

- **v1.0.0-alpha** (current) — Framework core ported and dogfooded.
- **v1.0.0-beta** — CLI rewrite: `sdd-harness init` lays down the new `.ai/` in a target repo. Plugin-based CI scaffolding per stack (Swift/Python/JS/Go).
- **v1.0.0** — Public migration: repo renamed to `iMark21/sdd-harness`, commit timestamps sanitized, CHANGELOG migration guide for v0.5.0 users.
- **v1.1.0+** — Governance mirror (auto-update `CONTEXT.md` on phase close), additional reviewer agents, optional integrations.

## License

MIT. See [LICENSE](LICENSE).

## Read more

- [`.ai/ROUTING.md`](.ai/ROUTING.md) — start here for any AI
- [`.ai/PRODUCT.md`](.ai/PRODUCT.md) — vision and non-goals
- [`.ai/notes/spec-driven-development.md`](.ai/notes/spec-driven-development.md) — SDD primer
- [`.ai/adrs/0008-runtime-agnostic-ai-layer.md`](.ai/adrs/0008-runtime-agnostic-ai-layer.md) — why `.ai/` and not `.claude/`
- [CHANGELOG.md](CHANGELOG.md) — version history
