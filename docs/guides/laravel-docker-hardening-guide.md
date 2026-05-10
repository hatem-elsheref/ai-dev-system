# Laravel Docker Hardening Guide

Production-oriented Docker reference for Laravel API with Nginx, PHP-FPM, MySQL, Redis, queue workers, and scheduler.

## 1) Build Strategy

- Use multi-stage Docker builds:
  - `builder` stage installs dependencies and compiles assets.
  - `runtime` stage contains only runtime binaries and app files.
- Run processes as non-root user.
- Keep image minimal (`alpine` where compatible) and remove build-only packages from runtime.
- Use `.dockerignore` to exclude secrets, local metadata, and unnecessary files.

## 2) Recommended Stack

- `nginx` (reverse proxy/static files)
- `app` (php-fpm, Laravel)
- `db` (MySQL)
- `redis` (cache/queue/session if needed)
- `queue` (queue workers)
- `scheduler` (Laravel scheduler)

Optional:
- `phpmyadmin` in `dev` profile only.

## 3) Nginx Hardening Snippets

Use these patterns in Nginx config to block common backdoor and upload-shell abuse.

### Deny sensitive and hidden files

```nginx
location ~ /\.(?!well-known).* {
    deny all;
    access_log off;
    log_not_found off;
}

location ~* \.(env|ini|log|sql|bak|old|swp|dist)$ {
    deny all;
}

location ~* /(composer\.(json|lock)|package\.json|artisan|phpunit\.xml|\.git) {
    deny all;
}
```

### Block script execution inside uploads/storage

```nginx
location ~* ^/(uploads|storage|media)/.*\.(php|phtml|phar|pl|py|cgi|asp|aspx|jsp|sh)$ {
    deny all;
}
```

### Block common scanner/backdoor probes (including WordPress paths)

```nginx
location ~* ^/(wp-admin|wp-login\.php|xmlrpc\.php|wp-content|wp-includes|\.git|vendor|\.env) {
    return 444;
}

location ~* "(eval\(|base64_decode\(|shell_exec\(|passthru\(|system\()" {
    return 403;
}
```

### Restrict PHP execution to front controller only

```nginx
location ~ \.php$ {
    if ($uri !~ "^/index\.php$") { return 404; }
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
    fastcgi_pass app:9000;
}
```

## 4) PHP Runtime Hardening

- `expose_php=Off`
- `display_errors=Off` in production
- `log_errors=On`
- set secure sessions (`cookie_secure`, `httponly`, `samesite=Strict`)
- restrict dangerous functions where possible
- use opcache in production

Note: disabling functions too aggressively can break libraries. Validate per project before rollout.

## 5) Supervisor and Process Management

- Manage queue workers via supervisor:
  - autorestart enabled
  - bounded `--max-jobs` and `--max-time`
  - logs to stdout/stderr for container logging
- Keep scheduler in separate service (`php artisan schedule:work`)
- Do not run queue + scheduler + php-fpm in one process unless you intentionally use a process manager design.

## 6) Storage and Upload Safety

- Use private disk for sensitive uploads.
- Generate random file names (`UUID`) before persistence.
- Validate extension + MIME + size + dimensions.
- Never serve raw user uploads from executable directories.

## 7) Secrets and Environment

- Keep secrets in `.env` or secret manager; never in image.
- Use separate `.env.docker`/runtime env injection.
- Ensure `.env` is excluded from git and docker context.

## 8) Deployment and Operations

- Health checks for app/db/redis.
- Graceful restart policy (`unless-stopped` or orchestrator-specific).
- Rate limiting on auth and API endpoints.
- Centralized logs and monitoring.
- Backup strategy for DB and critical storage.

## 9) Quick Security Checklist

- Non-root containers
- HTTPS enforced
- security headers enabled
- Nginx denies sensitive files and script execution in uploads
- PHP restricted and opcache configured
- dependencies scanned (`composer audit`)
- least-privilege DB credentials
- backups tested

## 10) AI Usage Instruction

When generating Docker files for Laravel:
- prioritize secure defaults first
- include Nginx deny rules for sensitive/probe paths
- block script execution in upload directories
- keep queue/scheduler as separate services
- avoid development-only tools in production compose profiles
