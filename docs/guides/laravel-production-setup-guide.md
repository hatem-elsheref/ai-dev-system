# Laravel Complete Production Setup Guide

Production setup baseline for Laravel projects covering DevOps, monitoring, reliability, and performance.

## 1) Process Management (Supervisor + Scheduler)

- Install and run Supervisor for queue workers and Horizon.
- Use bounded worker lifecycle:
  - `--sleep=3`
  - `--tries=3`
  - `--timeout=90`
  - `--max-jobs`, `--max-time` for memory stability
- Run scheduler via cron every minute:
  - `* * * * * php artisan schedule:run`

## 2) Web Server Baselines

### Nginx
- Force HTTPS with redirect from HTTP.
- Use TLS 1.2+ with modern ciphers.
- Set security headers (HSTS, X-Content-Type-Options, X-Frame-Options).
- Apply rate limits for auth and API paths.
- Configure static asset caching with long expiration.
- Ensure front-controller routing with `try_files`.

### Apache
- Configure HTTPS virtual host and rewrite to `public/index.php`.
- Enable `rewrite` + `headers` modules.
- Apply security headers and access/error log separation.

## 3) Monitoring and Observability

- Telescope for development and controlled access.
- Disable Telescope exposure in production unless explicitly gated.
- Horizon for queue monitoring in production.
- Sentry integration for error tracking and traces.

## 4) Production Performance Optimization

Run before/after deployment:
- `composer install --optimize-autoloader --no-dev`
- `php artisan config:cache`
- `php artisan route:cache`
- `php artisan view:cache`

Runtime recommendations:
- OPcache enabled and tuned
- `simplePaginate()` for very large listings when total count is not required
- `chunk()`/`lazy()` for large batch processing

## 5) API Documentation Practices

- Keep OpenAPI/Swagger annotations updated or generated from source.
- Ensure key endpoints include status/authorization/error responses.
- Keep docs aligned with route versioning (`/api/v1`).

## 6) Auditing and Data Logging

- Use auditable trait/service for create/update/delete events.
- Persist actor, request context, and value diffs where safe.
- Avoid logging secrets and sensitive payloads.

## 7) Production Readiness Checklist

- workers running under supervisor
- scheduler cron active
- HTTPS and TLS correctly configured
- security headers enabled
- rate limiting active
- cache commands executed
- observability stack (Sentry/Horizon) verified
- tests passing and migrations applied

## 8) Recommended Command Set

```bash
composer install --optimize-autoloader --no-dev
php artisan migrate --force
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan queue:restart
php artisan horizon:terminate
```

## 9) Related Guides

- `docs/guides/laravel-backend-bible.md`
- `docs/guides/laravel-advanced-patterns-guide.md`
- `docs/guides/laravel-security-hardening-guide.md`
- `docs/guides/laravel-docker-hardening-guide.md`
