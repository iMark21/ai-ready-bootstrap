#!/bin/bash
# sdd-harness deterministic CI dispatcher
#
# Usage:
#   ./tools/ci.sh              # run the plugin configured in .ai/CONTEXT.md
#   ./tools/ci.sh --stack STACK # override stack
#   ./tools/ci.sh --list       # list available plugins
#   ./tools/ci.sh --all        # run all configured plugins

set -euo pipefail

SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CI_DIR="$SCRIPT_DIR/ci"

# Source common helpers
[ -f "$CI_DIR/common.sh" ] || {
  printf 'ERROR: %s/common.sh not found\n' "$CI_DIR" >&2
  exit 1
}
# shellcheck source=/dev/null
. "$CI_DIR/common.sh"

# ---------- functions ----------
usage() {
  cat <<EOF
sdd-harness CI dispatcher

Usage:
  $0                    Run the configured stack plugin
  $0 --stack STACK      Override stack (swift, python, js, go)
  $0 --list             List available plugins
  $0 --all              Run all plugins sequentially

Environment:
  CI_STACK_OVERRIDE     Override file (default: tools/ci/stack)

EOF
}

# ---------- defaults ----------
STACK=""
LIST_PLUGINS=0
RUN_ALL=0

# ---------- arg parsing ----------
while [ $# -gt 0 ]; do
  case "$1" in
    --stack)      STACK="${2:-}"; shift 2 ;;
    --list)       LIST_PLUGINS=1; shift ;;
    --all)        RUN_ALL=1; shift ;;
    --help|-h)    usage; exit 0 ;;
    *)            die "Unknown option: $1 (try: $0 --help)" ;;
  esac
done

list_plugins() {
  log "Available plugins:"
  for plugin in "$CI_DIR"/*.sh; do
    [ "$plugin" = "$CI_DIR/common.sh" ] && continue
    base="$(basename "$plugin" .sh)"
    # Extract one-liner from plugin if available
    local desc
    desc=$(grep -m1 '^# desc:' "$plugin" 2>/dev/null | sed 's/^# desc: //' || echo "(no description)")
    printf '  %-10s  %s\n' "$base" "$desc"
  done
}

detect_stack() {
  # 1. Explicit --stack flag (highest priority)
  if [ -n "$STACK" ]; then
    printf '%s' "$STACK"
    return 0
  fi

  # 2. Override file
  local override_file="${CI_STACK_OVERRIDE:-tools/ci/stack}"
  if [ -f "$override_file" ]; then
    cat "$override_file" | tr -d ' \n'
    return 0
  fi

  # 3. .ai/CONTEXT.md "Stack:" line
  local context=".ai/CONTEXT.md"
  if [ -f "$context" ]; then
    grep '^**Stack:**' "$context" | sed 's/.*: //; s/ *$//' | head -1
    return 0
  fi

  die "No stack detected. Set --stack, tools/ci/stack file, or .ai/CONTEXT.md Stack: line"
}

valid_plugin() {
  [ -f "$CI_DIR/$1.sh" ]
}

run_plugin() {
  local plugin="$1"
  valid_plugin "$plugin" || die "Plugin not found: $plugin"

  log "Running $plugin plugin..."
  (
    # shellcheck source=/dev/null
    . "$CI_DIR/$plugin.sh"
    plugin_check && plugin_lint && plugin_test && plugin_build
  )
}

# ---------- dispatch ----------
if [ "$LIST_PLUGINS" -eq 1 ]; then
  list_plugins
  exit 0
fi

STACK="$(detect_stack)"
log "Detected stack: $STACK"

if [ "$RUN_ALL" -eq 1 ]; then
  local failed=0
  for plugin in "$CI_DIR"/*.sh; do
    [ "$plugin" = "$CI_DIR/common.sh" ] && continue
    base="$(basename "$plugin" .sh)"
    if run_plugin "$base"; then
      log "✓ $base plugin passed"
    else
      warn "✗ $base plugin failed"
      failed=$((failed + 1))
    fi
  done
  [ "$failed" -eq 0 ] || die "$failed plugin(s) failed"
else
  run_plugin "$STACK"
  log "✓ $STACK plugin passed"
fi
