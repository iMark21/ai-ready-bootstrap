#!/bin/bash
# sdd-harness CI plugin for generic repositories
# desc: Generic (bash syntax checks, no-op test/build)

set -euo pipefail

# shellcheck source=/dev/null
. "$(dirname "${BASH_SOURCE[0]}")/common.sh"

plugin_check() {
  step_start "Checking generic toolchain"

  command -v bash >/dev/null || die "bash not found in PATH"

  step_done
}

plugin_lint() {
  step_start "Checking shell script syntax"

  local found=0
  local failed=0
  local script

  while IFS= read -r script; do
    found=1
    bash -n "$script" || failed=1
  done < <(find . -path './.git' -prune -o -type f -name '*.sh' -print | sort)

  if [ "$found" -eq 0 ]; then
    warn "No shell scripts found; skipping syntax check"
  fi

  [ "$failed" -eq 0 ] || step_fail "bash syntax"
  step_done
}

plugin_test() {
  step_start "Running generic tests"

  warn "No generic test command configured; skipping"

  step_done
}

plugin_build() {
  step_start "Running generic build"

  warn "No generic build command configured; skipping"

  step_done
}

export -f plugin_check plugin_lint plugin_test plugin_build
