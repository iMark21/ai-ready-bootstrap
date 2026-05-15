# SH-F4-110 — Install completeness

> Version: 1.0. Supersedes the deterministic slice of SH-F4-102 / -103 / -106.
> Story in `../BACKLOG.md`. Driven by the `iMark21/marvel-android` adoption.

## 1. Problem

`sdd-harness init` copies templates and substitutes three placeholders
(`{{PROJECT_NAME}}`, `{{STORY_PREFIX}}`, `{{TODAY}}`), then prints "edit these
files". The marvel-android adoption proved two failures of this:

1. **Silent mis-gate.** The repo's code lives under `Marvel/app/...`; the
   default `SH_CODE_GLOBS` (`app/*`, `src/*`) matched nothing. The SDD
   pre-commit hook would have passed code-only commits silently. A human only
   caught it because the AI doing the adoption tuned `config.sh` by hand.
2. **Out-of-band bootstrap.** The valuable work — filling PRODUCT/CONTEXT/
   BACKLOG from the repo — happened because an AI read the codebase. A user
   running only the CLI gets empty templates and a prose "next steps" line.

## 2. Solution (high level)

Make `init` finish the deterministic work and hand off the judgment work
explicitly. Zero new dependencies; nothing shells out to an AI (ADR-0008).

1. **Glob sanity dry-run.** After installing the hook, source the freshly
   written `.ai/hooks/config.sh`, list tracked files (`git ls-files`), and
   test them against `SH_CODE_GLOBS`. If **zero** tracked files match, emit a
   prominent warning that lists the repo's top-level directories so the user
   knows what to add to `config.sh`.
2. **Git-seeded CONTEXT.** Add a `{{GIT_BRANCH}}` placeholder to
   `templates/.ai/CONTEXT.md` and substitute the repo's current branch, so
   the mirror's "Branch:" line is true on day one instead of a hardcoded
   `develop`.
3. **Bootstrap handoff file.** Write `.ai/BOOTSTRAP.md` containing the precise
   prompt that fills the judgment-layer templates (vision, non-goals,
   backlog, glossary) from the repo. Point at it from the post-install
   message so it is not lost in scrollback.

## 3. Roles

- **Adopter** (human): runs `sdd-harness init`, reads the warning, tunes
  `config.sh`, pastes `BOOTSTRAP.md` into their AI or fills by hand.
- **AI runtime**: consumes `.ai/BOOTSTRAP.md` exactly as it would the README
  prompt.

## 4. Functional requirements

- **FR-1** Glob check runs only when `INSTALL_HOOK=1` and not in `--dry-run`.
- **FR-2** "Zero match" is computed against `git ls-files` using the same
  case-glob matching the hook uses, sourcing the repo's own `config.sh`.
- **FR-3** On zero match, the warning lists up to 10 top-level entries of the
  repo (excluding `.git`, `.ai`, dotfiles) and names the exact file to edit
  (`.ai/hooks/config.sh`, `SH_CODE_GLOBS`). Exit code stays 0 (warning, not
  failure).
- **FR-4** When at least one tracked file matches, no warning is printed.
- **FR-5** `{{GIT_BRANCH}}` in any template is replaced with
  `git rev-parse --abbrev-ref HEAD` (fallback `develop` if not a git repo /
  detached).
- **FR-6** `.ai/BOOTSTRAP.md` is written on every fresh install (and after
  `standardize`), is overwrite-safe under `--force`, and is skipped in
  `--dry-run` (announced instead).
- **FR-7** The post-install "Next steps" message references
  `.ai/BOOTSTRAP.md` as step 1.

## 5. Non-functional requirements

- Zero dependencies (bash + git only). No AI invocation.
- The glob matcher reuses the same `case`-pattern semantics as
  `pre-commit-spec-check.sh` so the dry-run cannot disagree with the real
  hook.
- `--dry-run` remains side-effect free.

## 6. Out of scope

- Stack detection from manifests (SH-F4-104) — heuristic, separate story.
- README `## TODO` → BACKLOG migration (SH-F4-105) — heuristic, separate.
- README value-first rebalance (SH-F4-107) — docs, separate.
- Auto-tuning `config.sh` (only warns; the user decides the globs).

## 7. Contracts

- `.ai/hooks/config.sh` exports `SH_CODE_GLOBS` (array). The dry-run sources
  it; if the file is absent the check is skipped with a note.
- `templates/.ai/CONTEXT.md` gains `{{GIT_BRANCH}}` on the `Branch:` line.

## 8. Acceptance

See [`acceptance/SH-F4-110-install-completeness.feature`](acceptance/SH-F4-110-install-completeness.feature).
