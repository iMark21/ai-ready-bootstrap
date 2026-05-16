#!/bin/bash
# sdd-harness bootstrap — download and init in current repo
#
# Usage:
#   curl -sSL https://github.com/iMark21/sdd-harness/raw/main/bootstrap.sh | bash -s --stack STACK
#   curl -sSL https://github.com/iMark21/sdd-harness/raw/main/bootstrap.sh | bash -s --stack python

set -euo pipefail

STACK="generic"
GITHUB_RAW="https://raw.githubusercontent.com/iMark21/sdd-harness/main"
REPO_DIR="$(pwd)"

# Parse --stack flag
while [ $# -gt 0 ]; do
  case "$1" in
    --stack) STACK="${2:-}"; shift 2 ;;
    *) shift ;;
  esac
done

printf '=== sdd-harness bootstrap ===\n'
printf 'Repository: %s\n' "$REPO_DIR"
printf 'Stack:      %s\n' "$STACK"
printf '\n'

# Check if .ai already exists
if [ -d ".ai" ]; then
  printf 'WARNING: .ai/ already exists\n'
  printf 'To reinitialize, run: rm -rf .ai tools .cursor .github CLAUDE.md AGENTS.md GEMINI.md\n'
  exit 1
fi

# Create directories
mkdir -p .ai/specs/acceptance
mkdir -p .ai/adrs
mkdir -p .ai/commands
mkdir -p .ai/agents
mkdir -p .ai/notes
mkdir -p .ai/hooks
mkdir -p tools/ci

printf '→ Downloading templates...\n'

# Download .ai files
for file in PRODUCT.md CONTEXT.md BACKLOG.md ROUTING.md README.md BOOTSTRAP.md; do
  curl -sSL "$GITHUB_RAW/templates/.ai/$file" -o ".ai/$file"
done

# Download commands
for cmd in spec.md story.md implement.md verify.md review.md release.md phase-close.md; do
  curl -sSL "$GITHUB_RAW/templates/.ai/commands/$cmd" -o ".ai/commands/$cmd"
done

# Download specs
for spec in PRD.md glossary.md; do
  curl -sSL "$GITHUB_RAW/templates/.ai/specs/$spec" -o ".ai/specs/$spec"
done

# Download ADRs
for adr in 0008-runtime-agnostic-ai-layer.md 0009-ci-stack-plugins.md; do
  curl -sSL "$GITHUB_RAW/templates/.ai/adrs/$adr" -o ".ai/adrs/$adr"
done

# Download agents
curl -sSL "$GITHUB_RAW/templates/.ai/agents/spec-writer.md" -o ".ai/agents/spec-writer.md"

# Download notes
for note in governance-mirror.md spec-driven-development.md; do
  curl -sSL "$GITHUB_RAW/templates/.ai/notes/$note" -o ".ai/notes/$note"
done

# Download hooks
for hook in pre-commit-spec-check.sh post-edit-trace.sh install.sh config.sh; do
  curl -sSL "$GITHUB_RAW/templates/.ai/hooks/$hook" -o ".ai/hooks/$hook"
  chmod +x ".ai/hooks/$hook"
done

# Download tools/ci
curl -sSL "$GITHUB_RAW/templates/tools/ci.sh" -o "tools/ci.sh"
chmod +x "tools/ci.sh"

for plugin in common.sh swift.sh python.sh js.sh go.sh; do
  curl -sSL "$GITHUB_RAW/templates/tools/ci/$plugin" -o "tools/ci/$plugin"
  chmod +x "tools/ci/$plugin"
done

# Download bootloaders
for bootloader in CLAUDE.md AGENTS.md GEMINI.md; do
  curl -sSL "$GITHUB_RAW/templates/$bootloader" -o "$bootloader"
done

printf '→ Substituting placeholders...\n'

# Get project name and branch
PROJECT_NAME=$(basename "$(pwd)")
BRANCH=$(git symbolic-ref --short -q HEAD 2>/dev/null || echo "develop")

# Substitute placeholders
STORY_PREFIX=$(printf '%s' "$PROJECT_NAME" | tr 'a-z' 'A-Z' | tr -cd 'A-Z' | cut -c1-3)
[ -z "$STORY_PREFIX" ] && STORY_PREFIX="X"
TODAY=$(date +%Y-%m-%d)

for file in .ai/PRODUCT.md .ai/CONTEXT.md .ai/BACKLOG.md .ai/BOOTSTRAP.md .ai/specs/PRD.md .ai/specs/glossary.md; do
  sed -i.bak \
    -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
    -e "s/{{STORY_PREFIX}}/$STORY_PREFIX/g" \
    -e "s/{{TODAY}}/$TODAY/g" \
    -e "s/{{GIT_BRANCH}}/$BRANCH/g" \
    -e "s/{{STACK}}/$STACK/g" \
    "$file"
  rm -f "${file}.bak"
done

printf '→ Installing hooks...\n'
cd .ai/hooks && bash install.sh && cd ../..

printf '\n=== Done ===\n'
printf 'Next steps:\n'
printf '  1. cat .ai/BOOTSTRAP.md\n'
printf '  2. bash tools/ci.sh --list\n'
printf '  3. Read .ai/ROUTING.md\n'
printf '\nAll files downloaded to: %s\n' "$REPO_DIR"
