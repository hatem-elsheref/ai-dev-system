#!/usr/bin/env bash
set -euo pipefail

APP_DIR="${APP_DIR:-/var/www/app.com}"
PHP_BIN="${PHP_BIN:-php}"
COMPOSER_BIN="${COMPOSER_BIN:-composer}"

echo "[deploy] starting production deployment"
cd "$APP_DIR"

echo "[deploy] install php dependencies"
$COMPOSER_BIN install --no-dev --prefer-dist --optimize-autoloader --no-interaction

echo "[deploy] run migrations"
$PHP_BIN artisan migrate --force

echo "[deploy] warm caches"
$PHP_BIN artisan config:cache
$PHP_BIN artisan route:cache
$PHP_BIN artisan view:cache

echo "[deploy] restart workers"
$PHP_BIN artisan queue:restart || true
$PHP_BIN artisan horizon:terminate || true

echo "[deploy] done"
echo "[deploy] remember: sudo supervisorctl reread && sudo supervisorctl update"
