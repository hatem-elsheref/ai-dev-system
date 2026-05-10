# Laravel Translation Guide

## Golden Rule

- Correct: `__('app.users_name')`
- Correct: `__('messages.order_created')`
- Correct: `__('validation.email_required')`
- Wrong: `__('app.users.name')`
- Wrong: `__('app_users_name')`

Use exactly one dot in translation keys: `file.key`.

## Translation File Structure

```text
lang/
├── ar/
│   ├── app.php
│   ├── messages.php
│   ├── validation.php
│   ├── errors.php
│   ├── emails.php
│   └── notifications.php
└── en/
    ├── app.php
    ├── messages.php
    ├── validation.php
    ├── errors.php
    ├── emails.php
    └── notifications.php
```

## Key Naming Standard

- Flat keys only: `users_name`, `order_created`, `email_required`
- Lowercase with underscores
- Group related keys by file (`app`, `messages`, `validation`, `errors`, etc.)
- Avoid nested arrays for regular translation keys
- Keep `attributes` only for field labels in validation files

## Usage Rules in Code

- Controllers: return user-facing messages with `__('messages.some_key')`
- Form Requests: map validation messages using `__('validation.some_key')`
- Blade: use `__('app.some_key')` for labels/placeholders/UI strings
- Notifications/Mails: keep subject/body keys in `messages`/`emails`
- API Resources: expose translated labels only where the client expects display text

## Locale and Fallback

- Default locale from config/environment
- Fallback locale must be `en`
- Supported locales should be explicit (for example: `ar`, `en`)

## Recommended Config

```php
<?php
// config/i18n.php
return [
    'default'   => env('APP_LOCALE', 'ar'),
    'fallback'  => 'en',
    'supported' => ['ar', 'en'],
    'rtl_languages' => ['ar', 'ur', 'he'],
];
```

## Middleware Guideline

Create a locale middleware that:
- Reads locale from request/session/default config
- Validates locale against configured supported locales
- Applies locale through `app()->setLocale($locale)`

## Quality Checklist

- Every new user-facing string is moved to `lang/*/*.php`
- Arabic and English keys stay aligned
- No hardcoded Arabic/English strings in controllers/resources
- No invalid key format (`app.users.name`, `app_users_name`)
