# Command: `implement`

Execute the plan from `story` against the codebase.

## Usage

```
implement <story-id>
```

## Inputs

- The story plan (chat or `../specs/plans/<story-id>.md`).
- The spec and acceptance Gherkin.
- The architectural layout defined in your ADRs.

## Procedure

1. Re-read the acceptance Gherkin before coding. It is the contract.
2. Write **tests first** where reasonable (TDD-light):
   - Unit tests for pure business logic.
   - Integration tests for I/O adapters with mocks.
3. Implement inside-out: business logic first, then adapters, then presentation.
4. Wire dependency injection at the composition root.
5. Run the test suite locally; do not commit if anything fails.
6. Update `../CONTEXT.md` "Done" checklist if applicable.
7. Move the story to `done` in `../BACKLOG.md` only after `verify` passes.

## Constraints

- Respect the layering rules declared in your ADRs (e.g. domain must not depend on UI frameworks or transport-specific SDKs).
- Never disable transport-level security validation (TLS, cert pinning, etc.) without an explicit ADR.
- Never log raw sensitive payloads (credentials, signatures, tokens, PII) — follow the redaction policy in `../specs/threat-model.md` if your project defines one.

## Done criteria

- Tests pass locally.
- New code follows the existing layering rules.
- No spec drift — if behaviour differs from spec, the spec is updated first.
