#!/usr/bin/env bash
# .ai/hooks/post-edit-trace.sh
#
# Optional informational trace: prints which spec/ADR files were touched
# by the most recent commit. Useful for daily reflection and to feed any
# LEARNING.md / journal flow.
#
# Wire this to .git/hooks/post-commit via install.sh.

set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
config="$repo_root/.ai/hooks/config.sh"

if [[ -f "$config" ]]; then
  # shellcheck source=/dev/null
  . "$config"
else
  SH_CODE_GLOBS=("src/*" "lib/*" "app/*" "apps/*" "packages/*" "services/*")
  SH_SPEC_GLOBS=(".ai/specs/*" ".ai/adrs/*")
fi

last="$(git log -1 --name-only --pretty=format: HEAD)"

spec_re="$(printf '%s|' "${SH_SPEC_GLOBS[@]}" | sed 's/\*/.*/g; s/|$//')"
code_re="$(printf '%s|' "${SH_CODE_GLOBS[@]}" | sed 's/\*/.*/g; s/|$//')"

specs=$(echo "$last" | grep -E "^($spec_re)$" || true)
code=$(echo "$last"  | grep -E "^($code_re)$" || true)

if [[ -n "$specs" || -n "$code" ]]; then
  echo "[post-edit-trace] commit $(git rev-parse --short HEAD)"
  if [[ -n "$specs" ]]; then
    echo "  specs/adrs touched:"
    echo "$specs" | sed 's/^/    /'
  fi
  if [[ -n "$code" ]]; then
    echo "  code touched:"
    echo "$code" | sed 's/^/    /'
  fi
fi
