# Basic Guides

These are practical baseline guides for all generated and hand-written code.

## 1) General coding guide
- Keep functions small and focused on one responsibility.
- Prefer explicit names over short/clever names.
- Avoid duplicate logic; extract shared helpers when reused.
- No hardcoded secrets, URLs, or environment-specific values.
- Refactor only with purpose; do not introduce unnecessary abstractions.

## 2) Laravel API guide
- Keep controllers thin: validate, authorize, delegate, respond.
- Put domain/business logic in services/actions.
- Use Form Requests for validation and API Resources for output shaping.
- Use queued jobs for long-running work.
- Add policies/permissions for protected actions.
- Follow translation standard: one-dot keys `__('file.key')` with flat key names.
- Read detailed i18n guide in `docs/guides/laravel-translation-guide.md`.
- Follow complete backend baseline in `docs/guides/laravel-backend-bible.md`.
- Use advanced architecture patterns from `docs/guides/laravel-advanced-patterns-guide.md`.

## 3) MySQL guide
- Model entities with clear primary/foreign keys.
- Add indexes for real read paths (filters, joins, ordering).
- Prevent N+1 queries using eager loading and query planning.
- Keep migrations reversible and safe for production rollouts.

## 4) React SPA guide
- Organize by feature modules.
- Build reusable UI components; keep page components lightweight.
- Handle loading, empty, and error states explicitly.
- Avoid inline styles and support accessibility defaults.

## 5) React Native guide
- Keep API access in a shared client layer.
- Reuse UI primitives and hooks across screens.
- Design responsive layouts for multiple device sizes.
- Consider offline/resume behavior where required.

## 6) Testing guide
- Cover new behavior with tests before merge.
- Test business rules, authorization, and failure paths.
- Keep tests deterministic and easy to read.
- Prefer realistic integration/feature tests for critical flows.

## 7) Security guide
- Validate and sanitize all inputs.
- Escape/sanitize outputs where needed.
- Enforce RBAC and least-privilege access.
- Never expose secrets in code, logs, or client responses.
- Follow the full hardening reference in `docs/guides/laravel-security-hardening-guide.md`.

## 8) Delivery guide
- Update docs when behavior/contracts change.
- Keep pull requests focused and reviewable.
- Include migration notes for database changes.
- Include rollback notes for risky deployments.
- For containerized deployments, follow `docs/guides/laravel-docker-hardening-guide.md`.
- For server production operations, follow `docs/guides/laravel-production-setup-guide.md`.
