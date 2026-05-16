#!/usr/bin/env bash
# .ai/hooks/config.sh
#
# Per-project configuration for sdd-harness hooks.
# By default, every tracked non-documentation path is treated as implementation
# surface. This makes the gate work across iOS, web, backend, monorepos, and
# unusual layouts without stack-specific setup. Narrow the include/exclude
# globs only when your repo has a known exception.
#
# Glob patterns are matched against staged file paths (relative to repo root).
# Use shell case-pattern syntax (e.g. *, apps/*, Sources/*, docs/*).

SH_CODE_GLOBS=(
  "*"
)

# Paths that do not count as implementation surface even though "*" includes
# them. Keep this list stack-agnostic; project-specific generated folders or
# content-only paths can be added by the consuming repo.
SH_CODE_EXCLUDE_GLOBS=(
  ".ai/*"
  ".github/*"
  ".cursor/*"
  ".gitignore"
  ".gitattributes"
  "README*"
  "CHANGELOG*"
  "LICENSE*"
  "CODE_OF_CONDUCT*"
  "CONTRIBUTING*"
  "SECURITY*"
  "docs/*"
  "doc/*"
  "*.md"
  "*.txt"
  "*.rst"
  "*.adoc"
)

# Paths that always count as "spec/ADR touch" (rarely needs customization).
SH_SPEC_GLOBS=(
  ".ai/specs/*"
  ".ai/adrs/*"
)
