#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_BIN="$SCRIPT_DIR/bin/agentlayer"
BIN_DIR="${HOME}/.local/bin"
LINK_MODE="symlink"
FORCE=0

usage() {
  cat <<'EOF'
agentlayer installer

Usage:
  bash install.sh [options]

Options:
  --bin-dir PATH   Destination directory for the installed command
  --copy           Copy the binary instead of creating a symlink
  --force          Replace an existing target file if present
  --help           Show this help

Examples:
  bash install.sh
  bash install.sh --bin-dir "$HOME/bin"
  bash install.sh --copy --force
EOF
}

die() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

while [ $# -gt 0 ]; do
  case "$1" in
    --bin-dir)
      BIN_DIR="${2:-}"
      shift 2
      ;;
    --copy)
      LINK_MODE="copy"
      shift
      ;;
    --force)
      FORCE=1
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      die "Unknown argument: $1"
      ;;
  esac
done

[ -f "$SOURCE_BIN" ] || die "Missing CLI at $SOURCE_BIN"

mkdir -p "$BIN_DIR"

TARGET_BIN="$BIN_DIR/agentlayer"
if [ -e "$TARGET_BIN" ] || [ -L "$TARGET_BIN" ]; then
  [ "$FORCE" -eq 1 ] || die "Target already exists: $TARGET_BIN (use --force to replace it)"
  rm -f "$TARGET_BIN"
fi

case "$LINK_MODE" in
  symlink)
    ln -s "$SOURCE_BIN" "$TARGET_BIN"
    ;;
  copy)
    cp "$SOURCE_BIN" "$TARGET_BIN"
    chmod +x "$TARGET_BIN"
    ;;
  *)
    die "Unsupported install mode: $LINK_MODE"
    ;;
esac

printf 'Installed agentlayer at %s\n' "$TARGET_BIN"
case ":$PATH:" in
  *":$BIN_DIR:"*)
    printf 'PATH already includes %s\n' "$BIN_DIR"
    ;;
  *)
    printf 'Add this to your shell profile if needed:\n'
    printf '  export PATH="%s:$PATH"\n' "$BIN_DIR"
    ;;
esac

printf 'Try:\n'
printf '  agentlayer --help\n'
