#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[init] bootstrapping project structure"

mkdir -p "$ROOT_DIR/api" "$ROOT_DIR/frontend" "$ROOT_DIR/api-contract" "$ROOT_DIR/mobile" "$ROOT_DIR/specs"
mkdir -p "$ROOT_DIR/api/.cursor" "$ROOT_DIR/api/.cursor/context" "$ROOT_DIR/api/.cursor/guides"
mkdir -p "$ROOT_DIR/api-contract/contracts" "$ROOT_DIR/api-contract/templates"

echo "[init] copying Cursor assets into api/.cursor"
cp -R "$ROOT_DIR/.cursor/rules" "$ROOT_DIR/api/.cursor/"
cp -R "$ROOT_DIR/.cursor/prompts" "$ROOT_DIR/api/.cursor/"
cp -R "$ROOT_DIR/.cursor/templates" "$ROOT_DIR/api/.cursor/"

echo "[init] copying core context docs for backend AI"
cp "$ROOT_DIR/PROJECT_BRAIN.md" "$ROOT_DIR/api/.cursor/context/" || true
cp "$ROOT_DIR/CODING_RULES.md" "$ROOT_DIR/api/.cursor/context/" || true
cp "$ROOT_DIR/STACK_RULES.md" "$ROOT_DIR/api/.cursor/context/" || true
cp "$ROOT_DIR/BASIC_GUIDES.md" "$ROOT_DIR/api/.cursor/context/" || true
cp "$ROOT_DIR/START_PROJECT.md" "$ROOT_DIR/api/.cursor/context/" || true
cp "$ROOT_DIR/ARCHITECTURE.md" "$ROOT_DIR/api/.cursor/context/" || true

echo "[init] copying Laravel guides into api/.cursor/guides"
cp "$ROOT_DIR/docs/guides/laravel-backend-bible.md" "$ROOT_DIR/api/.cursor/guides/" || true
cp "$ROOT_DIR/docs/guides/laravel-advanced-patterns-guide.md" "$ROOT_DIR/api/.cursor/guides/" || true
cp "$ROOT_DIR/docs/guides/laravel-translation-guide.md" "$ROOT_DIR/api/.cursor/guides/" || true
cp "$ROOT_DIR/docs/guides/laravel-security-hardening-guide.md" "$ROOT_DIR/api/.cursor/guides/" || true
cp "$ROOT_DIR/docs/guides/laravel-docker-hardening-guide.md" "$ROOT_DIR/api/.cursor/guides/" || true
cp "$ROOT_DIR/docs/guides/laravel-production-setup-guide.md" "$ROOT_DIR/api/.cursor/guides/" || true

if [[ ! -f "$ROOT_DIR/api/README.md" ]]; then
  cat > "$ROOT_DIR/api/README.md" <<'EOF'
# API (Laravel Backend)

This folder is reserved for the Laravel API codebase.

## First steps
1. Initialize Laravel here.
2. Keep API implementation aligned with `api/.cursor/` rules and guides.
3. Register every endpoint contract in `../api-contract/contracts/API_ENDPOINTS.md`.
4. From repo root, run `make verify` after updating the template; run `./init` again to refresh `api/.cursor` copies.
EOF
fi

if [[ ! -f "$ROOT_DIR/frontend/README.md" ]]; then
  cat > "$ROOT_DIR/frontend/README.md" <<'EOF'
# Frontend (React SPA)

This folder is reserved for the React SPA codebase.
EOF
fi

if [[ ! -f "$ROOT_DIR/mobile/README.md" ]]; then
  cat > "$ROOT_DIR/mobile/README.md" <<'EOF'
# Mobile (React Native)

This folder is reserved for the React Native codebase.
EOF
fi

if [[ ! -f "$ROOT_DIR/api-contract/README.md" ]]; then
  cat > "$ROOT_DIR/api-contract/README.md" <<'EOF'
# API Contracts

This folder is the source of truth for API contracts shared across backend, frontend, and mobile.

## Mandatory
- Every new/updated endpoint must be documented before implementation.
- Keep path, version, method, payload, content type, response format, and status codes explicit.
EOF
fi

if [[ ! -f "$ROOT_DIR/api-contract/contracts/API_ENDPOINTS.md" ]]; then
  cat > "$ROOT_DIR/api-contract/contracts/API_ENDPOINTS.md" <<'EOF'
# API Endpoints Registry

Use one section per endpoint.

## Endpoint Template
- Name:
- Version: `v1`
- Method: `GET|POST|PUT|PATCH|DELETE`
- Full Path: `/api/v1/...`
- Auth: `public|sanctum|role-based`
- Request Content-Type: `application/json|multipart/form-data`
- Request Payload:
```json
{}
```
- Success Response:
```json
{}
```
- Error Responses:
  - `400`:
  - `401`:
  - `403`:
  - `404`:
  - `422`:
  - `500`:
- Notes:
EOF
fi

if [[ -f "$ROOT_DIR/docs/templates/api-contract/API_CONTRACT_TEMPLATE.md" ]]; then
  cp "$ROOT_DIR/docs/templates/api-contract/API_CONTRACT_TEMPLATE.md" \
    "$ROOT_DIR/api-contract/templates/API_CONTRACT_TEMPLATE.md"
fi

echo "[init] done"
echo "[init] created: api, frontend, api-contract, mobile"
echo "[init] seeded: api/.cursor and api-contract contracts template"
echo "[init] tip: run \"make verify\" to sanity-check the template"
