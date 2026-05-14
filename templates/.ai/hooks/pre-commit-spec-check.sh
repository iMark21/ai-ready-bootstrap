#!/usr/bin/env bash
# .ai/hooks/pre-commit-spec-check.sh
#
# Enforces Spec-Driven Development on feature branches.
#
# Rule: any commit on a branch matching `feat/*` that adds or modifies
# code under the globs declared in `config.sh` MUST also touch at least
# one file under `.ai/specs/` or `.ai/adrs/`. Otherwise the commit is blocked.
#
# Branches `chore/*`, `docs/*`, `fix/hotfix/*` are exempted.
#
# Override (one-shot): export SH_SDD_SKIP=1
#
# Install via: ./.ai/hooks/install.sh

set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
config="$repo_root/.ai/hooks/config.sh"

if [[ ! -f "$config" ]]; then
  echo "[sdd-check] missing $config — run install.sh after editing it." >&2
  exit 1
fi

# shellcheck source=/dev/null
. "$config"

branch="$(git symbolic-ref --short HEAD 2>/dev/null || echo "detached")"

case "$branch" in
  feat/*) ;; # subject to the rule
  *) exit 0 ;;
esac

if [[ "${SH_SDD_SKIP:-0}" == "1" ]]; then
  echo "[sdd-check] skipped via SH_SDD_SKIP=1"
  exit 0
fi

staged="$(git diff --cached --name-only --diff-filter=ACMR)"

if [[ -z "$staged" ]]; then
  exit 0
fi

touches_code=0
touches_spec=0

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

while IFS= read -r path; do
  if match_globs "$path" "${SH_CODE_GLOBS[@]}"; then
    touches_code=1
  fi
  if match_globs "$path" "${SH_SPEC_GLOBS[@]}"; then
    touches_spec=1
  fi
done <<<"$staged"

if [[ "$touches_code" -eq 1 && "$touches_spec" -eq 0 ]]; then
  cat <<EOF
[sdd-check] Spec-Driven Development violation.

This feature commit changes code under one of: ${SH_CODE_GLOBS[*]}
but does not touch any file under .ai/specs/ or .ai/adrs/.

sdd-harness requires every feature change to be accompanied by a spec or
ADR update. Either:

  1. Update the relevant spec in .ai/specs/ and re-stage it, or
  2. Add a new ADR under .ai/adrs/ that justifies the change, or
  3. If this is a one-off documented exception (e.g. typo fix), retry with:
        SH_SDD_SKIP=1 git commit ...

See .ai/ROUTING.md and .ai/adrs/0008-runtime-agnostic-ai-layer.md.
EOF
  exit 1
fi

exit 0
