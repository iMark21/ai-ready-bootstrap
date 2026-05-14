# Command: `verify`

Verify that the code matches the spec and acceptance criteria.

## Usage

```
verify <story-id>
```

## Inputs

- The spec and acceptance Gherkin for `<story-id>`.
- The implementation produced by `implement`.

## Procedure

1. For each `Scenario` in the acceptance Gherkin:
   - Identify the test(s) that exercise it.
   - If no test exists, raise it as a gap and either write the test or fail the verification.
2. Run the test plan and inspect results.
3. Read the diff and confirm:
   - No layering rule violations.
   - No accidental dependency additions.
   - All new public types are documented.
   - All new logs respect the redaction policy declared in your threat model (if defined).
4. Update `../BACKLOG.md`: status → `done` if all scenarios are covered and passing.
5. Note remaining tech debt or non-blocking issues in `../CONTEXT.md`.

## Done criteria

- Every acceptance scenario maps to at least one automated test (or a documented manual test where the platform requires it, e.g. hardware-dependent flows).
- Tests are green.
- Diff conforms to project rules.
