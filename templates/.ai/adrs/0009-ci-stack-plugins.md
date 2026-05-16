# ADR 0009 — Stack-plugin pattern for deterministic CI

- **Status:** Accepted; implemented in v1.0.0-beta
- **Date:** 2026-05-16
- **Phase:** F2.5

## Context

The lineage that produced sdd-harness shipped a `tools/ci.sh` that orchestrates deterministic CI on a single stack: project-generation drift checks, package tests, simulator tests, secret scanning. The script was *deterministic* (same inputs → same outputs, no flakiness) and *single-entrypoint* (one command, both local and remote CI).

sdd-harness needs to offer the same discipline — deterministic CI behind a single entrypoint — without baking in any particular stack's tooling. A Python project should not need to read iOS toolchain references; a JS project should not need to know what a simulator drift check is.

## Decision

CI scaffolding is delivered as a **plugin pattern**, not as a monolithic script:

```
tools/
├── ci.sh                  ← dispatcher, ~50 lines
└── ci/
    ├── common.sh          ← shared helpers (timing, exit codes, logging)
    ├── swift.sh           ← Swift/iOS plugin (XcodeGen + xcodebuild + swift test)
    ├── python.sh          ← Python plugin (pytest + ruff + mypy)
    ├── js.sh              ← Node/JS plugin (npm test + tsc + eslint)
    ├── go.sh              ← Go plugin (go test + go vet + staticcheck)
    └── generic.sh         ← Generic fallback (bash syntax, no-op test/build)
```

The dispatcher (`tools/ci.sh`) reads a single line from `.ai/CONTEXT.md` or an explicit `tools/ci/stack` file to learn which plugin(s) to run, then dispatches:

```
./tools/ci.sh                  # runs the plugin(s) configured for this repo
./tools/ci.sh --stack swift    # override per invocation
./tools/ci.sh --all            # run all configured plugins
```

Each plugin is a self-contained bash script that exposes the same interface:

- `plugin_check`  — run the plugin's pre-flight checks (e.g. tool versions present)
- `plugin_lint`   — run linters/formatters
- `plugin_test`   — run the test suite
- `plugin_build` — build artifacts
- Returns 0 on success, non-zero on any failure, with grep-able output.

The dispatcher exposes the same surface to the caller and the same surface to GitHub Actions / any other CI runner. The runner doesn't need to know which stack it's running.

## Consequences

- **Pro:** consumers add only the plugin(s) their stack needs. A Python-only repo carries `tools/ci/python.sh` and nothing else.
- **Pro:** new plugins (Rust, Kotlin, Elixir, …) are additive: drop in `tools/ci/rust.sh` and announce it.
- **Pro:** the dispatcher is small enough to audit end-to-end in one read.
- **Pro:** local CI = remote CI. No GitHub-Actions-specific YAML that's hard to reproduce locally.
- **Con:** consumers writing their own plugin must follow the interface (`plugin_check`/`plugin_lint`/`plugin_test`/`plugin_build`). This is documentation friction, not technical friction.
- **Con:** plugins must agree on output formatting if cross-plugin summary reports are desired. Acceptable: in v1.0.0 each plugin emits its own report; aggregated reports come in v1.1.0+.

## Rejected alternatives

- **Single monolithic `ci.sh` that auto-detects the stack.** Rejected: detection logic becomes a maintenance burden as stacks proliferate; explicit configuration is clearer.
- **GitHub Actions YAML as the source of truth.** Rejected: developers cannot reproduce CI locally; locks the harness into one CI vendor.
- **Outsource CI orchestration to `nx`, `turborepo`, or similar.** Rejected: external dependencies break sdd-harness's "zero dependencies" non-goal; those tools are also opinionated about monorepo shape.

## How to apply

This ADR documents the implemented beta pattern. When a consumer project asks for CI scaffolding:

1. Write the plugin matching their stack (e.g. `tools/ci/swift.sh` for an iOS project).
2. Wire the dispatcher to recognize the plugin.
3. Add a GitHub Actions workflow (or equivalent) that invokes `tools/ci.sh` and nothing else.
4. Add a "Done criteria" for the relevant story: `tools/ci.sh` passes locally and in CI.

## References

- The lineage `tools/ci.sh`, `tools/spec-check.sh`, `tools/portfolio-check.sh` scripts that demonstrated the deterministic-CI philosophy on a single stack before it was generalized here.
- `.ai/adrs/0008-runtime-agnostic-ai-layer.md` — same "single source of truth, runtime-agnostic" pattern applied to the AI layer.
