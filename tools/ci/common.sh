#!/bin/bash
# sdd-harness CI common helpers
#
# Shared logging and timing utilities for CI plugins.
# Source this in each plugin: . "$(dirname "${BASH_SOURCE[0]}")/common.sh"

set -euo pipefail

# ---------- logging ----------
log() {
  printf '%s\n' "$*"
}

warn() {
  printf 'WARN: %s\n' "$*" >&2
}

die() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

# ---------- timing ----------
_STEP_START=""

step_start() {
  local label="$1"
  log "→ $label..."
  _STEP_START="$(date +%s%N)"
}

step_done() {
  if [ -z "$_STEP_START" ]; then
    return
  fi
  local elapsed_ns=$(($(date +%s%N) - _STEP_START))
  local elapsed_ms=$((elapsed_ns / 1000000))
  log "  ✓ completed in ${elapsed_ms}ms"
  _STEP_START=""
}

step_fail() {
  local label="$1"
  log "  ✗ $label failed"
  _STEP_START=""
  return 1
}

# ---------- plugin interface stubs ----------
# Each plugin must override these with its own implementation.

plugin_check() {
  warn "plugin_check not implemented"
  return 1
}

plugin_lint() {
  warn "plugin_lint not implemented"
  return 1
}

plugin_test() {
  warn "plugin_test not implemented"
  return 1
}

plugin_build() {
  warn "plugin_build not implemented"
  return 1
}
