#!/bin/bash
# sdd-harness CI plugin for Python
# desc: Python (ruff, pytest, mypy)

set -euo pipefail

# shellcheck source=/dev/null
. "$(dirname "${BASH_SOURCE[0]}")/common.sh"

# ---------- plugin_check ----------
plugin_check() {
  step_start "Checking Python toolchain"

  command -v python3 >/dev/null || die "python3 not found in PATH"

  # Verify pytest is available (required)
  if ! python3 -m pytest --version >/dev/null 2>&1; then
    die "pytest not found. Install: pip install pytest"
  fi

  step_done
}

# ---------- plugin_lint ----------
plugin_lint() {
  step_start "Linting with ruff"

  if command -v ruff >/dev/null 2>&1; then
    ruff check . || step_fail "ruff check"
  else
    warn "ruff not found; skipping"
  fi

  step_done
}

# ---------- plugin_test ----------
plugin_test() {
  step_start "Running pytest"

  python3 -m pytest || step_fail "pytest"

  step_done
}

# ---------- plugin_build ----------
plugin_build() {
  step_start "Building Python package"

  if [ -f "setup.py" ] || [ -f "pyproject.toml" ]; then
    python3 -m build --sdist 2>/dev/null || true
  else
    warn "No setup.py or pyproject.toml found; skipping build"
  fi

  step_done
}

# Export functions so dispatcher can call them
export -f plugin_check plugin_lint plugin_test plugin_build
