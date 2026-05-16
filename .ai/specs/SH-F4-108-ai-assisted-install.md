# SH-F4-108 — AI-assisted install

> Version: 1.0. Story in `../BACKLOG.md`. Codifies the manual cold-start that
> proved beta gate #2 on `iMark21/marvel-android`.

## 1. Problem

`sdd-harness init` (deterministic) plus `.ai/BOOTSTRAP.md` (a prompt left in
the repo) covers the user who *finds and pastes* the bootstrap prompt. It does
not cover the user who has an AI and just wants to say "install this and fill
it in for my repo" in one shot — install + audit + fill, end to end. agentlayer
v0.5.0 had a fetchable `assistant-installer/PROMPT.md` for exactly this; it was
removed in F1 and never re-created for the new layout.

## 2. Solution (high level)

A single, self-contained, fetchable prompt — `assistant-installer/PROMPT.md` —
that any AI with local repo read/write executes end to end:

1. Confirm the target repo.
2. Install the harness (CLI if present, else clone + `install.sh` + `init`).
3. **Audit** the repo without inventing: README, tree, manifests, git log,
   tests.
4. Fill the judgment-layer files (PRODUCT / BACKLOG / CONTEXT / glossary)
   from the audit.
5. If the install-time glob warning appears, tune `.ai/hooks/config.sh` so at
   least one implementation path remains protected, then re-install the hook.
6. Delete `.ai/BOOTSTRAP.md`, summarize, propose the first story.

Zero-dependency and runtime-agnostic are preserved: the prompt is plain
Markdown; the *AI* does the work, the CLI never shells out to an AI
(ADR-0008). The README gains a third install path pointing at the raw URL.

## 3. Roles

- **Adopter**: pastes one line ("fetch this URL and follow it") into their AI.
- **AI runtime**: any tool with local FS access (Claude Code, Codex, Cursor,
  Copilot, Gemini CLI, …) — the prompt is not tool-specific.

## 4. Functional requirements

- **FR-1** `assistant-installer/PROMPT.md` is fully self-contained: an AI
  needs nothing but the repo and this file (no other fetches required to
  understand the workflow).
- **FR-2** It states the precondition explicitly: the AI must have local
  read/write to the repository (cloud chat without repo access cannot run
  it; it must say so).
- **FR-3** Install step is conditional: use `sdd-harness` if on `PATH`;
  otherwise `git clone … ~/.sdd-harness && bash ~/.sdd-harness/install.sh`
  then `sdd-harness init . --yes`. Only `git` + `bash` assumed.
- **FR-4** Audit step enumerates concrete sources to read (README, top-level
  layout, build/manifest files by ecosystem, recent `git log`, test dirs)
  and forbids fabrication ("ask the human if the repo doesn't say").
- **FR-5** Fill step targets exactly the judgment-layer files and says what
  goes in each, mirroring `.ai/BOOTSTRAP.md` so the two never diverge in
  intent.
- **FR-6** Config step: if `sdd-harness init` printed the glob mis-gate
  warning, the AI must tune `.ai/hooks/config.sh` include/exclude globs and
  re-run `.ai/hooks/install.sh`, then confirm the hook now matches
  implementation surface.
- **FR-7** Closes by deleting `.ai/BOOTSTRAP.md`, summarizing what was
  written, and proposing the first story — never by starting to implement a
  feature unprompted.
- **FR-8** README "Install" gains a third option (c) with the one-paste
  fetch line and the raw URL on `develop`.

## 5. Non-functional requirements

- No dependency beyond `git` + `bash`. The CLI does not invoke an AI.
- Tool-agnostic wording (no "Claude"/"Codex"-only phrasing in the workflow
  body; examples may list runtimes).
- English artifacts (project convention).

## 6. Out of scope

- A CLI subcommand that calls an AI (rejected — breaks ADR-0008).
- Auto-deleting nothing the user did not approve beyond `BOOTSTRAP.md`
  (which the prompt explicitly created the need for).
- Network installs other than the documented `git clone`.

## 7. Contracts

- Raw URL contract: `https://raw.githubusercontent.com/iMark21/sdd-harness/develop/assistant-installer/PROMPT.md`.
- The fill targets match `.ai/BOOTSTRAP.md` (PRODUCT, BACKLOG, CONTEXT,
  glossary); if one changes, both change.

## 8. Acceptance

See [`acceptance/SH-F4-108-ai-assisted-install.feature`](acceptance/SH-F4-108-ai-assisted-install.feature).
