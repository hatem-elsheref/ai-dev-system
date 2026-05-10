#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REGISTRY="${ROOT_DIR}/api-contract/contracts/API_ENDPOINTS.md"
TEMPLATE="${ROOT_DIR}/docs/templates/api-contract/API_CONTRACT_TEMPLATE.md"

usage() {
  echo "Usage:"
  echo "  contract-add                                    # interactive"
  echo "  contract-add <METHOD> <PATH> <NAME> [auth]     # non-interactive"
  echo ""
  echo "Examples:"
  echo "  contract-add POST /api/v1/orders \"Create order\" sanctum"
  echo "  contract-add GET /api/v1/me \"Current user\" sanctum"
}

append_block() {
  local method="$1"
  local path="$2"
  local name="$3"
  local auth="${4:-sanctum}"
  local stamp
  stamp="$(date -u +"%Y-%m-%d")"

  if [[ -f "$REGISTRY" ]] && grep -qF "## ${name}" "$REGISTRY" 2>/dev/null; then
    echo "[contract-add] warning: a section titled like this may already exist. Appending anyway."
  fi

  {
    echo ""
    echo "---"
    echo ""
    echo "## ${name}"
    echo ""
    echo "- **Added:** ${stamp}"
    echo "- **Method:** \`${method}\`"
    echo "- **Full Path:** \`${path}\`"
    echo "- **Auth:** \`${auth}\`"
    echo "- **Request Content-Type:** \`application/json\`"
    echo ""
    echo "### Request Payload"
    echo '```json'
    echo "{}"
    echo '```'
    echo ""
    echo "### Success Response (\`200\` / \`201\`)"
    echo '```json'
    echo "{}"
    echo '```'
    echo ""
    echo "### Error Responses"
    echo "- \`401\` Unauthorized"
    echo "- \`403\` Forbidden"
    echo "- \`404\` Not Found"
    echo "- \`422\` Validation Error"
    echo "- \`500\` Server Error"
    echo ""
    echo "### Notes"
    echo "- "
    echo ""
  } >> "$REGISTRY"

  echo "[contract-add] appended to ${REGISTRY}"
}

interactive() {
  local method path name auth
  read -r -p "Endpoint name (human-readable): " name || true
  read -r -p "HTTP method (GET|POST|PUT|PATCH|DELETE): " method || true
  read -r -p "Full path (e.g. /api/v1/orders): " path || true
  read -r -p "Auth (public|sanctum|role-based) [sanctum]: " auth || true
  auth="${auth:-sanctum}"
  if [[ -z "${name}" || -z "${method}" || -z "${path}" ]]; then
    echo "[contract-add] error: name, method, and path are required."
    exit 1
  fi
  append_block "$(echo "$method" | tr '[:lower:]' '[:upper:]')" "$path" "$name" "$auth"
}

main() {
  mkdir -p "$(dirname "$REGISTRY")"
  if [[ ! -f "$REGISTRY" ]]; then
    if [[ -f "$TEMPLATE" ]]; then
      cp "$TEMPLATE" "$REGISTRY"
      echo "[contract-add] created registry from template."
    else
      echo "# API Endpoints Registry" > "$REGISTRY"
      echo "" >> "$REGISTRY"
    fi
  fi

  if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    usage
    exit 0
  fi

  if [[ $# -ge 3 ]]; then
    append_block "$(echo "$1" | tr '[:lower:]' '[:upper:]')" "$2" "$3" "${4:-sanctum}"
    exit 0
  fi

  if [[ $# -eq 0 ]]; then
    interactive
    exit 0
  fi

  usage
  exit 1
}

main "$@"
