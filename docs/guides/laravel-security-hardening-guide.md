# Laravel Security Hardening Guide

Comprehensive security baseline for Laravel projects aligned with OWASP Top 10 (2025) and SaaS production practices.

## OWASP Top 10 Focus Areas

1. Broken access control
2. Cryptographic failures
3. Supply chain failures
4. Injection (SQLi, XSS)
5. Insecure design
6. Security misconfiguration
7. Vulnerable dependencies
8. Authentication failures
9. Data integrity failures
10. Monitoring and logging failures

## 1) Laravel Application Security

### Security headers (middleware)
- Add security headers in global middleware:
  - `X-Content-Type-Options: nosniff`
  - `X-Frame-Options: SAMEORIGIN`
  - `Referrer-Policy: strict-origin-when-cross-origin`
  - `Permissions-Policy` with least privilege
  - CSP with strict sources
- Enable HSTS only in production.

### CSRF and auth
- Keep CSRF token on all state-changing web forms.
- Protect API routes with `auth:sanctum` or equivalent.
- Rate-limit auth routes and password reset flows.

### Injection and XSS
- Use Eloquent/Query Builder and bound parameters.
- Never concatenate untrusted input into raw SQL.
- Prefer escaped Blade output `{{ }}` over raw `{!! !!}`.
- Sanitize rich HTML content before rendering.

### Authorization and mass assignment
- Always authorize access using policies/gates.
- Keep models protected with explicit `$fillable`.
- Use `$request->validated()` from Form Requests.

### File uploads
- Validate MIME, extension, max size, and dimensions where applicable.
- Store uploads on private disks when possible.
- Use randomized filenames (`UUID`) and disable PHP execution in upload paths.

### Sensitive data handling
- Encrypt sensitive fields using casts (`encrypted`) where suitable.
- Hash passwords only with Laravel hash facilities.
- Never log secrets, tokens, card numbers, or full credentials.

## 2) Infrastructure Hardening

### Nginx/Apache
- Force HTTPS with redirect from HTTP.
- Hide server signatures/tokens.
- Deny access to hidden and sensitive files (`.env`, `.git`, backups, manifests).
- Apply request rate limits by route class (`auth`, `api`, general).
- Disable script execution in upload directories.

### PHP runtime
- `expose_php=Off`
- `display_errors=Off` in production
- `log_errors=On`
- Harden sessions (`cookie_secure`, `httponly`, `samesite`, strict mode)
- Restrict dangerous functions according to deployment needs.

### Database and cache
- Use least-privilege DB user with scoped grants.
- Avoid superuser privileges for app runtime.
- Restrict Redis to local/private network and set authentication.
- Disable dangerous Redis commands if operationally acceptable.

## 3) Supply Chain Security

- Run `composer audit` in CI and before release.
- Keep dependencies updated and remove unused packages.
- Commit and review `composer.lock`.
- Pin major versions intentionally.

## 4) Environment and Secrets Security

- `APP_ENV=production`, `APP_DEBUG=false` in production.
- Keep `.env` out of git and file-permission restricted.
- Prefer secrets manager/vault for high-sensitivity systems.
- Cache config in production (`php artisan config:cache`).

## 5) Logging, Monitoring, and Incident Readiness

- Centralize error monitoring (for example Sentry).
- Scrub secrets/authorization data from logs before shipping.
- Set log retention and rotation.
- Maintain incident response runbook with first-hour actions.

## 6) Security Testing Baseline

- Automated:
  - `composer audit`
  - static analysis (`phpstan` or equivalent)
  - security headers checks
- Manual:
  - SQL injection and XSS checks
  - authz bypass attempts
  - file upload abuse scenarios
  - CSRF validation

## 7) Practical CVE Pattern Defenses

- Path traversal: normalize paths and use safe storage APIs.
- SSRF: whitelist domains, block private/reserved network targets.
- URL normalization bypass: reject encoded traversal patterns.
- File upload bypass: validate MIME + extension + storage location.

## 8) Deployment Checklist

### Pre-production
- `APP_DEBUG=false`
- valid TLS certs
- security headers enabled
- rate limiting enabled
- dependency audit clean or documented exceptions
- backup and restore strategy validated

### Ongoing
- monthly vulnerability scans
- periodic penetration tests
- regular patch cadence
- backup restoration drills
- incident-response rehearsal
