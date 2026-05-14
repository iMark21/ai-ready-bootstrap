#!/usr/bin/env bash
# .ai/hooks/config.sh
#
# Per-project configuration for sdd-harness hooks.
# Edit the globs below to match the directories where your project keeps
# feature code. The pre-commit-spec-check hook uses these to decide whether
# a commit touches "feature code" and therefore requires a spec/ADR update.
#
# Glob patterns are matched against staged file paths (relative to repo root).
# Use shell case-pattern syntax (e.g. apps/*, src/*, lib/*, packages/*).

SH_CODE_GLOBS=(
  "src/*"
  "lib/*"
  "app/*"
  "apps/*"
  "packages/*"
  "services/*"
)

# Paths that always count as "spec/ADR touch" (rarely needs customization).
SH_SPEC_GLOBS=(
  ".ai/specs/*"
  ".ai/adrs/*"
)
