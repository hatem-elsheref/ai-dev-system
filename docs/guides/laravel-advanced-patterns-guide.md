# Laravel Advanced Patterns and Implementation Guide

Advanced reference for scalable Laravel backend implementation in production SaaS systems.

## 1) Migration Patterns

- Keep one table per migration file.
- Include indexes for filter/sort/join columns from day one.
- Use soft deletes where recovery/audit needs exist.
- Prefer explicit column sizes and nullable strategy.
- Include rollback-safe `down()` for every migration.

Common advanced tables:
- `audit_logs`
- `system_settings`
- `notification_preferences`
- `sms_logs`
- `notification_logs`

## 2) Auditability Pattern

- Use an `Auditable` trait (or domain service) to track:
  - created/updated/deleted events
  - old/new values
  - actor (`user_id`)
  - IP and user-agent
- Record audits asynchronously when throughput is high.
- Exclude sensitive fields from old/new snapshots.

## 3) System Settings from Database

- Use `SystemSetting` model + `SystemSettingService`.
- Cache keys with prefix and TTL.
- Support typed values (`string`, `integer`, `boolean`, `json`).
- Invalidate cache on updates.
- Expose helper `setting('key', default)`.

## 4) Multi-Channel Notification Architecture

- Define `NotificationChannelInterface` for custom channels.
- Keep channel adapters per medium:
  - SMS
  - WhatsApp
  - Web Push
- Resolve channels by user preference or config map.
- Log delivery result, retries, and provider response metadata.

## 5) Provider Contract Pattern (SMS/Payment)

- Depend on contracts:
  - `SmsProviderInterface`
  - `PaymentGatewayInterface`
- Bind provider via config/env in service container.
- Never instantiate provider classes directly in domain logic.
- Add provider-specific observability and graceful fallback behavior.

## 6) Configuration System Pattern

- Keep provider/channels/feature flags in dedicated config file (for example `config/app-settings.php`).
- Drive behavior by config + env + DB settings.
- Avoid hardcoded provider names/channels in business classes.

## 7) Seeder Strategy

- Seed realistic role-based data (`customer`, `merchant`, `admin`).
- Keep idempotent seeders for repeated dev/staging setup.
- Separate production-safe seeders from local demo seeders.

## 8) Route and Versioning Pattern

- Version API (`/api/v1`).
- Separate public vs protected route groups.
- Keep admin routes under dedicated prefix + role middleware.
- Keep custom actions explicit (for example `orders/{order}/cancel`).

## 9) Helper and Support Layer

- Keep global helpers minimal and stable (`setting()`, `audit()`).
- Register helpers through composer `autoload.files`.
- Prefer service classes for heavy logic even if helper wrappers exist.

## 10) Queue and Monitoring

- Use Horizon for queue operations in production.
- Run workers under supervisor with restart strategy.
- Bound worker lifecycle (`max-jobs`, `max-time`) to avoid leaks.
- Track queue failures and retry behavior.

## 11) Error Monitoring (Sentry)

- Enable Sentry by environment.
- Configure sample rates per environment.
- Scrub sensitive data before sending events.
- Correlate errors with request/user identifiers where safe.

## 12) Validation and Query Composition

- Keep requests lean with strict validation rules.
- Prefer `when()` chains for optional filters.
- Bound pagination (`per_page` min/max).
- Keep filtering/query logic in repository/query object.

## 13) Non-Negotiable Rules

- No business logic in controllers.
- No `$request->all()` for write paths.
- No magic status strings (use enums).
- No nested translation keys.
- No direct concrete provider usage in domain services.

## 14) Related Required Guides

- `docs/guides/laravel-backend-bible.md`
- `docs/guides/laravel-translation-guide.md`
- `docs/guides/laravel-security-hardening-guide.md`
- `docs/guides/laravel-docker-hardening-guide.md`
