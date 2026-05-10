# ai-dev-system

`ai-dev-system` is a reusable AI-native engineering template for building scalable SaaS products with Laravel, MySQL, React SPA, and React Native.

**Full how-to (commands, features, workflows, shareable quick start):** [docs/USAGE.md](docs/USAGE.md) — start at **“Quick start (read this first)”**.

## What this template gives you
- Cursor rules that enforce clean architecture and production-ready patterns.
- Reusable AI prompts for project analysis and spec generation (including BA/PO-style stakeholder → BRD).
- A **Definition of Done** merge checklist ([`docs/DEFINITION_OF_DONE.md`](docs/DEFINITION_OF_DONE.md)) — print with **`make dod`** — from product intent through tests, performance, security, and review.
- A project brain memory file for long-term context.
- A deterministic startup workflow for new projects.
- Basic implementation guides for day-to-day coding decisions.

## Phase 1 content
- Repository structure scaffold
- `.cursor/rules/` standards
- `.cursor/prompts/` templates
- `PROJECT_BRAIN.md`
- `START_PROJECT.md`

## Quick start
1. Clone this repository.
2. Open it in Cursor.
3. Run `./init` (or `make init`) to scaffold project folders and seed backend AI context.
4. Copy your requirements into `PROJECT_BRAIN.md`.
5. Run the instructions from `START_PROJECT.md`.
6. Review generated docs, architecture, tasks, then start implementation.

## Bootstrap commands
- `./init`: creates `api`, `frontend`, `api-contract`, `mobile` and seeds `api/.cursor`.
- `make init`: same as `./init`.
- `make help`: shows available command shortcuts.
- `make verify`: sanity-checks required files, guides, prompts, and rules (warnings if `api/.cursor` is stale — run `./init` again to refresh).

## Health check (after clone or big edits)

1. `make verify` — should end with `[verify] OK`.
2. If you see a warning about `api/.cursor`, run `./init` once to resync prompts/rules into `api/`.
3. Open this repo root in Cursor so `.cursor/rules` applies globally.

## Workflow commands (prompts + contracts)
Print a prompt to paste into Cursor, or append an API stub to the registry.

| Command | What it does |
|--------|----------------|
| `make dod` | Prints **`docs/DEFINITION_OF_DONE.md`** — merge gate before PR/release |
| `make security-review` | Prints `.cursor/prompts/security-review.md` |
| `make quality-review` | Prints `.cursor/prompts/code-quality-review.md` |
| `make progress` | Prints `.cursor/prompts/development-progress.md` |
| `make feature-check` | Prints `.cursor/prompts/feature-add-check.md` |
| `make reviewers-doc` | Prints `.cursor/prompts/reviewers-doc.md` |
| `make stakeholder-brd` / `make ba-kickoff` | BA/PO prompt: vague idea → structured BRD (fill `PROJECT_BRAIN.md` after) |
| `make generate-docs` | One paste: project analysis + BRD (see `.cursor/prompts/generate-docs.md`) |
| `make contract-add` | Runs `scripts/contract-add.sh` (interactive by default) |

**Contract registry:** `api-contract/contracts/API_ENDPOINTS.md`

**Non-interactive contract stub:**
```bash
bash scripts/contract-add.sh POST /api/v1/orders "Create order" sanctum
```

## Ops commands (deploy + server hints)

Use on the machine where Laravel runs (set `APP_DIR` to your app root).

| Command | What it does |
|--------|----------------|
| `make deploy` | Runs `docs/templates/ops/deploy/production-deploy.sh` (requires `APP_DIR`) |
| `make nginx-test` | Prints `nginx -t` + reload commands |
| `make supervisor-reload` | Prints `supervisorctl reread/update` commands |
| `make ops-copy DEST=./deploy/ops` | Copies `docs/templates/ops/` into `DEST` for editing and installing |
| `make ops-help` | Shows `scripts/ops.sh` usage |

**Deploy example:**
```bash
APP_DIR=/var/www/myapp make deploy
```

**Shell entrypoint:** `bash scripts/ops.sh help`

## Directory map
- `docs/USAGE.md`: **complete usage guide** — table of all commands, prompts, and recommended flows
- `docs/DEFINITION_OF_DONE.md`: **merge checklist** (idea → tests → performance → security → review); **`make dod`**
- `.cursor/rules/`: AI behavior and code standards
- `.cursor/prompts/`: generation prompts for analysis/docs
- `docs/`: generated and curated project documents
- `docs/guides/`: focused implementation guides (including Laravel translations)
- `docs/templates/ops/`: ready-to-copy production ops templates (Supervisor, Nginx, Cron, deploy script)
- `docs/templates/api-contract/`: endpoint contract templates
- `docs/templates/planning/`: master plan, implementation plan, detailed tasks, progress ledger (spec-kit++ style)
- `docs/planning/`: filled planning artifacts (`make planning-scaffold`, then `make full-plan`)
- `specs/NNN-slug/`: incremental feature specs — `SPEC`, `PLAN`, `TASKS`, `PROGRESS` (`make spec-new`, then `make spec-elicit`)
- `scripts/`, `tools/`, `hooks/`: reserved for automation phases

## Basic guides
- Read and follow `BASIC_GUIDES.md` for baseline coding behavior.
- Treat `CODING_RULES.md` + `STACK_RULES.md` + `BASIC_GUIDES.md` as the default implementation policy set.
- For Laravel specifics, use:
  - `docs/guides/laravel-backend-bible.md`
  - `docs/guides/laravel-advanced-patterns-guide.md`
  - `docs/guides/laravel-translation-guide.md`
  - `docs/guides/laravel-security-hardening-guide.md`
  - `docs/guides/laravel-docker-hardening-guide.md`
  - `docs/guides/laravel-production-setup-guide.md`

## Publish to GitHub
1. Create a new GitHub repository named `ai-dev-system`.
2. Initialize git locally (if needed), commit this template, and set `origin`.
3. Push the default branch.
4. Clone this template repository for each new project.

## Next phase (optional)
- Add Husky hooks (lint, tests, formatting, secret scanning)
- Add GitHub Actions (lint, tests, security scans)
- Add Playwright and CI quality gates
- Add CodeRabbit PR review automation
