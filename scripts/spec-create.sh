#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$ROOT_DIR/docs/templates/spec-feature"
SPEC_ROOT="${SPEC_ROOT:-$ROOT_DIR/specs}"

usage() {
  echo "Usage:"
  echo "  SPEC_ROOT=path/to/specs $0 <slug> [title]"
  echo "  Example: $0 oauth-google \"Google OAuth login\""
  echo "  Example: SPEC_ROOT=api/specs $0 payment-hooks"
  exit 1
}

[[ "${1:-}" ]] || usage

RAW_SLUG="$1"
TITLE="${2:-}"

slug="$(echo "$RAW_SLUG" | tr '[:upper:]' '[:lower:]' | tr ' _' '--' | sed 's/[^a-z0-9-]//g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//')"
[[ -n "$slug" ]] || { echo "[spec-create] error: empty slug after sanitize"; exit 1; }

if [[ -z "$TITLE" ]]; then
  TITLE="$(echo "$slug" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1')"
fi

if [[ ! -d "$SRC" ]]; then
  echo "[spec-create] error: missing templates at $SRC"
  exit 1
fi

mkdir -p "$SPEC_ROOT"

max=0
shopt -s nullglob
for d in "$SPEC_ROOT"/[0-9][0-9][0-9]-*; do
  [[ -d "$d" ]] || continue
  base="$(basename "$d")"
  num="${base%%-*}"
  if [[ "$num" =~ ^[0-9]{3}$ ]]; then
    n10=$((10#$num))
    if (( n10 > max )); then max=$n10; fi
  fi
done
shopt -u nullglob

next=$((max + 1))
SPEC_ID="$(printf '%03d' "$next")"

DEST="$SPEC_ROOT/${SPEC_ID}-${slug}"
if [[ -e "$DEST" ]]; then
  echo "[spec-create] error: already exists: $DEST"
  exit 1
fi

mkdir -p "$DEST"

export CREATE_SPEC_ID="$SPEC_ID" CREATE_SLUG="$slug" CREATE_TITLE="$TITLE"
export CREATE_SRC="$SRC" CREATE_DEST="$DEST"

if command -v python3 >/dev/null 2>&1; then
  python3 <<'PY'
import os
from pathlib import Path

src = Path(os.environ["CREATE_SRC"])
dest = Path(os.environ["CREATE_DEST"])
sid = os.environ["CREATE_SPEC_ID"]
slug = os.environ["CREATE_SLUG"]
title = os.environ["CREATE_TITLE"]

for name in ["SPEC", "PLAN", "TASKS", "PROGRESS"]:
    p_in = src / f"{name}.template.md"
    if not p_in.is_file():
        continue
    text = p_in.read_text(encoding="utf-8")
    text = text.replace("{{SPEC_ID}}", sid)
    text = text.replace("{{SLUG}}", slug)
    text = text.replace("{{TITLE}}", title)
    (dest / f"{name}.md").write_text(text, encoding="utf-8")
    print(f"[spec-create] wrote {dest / (name + '.md')}")
PY
else
  echo "[spec-create] error: python3 required for safe title substitution"
  exit 1
fi

echo ""
echo "[spec-create] folder: $DEST"
echo "[spec-create] Next: run \"make spec-elicit\", paste into Cursor with your idea + this folder path."
echo "[spec-create] SPEC_ROOT=$SPEC_ROOT"
