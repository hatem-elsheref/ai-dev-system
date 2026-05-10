# Laravel Backend Bible v1.0

Source-of-truth backend standards for every Laravel project in this system.

## 1) Version and Setup Baseline

- Laravel: latest stable (currently 11.x)
- PHP: 8.3+
- Use `declare(strict_types=1);` in all PHP files.
- Testing baseline: Pest preferred for new projects.

Recommended starter packages:
- `laravel/sanctum`
- `spatie/laravel-permission`
- `spatie/laravel-query-builder`
- `spatie/laravel-translatable` (when content translation is needed)
- `stancl/tenancy` for SaaS multi-tenancy

## 2) Architecture Shape (Domain-Driven)

Prefer module/domain structure:
- `app/Domain/{Module}/Actions`
- `app/Domain/{Module}/Services`
- `app/Domain/{Module}/Repositories` (only when needed)
- `app/Domain/{Module}/Contracts`
- `app/Domain/{Module}/Enums`

HTTP layer remains thin:
- `app/Http/Controllers/Api/V1`
- `app/Http/Requests/{Module}`
- `app/Http/Resources/{Module}`

## 3) Fixed Controller Rules

Controllers should only:
1. Receive validated input (Form Request)
2. Delegate to Service/Action
3. Return Resource/JSON response

Do not place business logic in controllers.

## 4) Validation Rules

- All validation belongs in Form Request classes.
- Use `authorize()` + policy checks when relevant.
- Prefer `prepareForValidation()` for normalization.
- Use translation files for messages/attributes; avoid inline hardcoded text.

## 5) Service + Action Rules

- Service layer contains business orchestration.
- Action classes should have single responsibility.
- Wrap write-side workflows in DB transactions where consistency is required.
- Side effects (notifications/payments/integrations) go through dedicated services/contracts.

## 6) Repository and Query Rules

- Repositories are optional; use them for complex query/filter logic.
- Use Eloquent `when()` chains instead of repetitive `if` query branching.
- Eager load required relations to avoid N+1.
- Paginate and bound `per_page` max.

## 7) Contracts and Extensibility

- Depend on interfaces, not concrete implementations.
- Bind implementations in providers/config (gateway/provider pattern).
- External providers (payments/SMS) must be pluggable through contracts.

## 8) Translation Standard (Mandatory)

- Use one-dot keys only: `__('file.key')`
- Use flat keys with underscores: `order_created`, `user_name`
- No nested keys like `app.users.name`

See:
- `docs/guides/laravel-translation-guide.md`

## 9) Enum and Model Standards

- Replace magic strings with typed enums.
- Model rules:
  - explicit `$fillable`
  - typed casts
  - reusable scopes for common filters
  - soft deletes where domain-appropriate

## 10) API Response Standards

Maintain consistent response shape:
- list responses include `data`, `meta`, `links`
- single responses include `message`, `data`
- validation errors include `message`, `errors`

Use API Resources for output consistency.

## 11) Route Standards

- Version APIs (`/api/v1`)
- Group public/protected/admin routes clearly
- Use Sanctum for protected API auth
- Put role/permission middleware on protected segments

## 12) Multi-Tenancy (SaaS)

When tenancy is needed:
- use separate database per tenant
- isolate central vs tenant routes
- avoid hardcoded tenant database assumptions

## 13) Performance and DB Standards

- Add indexes on frequently filtered/sorted/joined columns.
- Add composite indexes for common query patterns.
- Keep migrations reversible and safe.

## 14) Security Non-Negotiables

- No `$request->all()` for writes; use `$request->validated()`
- Authorization must be enforced before sensitive actions.
- Avoid raw SQL with untrusted input.
- Follow hardening guide:
  - `docs/guides/laravel-security-hardening-guide.md`

## 15) Prohibited Patterns

- Business logic in controllers
- Nested translation keys
- Magic strings for status/state
- Direct coupling to concrete external providers
- Missing return types and missing strict types
- Querying relations without eager loading when needed

## 16) Testing Requirements

Feature tests are required for each module:
- happy path
- unauthorized/forbidden
- validation failures
- not found
- filtering/pagination
- key security edge cases

Use factories/seeders with realistic domain states.

## 17) Deployment Checklist (Backend)

- tests pass
- no debug helpers (`dd`, `dump`)
- strict types enabled
- migrations/indexes validated
- `APP_DEBUG=false`
- config/route caches generated for production
- queue workers and scheduler operational

---

This guide is mandatory baseline behavior for Laravel backend generation in this repository.
