#!/usr/bin/env bash
# Install the HumbleBee AI OpenCode workflow pack into a project.
# Usage:
#   ./install.sh                    → install into current directory
#   ./install.sh /path/to/project   → install into a specific project

set -e

PACK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.opencode"
TARGET_DIR="${1:-$(pwd)}"

if [ ! -d "$PACK_DIR" ]; then
  echo "Error: .opencode pack not found at $PACK_DIR"
  exit 1
fi

if [ "$TARGET_DIR" = "$(pwd)" ] && [ "$(pwd)" = "$(dirname "$PACK_DIR")" ]; then
  echo "Error: cannot install into the pack repo itself"
  exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: target directory does not exist: $TARGET_DIR"
  exit 1
fi

DEST="$TARGET_DIR/.opencode"

# Back up existing .opencode if present
if [ -d "$DEST" ]; then
  BACKUP="$TARGET_DIR/.opencode.backup.$(date +%Y%m%d%H%M%S)"
  echo "Existing .opencode found — backing up to $(basename "$BACKUP")"
  mv "$DEST" "$BACKUP"
fi

cp -r "$PACK_DIR" "$DEST"
echo "Installed OpenCode workflow pack into $TARGET_DIR"

# Ship the quick-start guide if the project doesn't already have one (never clobber).
PACK_ROOT="$(dirname "$PACK_DIR")"
if [ -f "$PACK_ROOT/AGENTS.md" ] && [ ! -f "$TARGET_DIR/AGENTS.md" ]; then
  cp "$PACK_ROOT/AGENTS.md" "$TARGET_DIR/AGENTS.md"
  echo "Added AGENTS.md quick-start guide"
fi

# Write a minimal baseline opencode.json if the project has none (never clobber).
# Intentionally omits a formatter — that is language-specific and left to the project.
if [ ! -f "$TARGET_DIR/opencode.json" ]; then
  cat > "$TARGET_DIR/opencode.json" <<'JSON'
{
    "$schema": "https://opencode.ai/config.json",
    "instructions": [
        "AGENTS.md"
    ],
    "permission": {
        "read": "allow",
        "grep": "allow",
        "glob": "allow",
        "list": "allow",
        "lsp": "allow",
        "bash": "ask",
        "question": "allow",
        "todowrite": "allow",
        "webfetch": "allow",
        "skill": {
            "*": "allow"
        }
    }
}
JSON
  echo "Added baseline opencode.json (skill access + permission defaults)"
else
  echo "Existing opencode.json kept — for smooth skill loading ensure it has:"
  echo '  "permission": { "skill": { "*": "allow" } }'
fi

echo ""
echo "Available commands: /backend /frontend /architect /commit /review"
echo "                    /refactor /test /security /docker /compose"
echo "                    /github-actions /nginx /deploy /deploy-check"
echo "                    /linear /docs"
echo ""
echo "See AGENTS.md for the full quick-start guide."
