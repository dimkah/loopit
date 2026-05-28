#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="${HOME}/.claude/skills"

mkdir -p "${DEST}"

install_link() {
  local name="$1"
  local target="${ROOT}/skills/${name}"
  local link="${DEST}/${name}"

  if [[ -e "${link}" && ! -L "${link}" ]]; then
    echo "Refusing to overwrite existing non-symlink: ${link}" >&2
    exit 1
  fi

  ln -sfn "${target}" "${link}"
}

install_link loopit
install_link loopitauto

echo "Installed loopit skills for Claude Code. Restart Claude Code to reload skills."
