#!/bin/bash
# sdd-harness quick-start — Clone + checkout + init in one command
#
# Usage:
#   ./quick-start.sh <github-url> [--stack STACK]
#   ./quick-start.sh https://github.com/user/repo --stack python
#   ./quick-start.sh user/repo --stack swift  # shorthand

set -euo pipefail

if [ $# -lt 1 ]; then
  printf 'Usage: %s <github-url|user/repo> [--stack STACK]\n' "$0" >&2
  printf '\nExamples:\n'
  printf '  %s https://github.com/user/repo\n' "$0" >&2
  printf '  %s user/repo --stack python\n' "$0" >&2
  exit 1
fi

REPO="$1"
STACK="generic"

# Parse --stack flag
while [ $# -gt 1 ]; do
  shift
  case "$1" in
    --stack) STACK="${2:-}"; shift ;;
  esac
done

# Expand shorthand user/repo → https://github.com/user/repo.git
if ! printf '%s' "$REPO" | grep -q '^https://'; then
  REPO="https://github.com/${REPO}.git"
fi

# Extract project name from URL
PROJ_NAME=$(printf '%s' "$REPO" | sed 's|.*/||; s|\.git$||')

printf '\n=== sdd-harness quick-start ===\n'
printf 'Repository: %s\n' "$REPO"
printf 'Project:    %s\n' "$PROJ_NAME"
printf 'Stack:      %s\n' "$STACK"
printf '\n'

# Clone
printf '→ Cloning...\n'
git clone "$REPO" "$PROJ_NAME" 2>&1 | grep -E '^(Cloning|remote:|Receiving|Resolving)' | tail -3

cd "$PROJ_NAME"

# Detect and checkout develop branch if it exists
printf '→ Detecting branch...\n'
BRANCH=$(git ls-remote --heads origin develop | wc -l)
if [ "$BRANCH" -gt 0 ]; then
  git checkout develop >/dev/null 2>&1
  printf '  ✓ Checked out develop\n'
else
  printf '  ✓ Using main/master\n'
fi

# Initialize sdd-harness
printf '→ Initializing sdd-harness...\n'
sdd-harness init . --stack "$STACK" --yes >/dev/null 2>&1

# Results
printf '\n=== Done ===\n'
printf 'Location: %s\n' "$(pwd)"
printf 'Stack:    %s\n' "$STACK"
printf '\nNext:\n'
printf '  1. cd %s\n' "$PROJ_NAME"
printf '  2. cat .ai/CONTEXT.md\n'
printf '  3. bash tools/ci.sh --list\n'
printf '  4. cat .ai/ROUTING.md\n'
printf '\nReady to read .ai/BOOTSTRAP.md when you want to fill PRODUCT/BACKLOG/etc.\n'
