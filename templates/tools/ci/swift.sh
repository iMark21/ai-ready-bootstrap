#!/bin/bash
# sdd-harness CI plugin for Swift/iOS
# desc: Swift (XcodeGen, xcodebuild, swift test)

set -euo pipefail

# shellcheck source=/dev/null
. "$(dirname "${BASH_SOURCE[0]}")/common.sh"

plugin_check() {
  step_start "Checking Swift toolchain"

  command -v swift >/dev/null || die "swift not found in PATH"
  command -v xcodebuild >/dev/null || die "xcodebuild not found (Xcode not installed?)"

  step_done
}

plugin_lint() {
  step_start "Linting Swift code"

  # swiftlint if available, otherwise skip
  if command -v swiftlint >/dev/null 2>&1; then
    swiftlint || step_fail "swiftlint"
  else
    warn "swiftlint not found; skipping"
  fi

  step_done
}

plugin_test() {
  step_start "Running Swift tests"

  if [ -f "Package.swift" ]; then
    swift test || step_fail "swift test"
  else
    xcodebuild test -scheme "$(xcodebuild -list -json | grep -o '"scheme" : "[^"]*"' | head -1 | cut -d'"' -f4)" || step_fail "xcodebuild test"
  fi

  step_done
}

plugin_build() {
  step_start "Building Swift package"

  if [ -f "Package.swift" ]; then
    swift build || step_fail "swift build"
  else
    xcodebuild build || step_fail "xcodebuild build"
  fi

  step_done
}

export -f plugin_check plugin_lint plugin_test plugin_build
