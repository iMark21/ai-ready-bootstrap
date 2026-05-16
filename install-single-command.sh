#!/bin/bash
# sdd-harness one-line installer
#
# Usage:
#   curl -sSL https://github.com/iMark21/sdd-harness/raw/develop/install-single-command.sh | bash
#
# Or locally:
#   bash install-single-command.sh

set -euo pipefail

INSTALL_DIR="${HOME}/.sdd-harness"
GITHUB_RAW="https://raw.githubusercontent.com/iMark21/sdd-harness/develop"

printf '=== sdd-harness installer ===\n'
printf 'Installing to: %s\n' "$INSTALL_DIR"

# Create directory
mkdir -p "$INSTALL_DIR/bin"
mkdir -p "$INSTALL_DIR/templates/.ai/specs"
mkdir -p "$INSTALL_DIR/templates/tools/ci"

# Download key files
printf '→ Downloading CLI...\n'
curl -sSL "$GITHUB_RAW/bin/sdd-harness" -o "$INSTALL_DIR/bin/sdd-harness"
chmod +x "$INSTALL_DIR/bin/sdd-harness"

printf '→ Downloading quick-start...\n'
curl -sSL "$GITHUB_RAW/quick-start.sh" -o "$INSTALL_DIR/quick-start.sh"
chmod +x "$INSTALL_DIR/quick-start.sh"

printf '→ Downloading templates...\n'
# Templates
for template in PRODUCT.md CONTEXT.md BACKLOG.md ROUTING.md README.md BOOTSTRAP.md; do
  curl -sSL "$GITHUB_RAW/templates/.ai/$template" -o "$INSTALL_DIR/templates/.ai/$template" 2>/dev/null || true
done

# Specs
for spec in PRD.md glossary.md; do
  curl -sSL "$GITHUB_RAW/templates/.ai/specs/$template" -o "$INSTALL_DIR/templates/.ai/specs/$spec" 2>/dev/null || true
done

# Tools
for tool in ci.sh; do
  curl -sSL "$GITHUB_RAW/templates/tools/$tool" -o "$INSTALL_DIR/templates/tools/$tool" 2>/dev/null || true
  chmod +x "$INSTALL_DIR/templates/tools/$tool"
done

# Tools/ci plugins
for plugin in common.sh swift.sh python.sh js.sh go.sh; do
  curl -sSL "$GITHUB_RAW/templates/tools/ci/$plugin" -o "$INSTALL_DIR/templates/tools/ci/$plugin" 2>/dev/null || true
  chmod +x "$INSTALL_DIR/templates/tools/ci/$plugin"
done

# Make symlink to PATH
if [ -d "$HOME/.local/bin" ]; then
  ln -sf "$INSTALL_DIR/bin/sdd-harness" "$HOME/.local/bin/sdd-harness"
  PATH_DIR="$HOME/.local/bin"
elif [ -d "/usr/local/bin" ]; then
  sudo ln -sf "$INSTALL_DIR/bin/sdd-harness" "/usr/local/bin/sdd-harness"
  PATH_DIR="/usr/local/bin"
fi

printf '\n=== Installation complete ===\n'
printf 'Run:\n'
printf '  sdd-harness init /path/to/repo --stack python\n'
printf '\nOr one-command setup:\n'
printf '  bash %s/quick-start.sh user/repo --stack python\n' "$INSTALL_DIR"
printf '\n'
