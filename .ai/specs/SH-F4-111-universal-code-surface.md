# SH-F4-111 — Universal code surface default

> Version: 1.0. Story in `../BACKLOG.md`. Supersedes the stack-specific
> default-glob assumption discovered during SH-F4-110.

## 1. Problem

`SH_CODE_GLOBS` started as a short positive list (`src/*`, `app/*`,
`packages/*`, ...). That worked for common web/backend layouts but not for
arbitrary repositories:

- iOS apps can keep code under `MyApp/`, `Sources/`, or nested Xcode project
  folders.
- Go projects often use `cmd/`, `internal/`, and `pkg/`.
- Android and monorepos can nest code under `Marvel/app/...`,
  `clients/mobile/...`, or any project-specific module name.

A framework advertised as stack-agnostic cannot require every adopter to
discover and repair this gate before the first feature commit.

## 2. Solution

Invert the default. The installed hook treats every tracked path as
implementation surface unless the path is explicitly excluded as documentation,
AI metadata, or repository housekeeping.

The contract stays configurable:

- `SH_CODE_GLOBS` is the include list. The default is `*`.
- `SH_CODE_EXCLUDE_GLOBS` is the exclude list. The default excludes `.ai/`,
  runtime metadata, docs, and common text-only files.
- `SH_SPEC_GLOBS` still defines what counts as a spec/ADR touch.

This is stack-agnostic because it does not detect Swift, Kotlin, Go, Python, or
any other language. It enforces the SDD rule at the repository surface: feature
branches changing implementation files need a spec or ADR.

## 3. Functional requirements

- **FR-1** Fresh installs write `SH_CODE_GLOBS=("*")` in `.ai/hooks/config.sh`.
- **FR-2** Fresh installs write `SH_CODE_EXCLUDE_GLOBS` with stack-agnostic
  exclusions for `.ai/`, runtime metadata, docs, and common text documents.
- **FR-3** `pre-commit-spec-check.sh` treats a path as implementation surface
  only when it matches `SH_CODE_GLOBS` and does not match
  `SH_CODE_EXCLUDE_GLOBS`.
- **FR-4** The install glob-sanity dry-run uses the same include/exclude
  matcher as the pre-commit hook.
- **FR-5** `post-edit-trace.sh` uses the same implementation-surface matcher
  so its passive report does not disagree with the blocking hook.
- **FR-6** Branches `feat/*` and `feature/*` are both subject to the SDD gate.
- **FR-7** Nested Android, iOS, and Go layouts produce no glob-sanity warning
  and code-only feature commits are blocked.
- **FR-8** Documentation-only feature commits remain allowed by default.
- **FR-9** Repos with only excluded files still get a glob-sanity warning
  because no implementation surface exists for the hook to protect.

## 4. Non-functional requirements

- Zero dependencies: bash + git only.
- No language-specific detection or generated stack configuration.
- Existing consumers with a custom `SH_CODE_GLOBS` and no
  `SH_CODE_EXCLUDE_GLOBS` continue to work; missing exclude arrays are treated
  as empty.

## 5. Out of scope

- Auto-detecting or classifying generated files.
- Stack-specific test/build runners.
- Per-language source extension lists.

## 6. Acceptance

See
[`acceptance/SH-F4-111-universal-code-surface.feature`](acceptance/SH-F4-111-universal-code-surface.feature).
