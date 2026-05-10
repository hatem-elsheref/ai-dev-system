#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEPLOY_SCRIPT="${ROOT_DIR}/docs/templates/ops/deploy/production-deploy.sh"
OPS_TEMPLATE_DIR="${ROOT_DIR}/docs/templates/ops"

usage() {
  echo "Ops helpers for Laravel deployment (run on your server or after setting paths)."
  echo ""
  echo "Usage:"
  echo "  $(basename "$0") help                  Show this help"
  echo "  $(basename "$0") deploy                Run production deploy script (needs APP_DIR)"
  echo "  $(basename "$0") nginx-test            Print nginx config test + reload commands"
  echo "  $(basename "$0") supervisor-reload     Print supervisor reload commands"
  echo "  $(basename "$0") ops-copy <dest-dir>   Copy docs/templates/ops into dest-dir"
  echo ""
  echo "Environment:"
  echo "  APP_DIR      Laravel root on server (required for deploy)"
  echo "  PHP_BIN      Default: php"
  echo "  COMPOSER_BIN Default: composer"
}

cmd_deploy() {
  if [[ -z "${APP_DIR:-}" ]]; then
    echo "[ops] error: set APP_DIR to your Laravel project root on the server."
    echo "[ops] example: APP_DIR=/var/www/app.com $(basename "$0") deploy"
    exit 1
  fi
  if [[ ! -d "$APP_DIR" ]]; then
    echo "[ops] error: APP_DIR is not a directory: $APP_DIR"
    exit 1
  fi
  export APP_DIR
  bash "$DEPLOY_SCRIPT"
}

cmd_nginx_test() {
  echo "--- Run on the server (adjust paths if needed) ---"
  echo "sudo nginx -t && sudo systemctl reload nginx"
  echo "# or: sudo service nginx reload"
}

cmd_supervisor_reload() {
  echo "--- Run on the server ---"
  echo "sudo supervisorctl reread"
  echo "sudo supervisorctl update"
  echo "sudo supervisorctl status"
}

cmd_ops_copy() {
  local dest="${1:-}"
  if [[ -z "$dest" ]]; then
    echo "[ops] error: pass destination directory, e.g. $(basename "$0") ops-copy ./deploy/ops"
    exit 1
  fi
  mkdir -p "$dest"
  cp -R "$OPS_TEMPLATE_DIR/." "$dest/"
  echo "[ops] copied templates to: $dest"
  echo "[ops] edit paths, domain, and users before installing on the server."
}

main() {
  case "${1:-help}" in
    help|-h|--help) usage ;;
    deploy) cmd_deploy ;;
    nginx-test) cmd_nginx_test ;;
    supervisor-reload) cmd_supervisor_reload ;;
    ops-copy) cmd_ops_copy "${2:-}" ;;
    *) usage; exit 1 ;;
  esac
}

main "$@"
