# {{PROJECT_NAME}} — Bootstrap

`sdd-harness init` filled everything it could determine mechanically
(project name, story prefix, date, current branch). The files below still
need **judgment** — they describe *why* this project exists and what its
vocabulary is, which a script cannot infer:

- `.ai/PRODUCT.md` — vision, audience, non-goals
- `.ai/BACKLOG.md` — the real stories (a placeholder first row is there)
- `.ai/CONTEXT.md` — what is actually done / next / decided / at risk
- `.ai/specs/glossary.md` — domain vocabulary
- `.ai/specs/PRD.md` — first-pass problem statement and solution

Two ways to fill them.

## a) By hand

Open each file and write it. They are short by design — see the comments and
the existing structure in each template.

## b) Ask your AI (recommended for a repo you did not write)

sdd-harness is runtime-agnostic: any AI that can read this repo (Claude Code,
Codex, Cursor, Copilot, Gemini, …) can do this. Paste this prompt:

> Read `.ai/ROUTING.md` first, then bootstrap this project's judgment-layer
> files from what you can infer about THIS repository — read the README,
> the source tree, the build/manifest files, and recent git history; do not
> invent. Fill:
>
> - `.ai/PRODUCT.md`: tagline, audience, non-goals, and an "architecture as
>   observed" section describing the real layering you find in the code.
> - `.ai/BACKLOG.md`: replace the placeholder with 3–8 real stories. If the
>   README has a TODO / roadmap / checklist, migrate those into rows using
>   the project's story prefix. Mark anything already implemented as `done`.
> - `.ai/CONTEXT.md`: set the current phase, confirm the branch, and list
>   what is already done vs. the immediate next thing, based on git history.
> - `.ai/specs/glossary.md`: the domain terms you encounter in the code.
>
> Keep every entry short — the SDD loop will refine them. Ask me before
> guessing anything the repo does not make obvious. When done, summarize
> what you wrote and which story you would pick up first.

## After bootstrap

Delete this file (`rm .ai/BOOTSTRAP.md`) — it has served its purpose. From
here, every feature on a `feat/*` or `feature/*` branch goes through the SDD loop
(`spec → story → implement → verify → review`) and the pre-commit hook
enforces spec-first. Read `.ai/ROUTING.md` for the full flow.
