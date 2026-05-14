#!/usr/bin/env bash
# .ai/hooks/install.sh
#
# Symlinks the hooks in this folder into .git/hooks/ so they fire from Git.
# Idempotent: running twice does not duplicate links.
#
# If core.hooksPath is configured to a directory other than the repo's
# .git/hooks/ (commonly a globally-installed shared hooks dir), Git will
# IGNORE the symlinks created here. The script warns about that case and
# offers the one-line fix.
#
# Usage:
#   ./.ai/hooks/install.sh

set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
hooks_src="$repo_root/.ai/hooks"
hooks_dst="$repo_root/.git/hooks"

mkdir -p "$hooks_dst"

link_hook() {
  local source_name="$1"
  local target_name="$2"
  local source_path="$hooks_src/$source_name"
  local target_path="$hooks_dst/$target_name"

  if [[ ! -f "$source_path" ]]; then
    echo "[install.sh] missing source: $source_path" >&2
    return 1
  fi

  chmod +x "$source_path"
  ln -sf "$source_path" "$target_path"
  echo "[install.sh] linked $target_name -> $source_path"
}

link_hook "pre-commit-spec-check.sh" "pre-commit"
link_hook "post-edit-trace.sh"      "post-commit"

# Detect a redirected hooksPath that would silently disable the hooks we just linked.
configured_path="$(git config --get core.hooksPath 2>/dev/null || true)"
if [[ -n "$configured_path" ]]; then
  # Normalize both sides for comparison.
  if [[ "$configured_path" != ".git/hooks" && "$configured_path" != "$hooks_dst" ]]; then
    cat >&2 <<EOF
[install.sh] WARNING: git core.hooksPath is set to:
    $configured_path
That means Git will look there for hooks, not in $hooks_dst, and the
sdd-harness SDD pre-commit hook installed just now WILL NOT fire.

Fix (local to this repo only):
    git config core.hooksPath .git/hooks

Or, if you want sdd-harness to share the configured hooks directory,
re-run installation against that directory instead.
EOF
  fi
fi

echo "[install.sh] done."
