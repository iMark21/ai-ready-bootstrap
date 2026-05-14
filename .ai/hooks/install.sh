#!/usr/bin/env bash
# .ai/hooks/install.sh
#
# Symlinks the hooks in this folder into .git/hooks/ so they fire from Git.
# Idempotent: running twice does not duplicate links.
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

echo "[install.sh] done."
