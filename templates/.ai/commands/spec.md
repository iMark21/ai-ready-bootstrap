# Command: `spec`

Write or update a spec for a story.

## Usage

```
spec <story-id>
```

`<story-id>` is a story identifier such as `SH-001` or `SH-I02` (your project may use any prefix).

## Inputs

- The story row in [`../BACKLOG.md`](../BACKLOG.md).
- Existing related specs in [`../specs/`](../specs/).
- Open questions raised in chat or marked as `[?]` in earlier drafts.

## Outputs

- `../specs/<file-aligned-with-story>.md` (created or edited).
- If applicable, `../specs/acceptance/<story-id>-<slug>.feature` (Gherkin).
- A `## Changes since previous version` block at the top if rewriting an existing spec.

## Procedure

1. Read `../PRODUCT.md` to align with vision.
2. Read `../specs/glossary.md` to align vocabulary.
3. Read any prior spec for the same story; flag deletions explicitly.
4. Draft the spec following the structure conventions:
   - Problem statement.
   - Solution at a high level.
   - Roles involved.
   - Functional requirements.
   - Non-functional requirements.
   - Out of scope.
   - Contracts (refer to protocol specs as needed).
   - Acceptance criteria (Gherkin in `acceptance/<id>.feature`).
5. Resolve any ambiguity by **asking the human** before writing it — never invent constraints.
6. Update `../BACKLOG.md` row status to `in-progress` if applicable.

## Done criteria

- The spec is internally consistent.
- All referenced files exist.
- Acceptance Gherkin compiles mentally (a tester could write it from the file).
- No `[?]` markers left.
