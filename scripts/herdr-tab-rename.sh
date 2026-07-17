#!/bin/sh
# Rename the current herdr tab to the repo/directory name on SessionStart.
# Shared by Claude Code and GitHub Copilot CLI hooks; relies only on
# HERDR_ENV/HERDR_PANE_ID and the herdr CLI, not on either tool's payload format.

set -eu

# Drain stdin (the hook payload is passed here) so the pipe never blocks.
cat >/dev/null 2>&1 || true

[ "${HERDR_ENV:-}" = "1" ] || exit 0
[ -n "${HERDR_PANE_ID:-}" ] || exit 0
command -v herdr >/dev/null 2>&1 || exit 0
command -v jq >/dev/null 2>&1 || exit 0

pane_info="$(herdr pane get "$HERDR_PANE_ID" 2>/dev/null)" || exit 0
tab_id="$(printf '%s' "$pane_info" | jq -r '.result.pane.tab_id // empty')"
cwd="$(printf '%s' "$pane_info" | jq -r '.result.pane.cwd // empty')"
[ -n "$tab_id" ] || exit 0
[ -n "$cwd" ] || exit 0

repo_root="$(git -C "$cwd" rev-parse --show-toplevel 2>/dev/null)" || repo_root=""
label="${repo_root:-$cwd}"
label="${label##*/}"

herdr tab rename "$tab_id" "$label" >/dev/null 2>&1 || true
