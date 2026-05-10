#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

errors=0
warn() { echo "[verify] WARN: $*"; }
fail() { echo "[verify] FAIL: $*"; errors=$((errors + 1)); }

require_file() {
  if [[ ! -f "$1" ]]; then
    fail "missing file: $1"
  fi
}

require_dir() {
  if [[ ! -d "$1" ]]; then
    fail "missing directory: $1"
  fi
}

echo "[verify] checking template layout under $ROOT_DIR"

require_file "$ROOT_DIR/README.md"
require_file "$ROOT_DIR/docs/USAGE.md"
require_file "$ROOT_DIR/docs/DEFINITION_OF_DONE.md"
require_file "$ROOT_DIR/.cursor/prompts/full-project-plan.md"
require_file "$ROOT_DIR/.cursor/prompts/spec-elicit.md"
require_file "$ROOT_DIR/docs/templates/planning/MASTER_PLAN.template.md"
require_file "$ROOT_DIR/docs/templates/spec-feature/SPEC.template.md"
require_file "$ROOT_DIR/Makefile"
require_file "$ROOT_DIR/init"
require_file "$ROOT_DIR/PROJECT_BRAIN.md"
require_file "$ROOT_DIR/START_PROJECT.md"
require_file "$ROOT_DIR/scripts/init.sh"
require_file "$ROOT_DIR/scripts/contract-add.sh"
require_file "$ROOT_DIR/scripts/ops.sh"
require_file "$ROOT_DIR/.cursor/prompts/generate-docs.md"
require_file "$ROOT_DIR/.cursor/prompts/stakeholder-brd.md"
require_file "$ROOT_DIR/.cursor/prompts/analyze-project.md"

require_dir "$ROOT_DIR/.cursor/rules"
require_dir "$ROOT_DIR/.cursor/prompts"
require_dir "$ROOT_DIR/docs/guides"

for guide in \
  laravel-backend-bible.md \
  laravel-advanced-patterns-guide.md \
  laravel-translation-guide.md \
  laravel-security-hardening-guide.md \
  laravel-docker-hardening-guide.md \
  laravel-production-setup-guide.md
do
  require_file "$ROOT_DIR/docs/guides/$guide"
done

rule_count="$(find "$ROOT_DIR/.cursor/rules" -name '*.mdc' 2>/dev/null | wc -l | tr -d ' ')"
if [[ "${rule_count:-0}" -lt 1 ]]; then
  fail "no .mdc rules under .cursor/rules"
fi

prompt_count="$(find "$ROOT_DIR/.cursor/prompts" -name '*.md' 2>/dev/null | wc -l | tr -d ' ')"
if [[ "${prompt_count:-0}" -lt 10 ]]; then
  warn "expected at least 10 prompt files, found: ${prompt_count:-0}"
fi

for exe in init scripts/init.sh scripts/contract-add.sh scripts/ops.sh; do
  if [[ -f "$ROOT_DIR/$exe" ]] && [[ ! -x "$ROOT_DIR/$exe" ]]; then
    warn "$exe is not executable (run: chmod +x $exe)"
  fi
done

if [[ -d "$ROOT_DIR/api/.cursor/prompts" ]]; then
  if [[ ! -f "$ROOT_DIR/api/.cursor/prompts/generate-docs.md" ]]; then
    warn "api/.cursor/prompts missing generate-docs.md — run ./init to refresh api/.cursor"
  fi
else
  warn "api/.cursor not present — run ./init after clone to scaffold api + sync prompts"
fi

if [[ "$errors" -eq 0 ]]; then
  echo "[verify] OK — template checks passed"
  exit 0
fi

echo "[verify] completed with $errors error(s)"
exit 1
