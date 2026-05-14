# Note: Spec-Driven Development (SDD)

> A distilled mini-tutorial. Not a transcript. Read once, internalize, never re-read until you need to teach it.

## The one-sentence definition

Write the spec, get it reviewed, *then* write the code. If reality contradicts the spec, change the spec first.

## Why it matters

Software projects with multiple subsystems, contributors, and AI assistants degrade silently when code drifts from the documented design. The cost of "let's just code it and see" is high: changes ripple across modules, tests, and decisions that nobody can remember justifying. Specs let the design be debated before any code rusts in place — and let an AI assistant orient itself in seconds instead of grep-archaeology.

## What counts as a spec in this repo

- **Product spec:** `.ai/specs/PRD.md` — what we build and for whom.
- **Protocol specs:** any wire-format, API, or boundary contract under `.ai/specs/` (your project adds these as needed).
- **Threat model:** `.ai/specs/threat-model.md` — what we defend against (optional, recommended for security-sensitive projects).
- **Acceptance criteria:** `.ai/specs/acceptance/<story>.feature` — what passing looks like, in Gherkin.
- **Architecture decisions:** `.ai/adrs/NNNN-*.md` — *why* the architecture is the way it is.

A new term that appears anywhere goes to `.ai/specs/glossary.md`.

## The flow

```
spec  →  human + agent review  →  implement (TDD-light)  →  verify-against-spec  →  merge
```

- `spec`, `story`, `implement`, `verify`, `review`, `release` are the [commands](../commands/).
- The `pre-commit-spec-check.sh` [hook](../hooks/pre-commit-spec-check.sh) blocks feature commits that don't touch a spec/ADR. The intent is not bureaucracy: it forces the question "did the design change?" to be answered consciously.

## When the spec and the code disagree

You have three options, in order of preference:

1. The code is right and the spec is stale → update the spec, then commit code + spec together.
2. The spec is right and the code is wrong → fix the code; spec doesn't change.
3. Both are wrong → write an ADR explaining the new direction, update the spec, then change the code.

There is no fourth option (`#define IGNORE_SPEC`).

## How specs are reviewed

Use the [`spec-writer`](../agents/spec-writer.md) agent for the first pass; then any domain reviewers your project has declared under `.ai/agents/` (e.g. a transport reviewer, a security reviewer, a test architect). The harness ships only `spec-writer`; add others to fit your stack.

## Style rules

- RFC 2119 vocabulary: **must**, **should**, **may**.
- Every numeric value has a unit.
- Every error path has a documented behaviour.
- Every spec has an "Out of scope" section.
- Cross-spec references use Markdown relative links so they survive renames.

## When *not* to write a spec

- Typo fixes.
- README/`CONTEXT.md` housekeeping.
- Pure refactors that preserve observable behaviour. (You still want a comment in the diff if anything subtle changes.)

Exempted branches (`chore/*`, `docs/*`, `fix/hotfix/*`) skip the spec-check hook automatically.

## Why this isn't waterfall

Specs are **versioned alongside code**. They are not signed off and frozen. They breathe. The discipline is: never let the spec lie about what the code does.

## Further reading

- Joel Spolsky, *Painless Functional Specifications* (2000) — still the best primer.
- ADR 0008 in this project — runtime-agnostic AI layer.
- MADR — the lightweight ADR format we use.
