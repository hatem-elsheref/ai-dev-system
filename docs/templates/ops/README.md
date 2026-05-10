# Ops Templates

Copy these templates into server/project paths and adjust domain, paths, users, and secrets before use.

## Included
- `supervisor/laravel-worker.conf`
- `supervisor/laravel-horizon.conf`
- `nginx/app.conf`
- `cron/scheduler.cron`
- `deploy/production-deploy.sh`

## Helper CLI (from repo root)

- `bash scripts/ops.sh help` — usage
- `APP_DIR=/path/to/laravel bash scripts/ops.sh deploy` — run deploy script
- `bash scripts/ops.sh ops-copy ./deploy/ops` — copy this tree for customization

Makefile: `make ops-help`, `make deploy`, `make nginx-test`, `make supervisor-reload`, `make ops-copy DEST=...`

## Notes
- These are baseline production templates for Laravel.
- Validate configs with service-specific tools before reload/restart.
- Keep secrets in environment or secret manager, never in committed files.
