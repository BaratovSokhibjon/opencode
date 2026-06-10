#!/usr/bin/env bash
# Install one profile of the HumbleBee AI OpenCode workflow pack into a project.
#
# Usage:
#   ./install.sh <profile> [target_dir]
#
#   <profile>     frontend | backend | infra | fullstack
#   [target_dir]  project to install into (default: current directory)
#
# Copies the profile's .opencode/, opencode.json, AGENTS.md, .env.example,
# and .ignore into the target. Existing .opencode/ is backed up; existing
# opencode.json / AGENTS.md are never clobbered.
set -e

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILES_DIR="$ROOT/profiles"
PROFILE="${1:-}"
TARGET_DIR="${2:-$(pwd)}"

available() { ls "$PROFILES_DIR" 2>/dev/null | tr '\n' ' '; }

if [ -z "$PROFILE" ]; then
  echo "Usage: ./install.sh <profile> [target_dir]"
  echo "Profiles: $(available)"
  exit 1
fi

SRC="$PROFILES_DIR/$PROFILE"
if [ ! -d "$SRC" ]; then
  echo "Error: unknown profile '$PROFILE'. Available: $(available)"
  exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: target directory does not exist: $TARGET_DIR"
  exit 1
fi

if [ "$TARGET_DIR" -ef "$ROOT" ]; then
  echo "Error: cannot install into the pack repo itself"
  exit 1
fi

# Back up an existing .opencode before replacing it.
if [ -d "$TARGET_DIR/.opencode" ]; then
  BACKUP="$TARGET_DIR/.opencode.backup.$(date +%Y%m%d%H%M%S)"
  echo "Existing .opencode found — backing up to $(basename "$BACKUP")"
  mv "$TARGET_DIR/.opencode" "$BACKUP"
fi
cp -R "$SRC/.opencode" "$TARGET_DIR/.opencode"
echo "Installed '$PROFILE' profile .opencode/ into $TARGET_DIR"

# Config and docs — never clobber.
if [ ! -f "$TARGET_DIR/opencode.json" ]; then
  cp "$SRC/opencode.json" "$TARGET_DIR/opencode.json"
  echo "Added opencode.json"
else
  echo "Existing opencode.json kept"
fi

if [ ! -f "$TARGET_DIR/AGENTS.md" ]; then
  cp "$SRC/AGENTS.md" "$TARGET_DIR/AGENTS.md"
  echo "Added AGENTS.md"
else
  echo "Existing AGENTS.md kept"
fi

[ -f "$TARGET_DIR/.env.example" ] || { cp "$SRC/.env.example" "$TARGET_DIR/.env.example"; echo "Added .env.example"; }
[ -f "$TARGET_DIR/.ignore" ]      || { cp "$SRC/.ignore" "$TARGET_DIR/.ignore"; echo "Added .ignore"; }

echo ""
echo "Profile '$PROFILE' installed."
echo "Commands: $(ls "$SRC/.opencode/commands" | sed 's/.md$//' | tr '\n' ' ')"
echo "Run 'cp .env.example .env' if you need MCP credentials, then 'opencode'."
