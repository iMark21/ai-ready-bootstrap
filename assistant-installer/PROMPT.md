# sdd-harness — AI-assisted install

You are an AI assistant with **local read/write access** to a git repository.
Follow this workflow end to end to install sdd-harness and bootstrap it from
the repository itself. Do not skip the audit. Do not invent facts the repo
does not state — ask the human instead.

> **Precondition.** You must be able to read and write files in this repo from
> the user's machine (Claude Code, Codex, Cursor, Copilot CLI, Gemini CLI, or
> any tool with filesystem access). A cloud chat tool with no repo access
> cannot run this — tell the user to use a tool that can, or the manual path
> in the sdd-harness README.

## Step 0 — Confirm the target

State the repository you are operating on (its path and `git remote -v` if
any). Confirm it is a git repository (`git rev-parse --show-toplevel`). If it
is not, stop and ask the user.

## Step 1 — Install the harness

Assume only `git` and `bash` are available.

- If `sdd-harness` is on `PATH`: run `sdd-harness init . --yes`.
- Otherwise:
  ```bash
  git clone https://github.com/iMark21/sdd-harness.git ~/.sdd-harness
  bash ~/.sdd-harness/install.sh
  sdd-harness init . --yes
  ```

`init` lays down `.ai/`, the root bootloaders, the SDD pre-commit hook, and
writes `.ai/BOOTSTRAP.md`. **Capture its output** — in particular any
`SH_CODE_GLOBS` / `SH_CODE_EXCLUDE_GLOBS` mis-gate warning. You will act on
it in Step 4.

## Step 2 — Audit the repository (do not invent)

Read, in this order, and take notes:

1. `README*` — stated purpose, TODO / roadmap / checklist sections.
2. Top-level layout (`git ls-files | sed 's|/.*||' | sort -u`).
3. Build / manifest files for the ecosystem you find, e.g.
   `build.gradle*`, `package.json`, `pyproject.toml`, `Cargo.toml`,
   `go.mod`, `Package.swift`, `pom.xml`, `composer.json`, `Gemfile`.
4. Source tree — the actual layering (entry points, domain vs. data vs. UI,
   DI, networking).
5. `git log --oneline -20` — what shipped recently, what the last commit
   message implies is unfinished.
6. Test directories — what is and is not covered.

If the repo does not make something clear, **ask the user**; never fabricate
vision, scope, or domain terms.

## Step 3 — Fill the judgment-layer files from the audit

Write these from what you actually found (mirror `.ai/BOOTSTRAP.md`):

- **`.ai/PRODUCT.md`** — tagline, audience, non-goals, and an
  "architecture as observed" section describing the real layering.
- **`.ai/BACKLOG.md`** — replace the placeholder with 3–8 real stories. If
  the README has a TODO / roadmap / checklist, migrate each item into a row
  using a short uppercase project prefix. Mark anything already implemented
  as `done`.
- **`.ai/CONTEXT.md`** — current phase (start at F0), confirm the branch,
  list what is already done vs. the immediate next thing, from git history.
- **`.ai/specs/glossary.md`** — the domain terms you encountered in the code.

Keep every entry short — the SDD loop refines them.

## Step 4 — Confirm the SDD hook actually fires

The default hook surface protects every tracked non-documentation path, so most
repos need no tuning. If Step 1's output included the
`SH_CODE_GLOBS` / `SH_CODE_EXCLUDE_GLOBS` mis-gate warning:

1. Edit `.ai/hooks/config.sh` so `SH_CODE_GLOBS` and
   `SH_CODE_EXCLUDE_GLOBS` leave at least one real implementation path
   protected.
2. Re-run `./.ai/hooks/install.sh`.
3. Verify: a hypothetical `feat/*` or `feature/*` commit touching
   implementation without a spec would now be blocked. If unsure, state the
   matched include glob and any relevant exclude glob.

## Step 5 — Finalize (do not start coding)

1. Delete `.ai/BOOTSTRAP.md` — it has served its purpose.
2. Summarize: what you wrote into each file, and the one fact (if any) you
   had to ask the user about.
3. Propose the **first story** you would pick up and why — but do **not**
   implement it. The next step is the human running the SDD loop
   (`spec → story → implement → verify → review`); read `.ai/ROUTING.md`
   for that flow.

## Guardrails

- English for all `.ai/` artifacts (project convention).
- Never `SH_SDD_SKIP=1` a commit unless the user explicitly asks.
- Do not push, open PRs, or create branches unless the user asks.
- Prefer short, true entries over long, speculative ones.
