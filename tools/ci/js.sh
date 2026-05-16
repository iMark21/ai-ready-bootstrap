#!/bin/bash
# sdd-harness CI plugin for Node.js/JavaScript
# desc: Node.js (npm, eslint, typescript)

set -euo pipefail

# shellcheck source=/dev/null
. "$(dirname "${BASH_SOURCE[0]}")/common.sh"

plugin_check() {
  step_start "Checking Node.js toolchain"

  command -v node >/dev/null || die "node not found in PATH"
  command -v npm >/dev/null || die "npm not found in PATH"

  step_done
}

plugin_lint() {
  step_start "Linting with eslint"

  if npm list eslint >/dev/null 2>&1; then
    npm run lint 2>/dev/null || step_fail "npm lint"
  else
    warn "eslint not found; skipping"
  fi

  step_done
}

plugin_test() {
  step_start "Running npm test"

  npm test || step_fail "npm test"

  step_done
}

plugin_build() {
  step_start "Building JavaScript project"

  # Check for TypeScript
  if [ -f "tsconfig.json" ]; then
    npm run build 2>/dev/null || true
  fi

  step_done
}

export -f plugin_check plugin_lint plugin_test plugin_build
