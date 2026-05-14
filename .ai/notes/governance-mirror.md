# Note: Governance mirror

> A distilled mini-tutorial. Not a transcript. Read once, internalize, never re-read until you need to teach it.

## The one-sentence definition

`CONTEXT.md` is the project's **mirror**: it reflects the live state of the work. Every phase close updates it; between phase closes it stays read-only as far as state is concerned.

## Why it matters

Specs (`PRD.md`, `BACKLOG.md`, `adrs/`) describe what *should* be. Code is what *is*. **`CONTEXT.md` is the bridge between them** — what has actually shipped, what's mid-flight, what blocked. Without it, every new contributor (human or AI) has to reconstruct the state by grepping git history, which is slow and unreliable.

The lineage that produced sdd-harness shipped through multiple phases over several weeks. The discipline that kept the project legible end-to-end was *not* the test suite or the ADRs — those exist in many projects that still feel chaotic. It was the habit of closing every phase by updating `CONTEXT.md` so a fresh reader could land on it and know where they were.

## The five required sections

`CONTEXT.md` has a fixed shape. The [`phase-close`](../commands/phase-close.md) command walks through each section in order:

1. **Current state** — `Phase:`, `Branch:`, `Last update:`. Three lines max. The header of the mirror.
2. **Done** — bullet list of what shipped, latest first within the active phase. One line per story or per significant chunk. Older phases collapse into one-line summaries.
3. **Immediate next** — what the next contributor (you, in a week, or someone else) should pick up.
4. **Decisions taken** — bullets summarizing decisions made during the active phase. Anything that needs more than two lines gets an ADR; the bullet just references the ADR.
5. **Open risks** — table or list of risks that are still live. Risks that materialized or no longer apply are removed (not crossed out).

## What this is not

- **Not a changelog.** Changelogs document releases for consumers. The mirror documents *internal state* for contributors.
- **Not a project journal.** The mirror is current state, not history. If you want history, read `git log` or the CHANGELOG.
- **Not a backlog.** That lives in `BACKLOG.md`. The mirror references the backlog, doesn't duplicate it.

## When to update

- **Always at phase close.** Run `phase-close` and follow the procedure.
- **Sometimes mid-phase**: only the `Current state — Last update:` line and the `Done` block, when a non-trivial chunk lands. Avoid updating `Decisions taken` and `Open risks` mid-phase — those are phase-close concerns.
- **Never as a substitute for an ADR.** A decision important enough to land in `Decisions taken` for more than a sentence is important enough to be an ADR.

## Why a mirror and not auto-generated state

We considered auto-generating `CONTEXT.md` from git history + backlog status. Rejected for two reasons:

1. **Auto-generated state has no intent.** A bullet that says "merged commit a3f2b1" is information, but a bullet that says "SH-001 done; the critical flow is verified end-to-end against the test harness" is *context*. Humans write context; machines write information.
2. **Drift detection is the whole point.** If a human has to update the mirror at phase close, they notice when reality and intent diverged. Auto-generation hides the divergence.

## How an AI assistant should use the mirror

When opening a session, an AI reads `CONTEXT.md` *before* `BACKLOG.md` — the mirror tells it where the project is right now, the backlog tells it what's still pending. Reading them in that order avoids the trap of working on a story that's already in flight or already abandoned.

## Further reading

- [`../commands/phase-close.md`](../commands/phase-close.md) — the procedure that keeps the mirror current.
- ADR 0008 — runtime-agnostic AI layer (the broader principle: a small set of well-named files beats a sprawling tooling stack).
