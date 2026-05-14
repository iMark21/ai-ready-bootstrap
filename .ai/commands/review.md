# Command: `review`

Security + architecture review of the current diff.

## Usage

```
review
```

(Operates on the current Git working tree vs. `develop`.)

## Inputs

- The diff (`git diff develop...HEAD`).
- The threat model (`../specs/threat-model.md`, if your project defines one).
- ADRs that apply to the touched areas.

## Procedure

Use the review agents declared in `../agents/`. The core agent shipped with `sdd-harness` is:

1. **`spec-writer`** — does the diff drift from any spec? If so, was the spec updated first? If not, fail.

Add stack- or domain-specific reviewers as your project requires (e.g. a transport reviewer for networking-heavy projects, a security reviewer for auth flows, a test architect for test discipline). Declare each as an agent file under `../agents/`.

For each finding:

- Severity: `blocker`, `major`, `minor`, `nit`.
- Citation: file + line + (when applicable) ADR/spec reference.
- Suggested resolution.

## Done criteria

- All `blocker` and `major` items resolved before merge.
- The summary is short enough to read aloud in a stand-up.
