# Command: `story`

Expand a spec into a concrete implementation plan.

## Usage

```
story <story-id>
```

## Inputs

- The corresponding spec in `../specs/` (and acceptance Gherkin).
- ADRs in `../adrs/` that constrain the design.
- The current codebase state (layers, protocols, modules as defined in your architecture ADRs).

## Outputs

- A short implementation plan posted in chat or saved as `../specs/plans/<story-id>.md`:
  - Files to add or modify.
  - Order of changes.
  - Test plan (which acceptance scenarios are covered, which tests to write first).
  - Risks and unknowns.

## Procedure

1. Read the spec for `<story-id>`.
2. Read the referenced ADRs.
3. Sketch the change across your architectural layers (e.g. Presentation / Domain / Data, or whatever your ADRs define).
4. Decide test strategy in the order that makes sense for your stack: unit, integration with mocks, end-to-end.
5. List unknowns. Resolve high-impact ones with the human before implementing.

## Done criteria

- The plan fits on one screen.
- Each item is mergeable independently if possible.
- Test plan covers each acceptance scenario.
