#!/bin/bash
# sdd-harness CI plugin for Go
# desc: Go (go test, go vet, staticcheck)

set -euo pipefail

# shellcheck source=/dev/null
. "$(dirname "${BASH_SOURCE[0]}")/common.sh"

plugin_check() {
  step_start "Checking Go toolchain"

  command -v go >/dev/null || die "go not found in PATH"

  step_done
}

plugin_lint() {
  step_start "Linting with go vet"

  go vet ./... || step_fail "go vet"

  # staticcheck if available
  if command -v staticcheck >/dev/null 2>&1; then
    staticcheck ./... || step_fail "staticcheck"
  else
    warn "staticcheck not found; skipping"
  fi

  step_done
}

plugin_test() {
  step_start "Running go test"

  go test ./... -v || step_fail "go test"

  step_done
}

plugin_build() {
  step_start "Building Go binaries"

  go build ./... || step_fail "go build"

  step_done
}

export -f plugin_check plugin_lint plugin_test plugin_build
