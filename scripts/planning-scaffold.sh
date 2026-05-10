#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$ROOT_DIR/docs/templates/planning"
DEST="${1:-$ROOT_DIR/docs/planning}"

if [[ ! -d "$SRC" ]]; then
  echo "[planning-scaffold] error: missing $SRC"
  exit 1
fi

mkdir -p "$DEST"

copy_strip_template() {
  local base="$1"
  local src="$SRC/${base}.template.md"
  local out="$DEST/${base}.md"
  if [[ -f "$src" ]]; then
    cp "$src" "$out"
    echo "[planning-scaffold] wrote $out"
  fi
}

copy_strip_template "MASTER_PLAN"
copy_strip_template "IMPLEMENTATION_PLAN"
copy_strip_template "TASKS_DETAILED"
copy_strip_template "PROGRESS"

if [[ ! -f "$DEST/README.md" ]]; then
  cp "$SRC/README.md" "$DEST/README.md"
  echo "[planning-scaffold] wrote $DEST/README.md"
fi

echo "[planning-scaffold] done. Edit placeholders, then run full-project-plan prompt and merge content."
