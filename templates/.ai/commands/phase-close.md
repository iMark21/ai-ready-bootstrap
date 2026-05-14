# Command: `phase-close`

Close the current phase by updating `CONTEXT.md` and opening the next phase.

## Usage

```
phase-close <next-phase-id>
```

`<next-phase-id>` is the identifier of the phase that starts after this one closes (e.g. `F3`, `F4`, `v1.1`). If you are closing the final phase of a release, pass the release identifier instead (e.g. `v1.0.0`).

## Inputs

- `../CONTEXT.md` — the file you will update.
- `../BACKLOG.md` — to flip done stories to `done` and surface the next active set.
- The set of stories actually closed during the phase you are closing.
- Any decision taken during the phase that has not yet been recorded as an ADR.

## Outputs

- `../CONTEXT.md` updated in place.
- `../BACKLOG.md` status column refreshed for the affected stories.
- (If applicable) a new ADR file under `../adrs/` capturing a phase-level decision.

## Procedure

1. **Verify the phase actually closed.** Every story tagged with this phase in `BACKLOG.md` must be `done`, `parked`, or `cut`. Any `in-progress` story is a blocker — either finish it or carry it forward as an explicit decision.
2. **Update `CONTEXT.md` — Current state block.**
   - Bump `Phase:` to `<next-phase-id>`.
   - Update `Branch:` to whatever you'll open next (or `develop` if pausing).
   - Update `Last update:` to today's date.
3. **Update `CONTEXT.md` — Done block.**
   - Append a one-line bullet per story closed in this phase. Format: `[x] <SH-NNN>: <one-line outcome>`.
   - Keep total length manageable. If the section grows past ~50 lines, collapse the oldest phase into a single summary bullet.
4. **Update `CONTEXT.md` — Immediate next block.**
   - Replace with the tasks of the new phase (or "pause" if no immediate next).
5. **Update `CONTEXT.md` — Decisions taken.**
   - Add bullets for any decision the phase produced. If a decision needs more than two lines of explanation, write it as a new ADR and reference it here.
6. **Update `CONTEXT.md` — Open risks.**
   - Add new risks that emerged. Remove risks that no longer apply (don't accumulate dead entries).
7. **Update `BACKLOG.md`.** Move story statuses to `done` for everything closed; surface new stories as `in-progress` or `todo` for the new phase.
8. **Commit the governance update together with the last phase commit if not already committed.** Commit message convention: `feat: "<phase-id> — <one-line summary>"` on `develop` (this is usually the squash-merge commit).

## Done criteria

- `CONTEXT.md` `Phase:` line shows the new phase identifier.
- No `in-progress` story belongs to the just-closed phase in `BACKLOG.md`.
- The diff of `CONTEXT.md` is legible without external context (a reviewer can tell what just changed).
- If a phase-level decision was taken, a corresponding ADR exists under `../adrs/` and is linked from `CONTEXT.md`.

## Why this command exists

Phases drift silently. A "Done" checklist that nobody updated for three weeks lies about the state of the project, and an AI assistant reading it will get bad context. `phase-close` is the discipline that prevents `CONTEXT.md` from going stale. See [`../notes/governance-mirror.md`](../notes/governance-mirror.md) for the rationale.
