#!/usr/bin/env bash
# Install one profile of the HumbleBee OpenCode workflow pack into the current project.
#
#   curl -fsSL https://raw.githubusercontent.com/humblebeeai/opencode/main/install.sh | bash -s -- <profile>
#
#   <profile>  frontend | backend | infra | fullstack | fastapi | nextjs | python-sdk | docs | docker
#              (default: fullstack)
#
# Fetches only the chosen profile and drops its .opencode/, opencode.json, AGENTS.md,
# .env.example, and .ignore into the current directory. Downloads to a temp dir that is
# always cleaned up — no clone and no installer artifacts are left behind.
set -euo pipefail

REPO="${OPENCODE_PACK_REPO:-humblebeeai/opencode}"
REF="${OPENCODE_PACK_REF:-main}"
PROFILE="${1:-${OPENCODE_PACK_PROFILE:-fullstack}}"
TARGET_DIR="${OPENCODE_PACK_TARGET:-$PWD}"
URL="${OPENCODE_PACK_URL:-https://codeload.github.com/${REPO}/tar.gz/${REF}}"

command -v curl >/dev/null 2>&1 || { echo "error: curl is required" >&2; exit 1; }
command -v tar  >/dev/null 2>&1 || { echo "error: tar is required"  >&2; exit 1; }

# Append a profile's env vars to an existing file under a labeled block, skipping any
# key the file already defines (so a real value in .env is never overwritten). Idempotent.
append_env() {
  local src="$1" dst="$2" profile="$3"
  local header="# --- opencode pack: ${profile} profile ---"
  grep -qF "$header" "$dst" 2>/dev/null && return 0
  local out="" line key added=0
  while IFS= read -r line || [ -n "$line" ]; do
    case "$line" in
      [A-Za-z_]*=*)
        key="${line%%=*}"
        grep -qE "^[#[:space:]]*${key}=" "$dst" 2>/dev/null && continue
        added=1 ;;
    esac
    out="${out}${line}"$'\n'
  done < "$src"
  [ "$added" -eq 1 ] || return 0
  printf '\n%s\n%s' "$header" "$out" >> "$dst"
  echo "Appended ${profile} vars to $(basename "$dst")" >&2
}

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT  # always clean up — no artifacts, even on failure

echo "Fetching OpenCode pack (${REPO}@${REF})…" >&2
curl -fsSL "$URL" | tar -xz -C "$TMP"

SRC_ROOT="$(dirname "$(find "$TMP" -maxdepth 2 -type d -name profiles | head -1)")"
SRC="$SRC_ROOT/profiles/$PROFILE"
if [ ! -d "$SRC" ]; then
  echo "error: unknown profile '$PROFILE'. Available: $(ls "$SRC_ROOT/profiles" | tr '\n' ' ')" >&2
  exit 1
fi

# Replace .opencode/, backing up any existing one.
if [ -d "$TARGET_DIR/.opencode" ]; then
  BACKUP="$TARGET_DIR/.opencode.backup.$(date +%Y%m%d%H%M%S)"
  echo "Existing .opencode found — backing up to $(basename "$BACKUP")" >&2
  mv "$TARGET_DIR/.opencode" "$BACKUP"
fi
cp -R "$SRC/.opencode" "$TARGET_DIR/.opencode"

# Config and docs — never clobber what the project already has.
[ -f "$TARGET_DIR/opencode.json" ] || cp "$SRC/opencode.json" "$TARGET_DIR/opencode.json"
[ -f "$TARGET_DIR/AGENTS.md" ]     || cp "$SRC/AGENTS.md"     "$TARGET_DIR/AGENTS.md"
[ -f "$TARGET_DIR/.ignore" ]       || cp "$SRC/.ignore"       "$TARGET_DIR/.ignore"

# .env.example — copy if absent; otherwise append this profile's vars (missing keys only).
if [ -f "$TARGET_DIR/.env.example" ]; then
  append_env "$SRC/.env.example" "$TARGET_DIR/.env.example" "$PROFILE"
else
  cp "$SRC/.env.example" "$TARGET_DIR/.env.example"
fi
# .env — only if it already exists: add missing keys as blank placeholders, never overwrite values.
[ -f "$TARGET_DIR/.env" ] && append_env "$SRC/.env.example" "$TARGET_DIR/.env" "$PROFILE"

echo "Installed '$PROFILE' profile into $TARGET_DIR" >&2
echo "Commands: $(ls "$SRC/.opencode/commands" | sed 's/\.md$//' | tr '\n' ' ')" >&2
echo "Next: run 'opencode' here (copy .env.example to .env if you enable credentialed MCPs)." >&2
