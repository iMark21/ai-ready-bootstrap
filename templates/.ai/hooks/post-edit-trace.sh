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
  SH_CODE_GLOBS=("*")
  SH_CODE_EXCLUDE_GLOBS=(".ai/*" ".github/*" ".cursor/*" "README*" "CHANGELOG*" "LICENSE*" "docs/*" "doc/*" "*.md" "*.txt" "*.rst" "*.adoc")
  SH_SPEC_GLOBS=(".ai/specs/*" ".ai/adrs/*")
fi

ensure_array() {
  local name="$1"
  if ! declare -p "$name" >/dev/null 2>&1; then
    eval "$name=()"
  fi
}

match_globs() {
  local path="$1"
  shift
  local pattern
  for pattern in "$@"; do
    # shellcheck disable=SC2254
    case "$path" in
      $pattern) return 0 ;;
    esac
  done
  return 1
}

path_is_code() {
  local path="$1"
  if match_globs "$path" "${SH_CODE_EXCLUDE_GLOBS[@]}"; then
    return 1
  fi
  match_globs "$path" "${SH_CODE_GLOBS[@]}"
}

append_line() {
  local var="$1" line="$2"
  if [[ -n "${!var}" ]]; then
    printf -v "$var" '%s\n%s' "${!var}" "$line"
  else
    printf -v "$var" '%s' "$line"
  fi
}

ensure_array SH_CODE_EXCLUDE_GLOBS

last="$(git log -1 --name-only --pretty=format: HEAD)"
specs=""
code=""

while IFS= read -r path; do
  [[ -z "$path" ]] && continue
  if match_globs "$path" "${SH_SPEC_GLOBS[@]}"; then
    append_line specs "$path"
  fi
  if path_is_code "$path"; then
    append_line code "$path"
  fi
done <<<"$last"

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
