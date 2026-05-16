#!/bin/bash
# sdd-harness one-line installer
#
# Usage:
#   curl -sSL https://github.com/iMark21/sdd-harness/raw/main/install-single-command.sh | bash
#
# Or locally:
#   bash install-single-command.sh

set -euo pipefail

INSTALL_DIR="${HOME}/.sdd-harness"
REPO_URL="https://github.com/iMark21/sdd-harness.git"

printf '=== sdd-harness installer ===\n'
printf 'Installing to: %s\n' "$INSTALL_DIR"

if [ -d "$INSTALL_DIR/.git" ]; then
  printf '→ Updating existing checkout...\n'
  git -C "$INSTALL_DIR" fetch --tags origin
  git -C "$INSTALL_DIR" checkout main
  git -C "$INSTALL_DIR" pull --ff-only origin main
else
  printf '→ Cloning sdd-harness...\n'
  git clone "$REPO_URL" "$INSTALL_DIR"
fi

printf '→ Installing CLI...\n'
bash "$INSTALL_DIR/install.sh"

printf '\n=== Installation complete ===\n'
printf 'Run:\n'
printf '  sdd-harness init /path/to/repo --stack your-stack\n'
printf '\nOr one-command setup:\n'
printf '  bash %s/quick-start.sh user/repo --stack your-stack\n' "$INSTALL_DIR"
printf '\n'
