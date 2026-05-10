# Incremental feature specs

Each feature or change gets a **numbered folder**:

```text
specs/
├── 001-user-auth/
│   ├── SPEC.md
│   ├── PLAN.md
│   ├── TASKS.md
│   └── PROGRESS.md
├── 002-billing-stripe/
│   └── ...
```

Numbers are **zero-padded** (`001`, `002`, …) so sorting matches timeline.

## Create the next spec folder

From repo root:

```bash
make spec-new SLUG=my-feature-title
# optional: TITLE="Human readable title"
```

Or:

```bash
bash scripts/spec-create.sh my-feature-title "Optional Title"
```

## Put specs under `api/specs` or `mobile/specs`

```bash
SPEC_ROOT=api/specs make spec-new SLUG=login-endpoints
```

Same structure inside that directory.

## Fill requirements with high confidence

1. Run **`make spec-elicit`** and paste into Cursor **with your idea** (and the path to `specs/NNN-slug/` after `spec-new`).
2. The AI asks up to **20 clarifying questions** until requirements are ~98% clear, then fills **SPEC / PLAN / TASKS / PROGRESS** for that folder.

## Relationship to global planning

- **`docs/planning/`** — whole-product master plan.
- **`specs/NNN-*`** — one increment (feature/fix) with full traceability.

## When the increment is “done”

Before merge, walk **`docs/DEFINITION_OF_DONE.md`** (or **`make dod`**) so tests, security, review, and **`PROGRESS.md`** are complete.
