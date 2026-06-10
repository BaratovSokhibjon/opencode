#!/usr/bin/env bash
# Example container entrypoint — HumbleBee conventions.
#
#   - startup logic lives here, not inline in CMD
#   - the real process is started with `exec` (and `tini` when available) so it
#     becomes PID 1 and receives signals (graceful shutdown, no zombie processes)
#   - if the container starts as root (e.g. to fix mounted-volume ownership),
#     it steps down to the non-root user before exec
set -euo pipefail

# --- one-time startup tasks (migrations, config rendering, permission fixups) ---
# Example: fix ownership of a mounted data dir while still root, then drop down.
#   if [ "$(id -u)" = "0" ]; then chown -R "${USER}:${GROUP}" "${RRA_API_DATA_DIR}"; fi

run() {
  # Prefer tini as PID 1 for proper signal/zombie handling; fall back to plain exec.
  if command -v tini >/dev/null 2>&1; then
    exec tini -- "$@"
  fi
  exec "$@"
}

# If started as root, re-exec as the non-root user before running the process.
if [ "$(id -u)" = "0" ] && [ -n "${USER:-}" ] && command -v gosu >/dev/null 2>&1; then
  exec gosu "${USER}" "$0" "$@"
fi

run "$@"
