# Planning artifacts (spec-kit++ style)

These templates mirror the spirit of [GitHub spec-kit](https://github.com/github/spec-kit) (constitution → specify → plan → tasks → implement) but add **deeper execution artifacts** for this stack:

- Explicit **Laravel / MySQL / React / React Native** mapping
- **API contract** traceability (`api-contract/contracts/API_ENDPOINTS.md`)
- **Security, i18n, and ops** checkpoints in tasks
- A living **PROGRESS** ledger you update after each milestone

## Files (copy into `docs/planning/` per project or feature)

| File | Purpose |
|------|---------|
| `MASTER_PLAN.md` | North-star: scope, phases, links to other artifacts |
| `IMPLEMENTATION_PLAN.md` | Technical phases, stack choices, risks, milestones |
| `TASKS_DETAILED.md` | Granular tasks with IDs, deps, `[P]` parallel, files, DoD |
| `PROGRESS.md` | Status table, % complete, blockers, last updated |

## Workflow

1. Run `make full-plan` (or open `.cursor/prompts/full-project-plan.md`) and paste into Cursor after filling `PROJECT_BRAIN.md`.
2. Run `make planning-scaffold` to create `docs/planning/` from templates (then merge AI output).
3. Update `PROGRESS.md` after each sprint or merged PR.
