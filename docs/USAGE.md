# How to use ai-dev-system

This document explains the **recommended workflows**, **every command**, and **how the pieces fit together** so you get consistent AI output and clean engineering.

## Quick start (read this first — share with your team)

### What this is

**ai-dev-system** is a **template repository** for building SaaS products with **Laravel API, MySQL, React SPA, and optional React Native**, with **Cursor rules**, **reusable AI prompts**, **architecture guides**, and **command shortcuts** (`make …`) so the AI behaves like a disciplined PM, architect, and senior engineer.

It does **not** run a server by itself. You clone it, open it in **Cursor**, and work **in chat + markdown files** in the repo.

### Why it is useful

- **Consistent quality:** rules enforce clean Laravel patterns, security, i18n, and ops baselines.
- **Docs before code:** prompts help you produce analysis, BRD/PRD/SRS, plans, and **detailed tasks** (similar in spirit to [GitHub spec-kit](https://github.com/github/spec-kit), extended for this stack + API contracts).
- **Traceability:** API shapes live in `api-contract/`; planning lives in `docs/planning/`.
- **Repeatable setup:** `./init` scaffolds `api/`, `frontend/`, `api-contract/`, `mobile/` and syncs rules into `api/.cursor/`.

### Step-by-step playbook (idea → merge)

Follow these phases in order. They match the **Product delivery pipeline** and workflow **H** later in this file.

**1. First time after clone**

- Open the **repository root** in Cursor so **`.cursor/rules/`** loads.
- Run **`./init`** (or **`make init`**), then **`make verify`** — you should see **`[verify] OK`**.
- Fill **`PROJECT_BRAIN.md`**: problem, users, MVP, **non-goals**, KPIs.

**2. Turn the idea into something you can build**

- **Still vague?** Run **`make stakeholder-brd`**, paste into Cursor, then merge answers into **`PROJECT_BRAIN.md`**.
- **Whole-product planning:** **`make planning-scaffold`** → **`make full-plan`** → save outputs under **`docs/planning/*.md`**.
- **One feature or fix (recommended for steady delivery):** **`make spec-new SLUG=short-name`** (optional **`TITLE="…"`**) → **`make spec-elicit`** → paste into Cursor **with** (a) the path to **`specs/NNN-slug/`**, (b) a short description → answer questions (up to **20**) → save **SPEC / PLAN / TASKS / PROGRESS** into that folder.
- **Specs only under Laravel:** **`SPEC_ROOT=api/specs make spec-new SLUG=…`** (same flow).

**3. Before you write a lot of code**

- Optional gate: **`make feature-check`** (“ready to build?”).
- **New API endpoints:** **`make contract-add`** so **`api-contract/contracts/API_ENDPOINTS.md`** is updated **before** you implement controllers.

**4. Build and test**

- Implement in **`api/`**, **`frontend/`**, **`mobile/`** following your **TASKS** and **`.cursor/rules/`**.
- Add or update **tests** until acceptance criteria pass; use **manual** checks where automation cannot cover the surface.

**5. Before merge or release**

- **`make dod`** — walk the checklist in **`docs/DEFINITION_OF_DONE.md`**.
- **`make quality-review`**, **`make security-review`**, **`make reviewers-doc`** — paste into Cursor with your **diff** or file paths and PR intent.
- Update **`docs/planning/PROGRESS.md`** and/or **`specs/NNN-slug/PROGRESS.md`**.

**6. Reference**

- **This document** — full **`make`** table, prompt library, workflows **A–H**, troubleshooting.
- **`docs/DEFINITION_OF_DONE.md`** — merge gate (same content as **`make dod`**).
- **`START_PROJECT.md`** — long greenfield kickoff prompt for Cursor.

### How to start (10 minutes)

1. **Clone** this repository and open the **repo root** in Cursor (so `.cursor/rules` applies).
2. Run **`./init`** (or `make init`), then **`make verify`** — you should see `[verify] OK`. If you see a warning about `api/.cursor`, run **`./init`** again.
3. **Edit `PROJECT_BRAIN.md`** with your product: problem, users, KPIs, MVP, **non-goals** (this is *your* source of truth; the AI does not write it until you ask it to help draft).
4. **Optional — vague idea?** Run **`make stakeholder-brd`**, paste into Cursor, then merge answers into `PROJECT_BRAIN.md`.
5. **Planning pass:** run **`make planning-scaffold`**, then **`make full-plan`**, paste into Cursor, and copy the result into `docs/planning/*.md` (or ask the agent to update those files).
6. **Lighter pass:** run **`make generate-docs`** for **analysis + BRD** in one chat if you do not need the full four-file plan yet.
7. **New endpoint:** use **`make contract-add`** to append a row to `api-contract/contracts/API_ENDPOINTS.md` before coding.
8. **Implement** in `api/` (Laravel), `frontend/`, `mobile/` as needed, following your tasks and contracts.
9. **Update `docs/planning/PROGRESS.md`** as you finish work (status, blockers, dates).
10. **For one feature or fix (incremental spec):** run **`make spec-new SLUG=short-name`**, then **`make spec-elicit`**, paste into Cursor with the **path to `specs/NNN-slug/`** and your idea — the AI asks up to **20 questions**, then you save the generated **SPEC / PLAN / TASKS / PROGRESS** into that folder. Use **`SPEC_ROOT=api/specs`** if the spec should live under `api/` only.
11. **Before merge / release:** walk **`docs/DEFINITION_OF_DONE.md`** (or run **`make dod`** in the repo root) so testing, performance (when relevant), security, and review are satisfied.
12. **After template changes** from upstream, run **`make verify`** and **`./init`** to refresh `api/.cursor` copies.

### What fills in automatically vs what you do

| Item | Filled by |
|------|-----------|
| Rules, prompts, guides in the repo | **Template** (already on disk) |
| `PROJECT_BRAIN.md` | **You** (or you ask Cursor to **draft** it from a description, then you **save** the file) |
| Text from `make generate-docs` / `make full-plan` / other prompts | **AI in chat** — you **copy** into `docs/` and `docs/planning/`, or instruct the agent to **edit files** |
| `api-contract/contracts/API_ENDPOINTS.md` | **You** + **`make contract-add`** (or paste from AI) |
| Laravel/React code | **You** (with AI assistance) following the plan |

**Nothing** updates disk **by itself** unless you **save** or the agent **applies** an edit. Treat chat output as a draft until it lives in the repo files.

### Output formats (what you should expect)

Prompts are designed so the model returns **structured Markdown**:

| Output | Typical sections / format |
|--------|---------------------------|
| Analysis (`analyze-project`, part of `generate-docs`) | Executive summary, in/out scope, modules, architecture notes, risks, milestones |
| BRD (`generate-brd`, part of `generate-docs`) | Background, problem, goals/KPIs, personas, scope, high-level requirements, acceptance criteria |
| Full plan (`full-plan`) | **A–D blocks:** `MASTER_PLAN`, `IMPLEMENTATION_PLAN`, `TASKS_DETAILED` (tasks `T-001…`, deps, `[P]`), `PROGRESS` ledger |
| Endpoint registry (`contract-add`) | Markdown sections per endpoint: method, path, auth, payload JSON, responses, status codes |
| Reviews (`security-review`, `quality-review`) | Findings by severity, fixes required |

Saved copies usually live under:

- `docs/planning/` — planning artifacts  
- `docs/architecture/`, `docs/modules/` — design notes  
- `api-contract/contracts/API_ENDPOINTS.md` — API registry  

Use **`make help`** to see all shortcuts.

---

## Principles (best results)

1. **Open the repository root in Cursor** so `.cursor/rules/` loads for the whole factory template.
2. **Fill `PROJECT_BRAIN.md` early** — problem, personas, KPIs, MVP, non-goals drive everything else.
3. **Docs before code** — use prompts to produce BRD/PRD/SRS and API contracts before implementation.
4. **Single source of truth for APIs** — register endpoints in `api-contract/contracts/API_ENDPOINTS.md` (use `make contract-add`).
5. **After template updates**, run `make verify`; if `api/.cursor` is stale, run `./init` again to resync rules and prompts into `api/`.
6. **Laravel work** — either open the repo root, or open `api/` as a folder; `api/.cursor` mirrors rules/guides so Cursor still has context.

### Product delivery pipeline (idea → tested → reviewed)

This template is built so you can run one **closed loop** from product intent to merge:

| Step | What | Commands / artifacts |
|------|------|----------------------|
| 1. Intent | Problem, users, MVP, non-goals | **`PROJECT_BRAIN.md`**; **`make stakeholder-brd`** if vague |
| 2. Plan | Whole program or one increment | **`make planning-scaffold`** + **`make full-plan`** → **`docs/planning/`** *or* **`make spec-new`** + **`make spec-elicit`** → **`specs/NNN-slug/`** |
| 3. Gate | Confirm ready to build | **`make feature-check`** |
| 4. Contracts | API shape before code | **`make contract-add`** → **`api-contract/contracts/API_ENDPOINTS.md`** |
| 5. Implement | Laravel / React / RN | Follow tasks + **`.cursor/rules/`** |
| 6. Test | Match acceptance criteria | Tests in **`api/`** / **`frontend/`** / **`mobile/`** + manual checks where needed |
| 7. Performance | Hot paths only | State budget; fix measured issues (N+1, slow queries, heavy UI) |
| 8. Review | Quality + security + PR clarity | **`make quality-review`**, **`make security-review`**, **`make reviewers-doc`** |
| 9. Traceability | Status visible | **`PROGRESS.md`** (planning and/or **`specs/NNN-slug/`**) |

**Merge gate (complete checklist):** **[DEFINITION_OF_DONE.md](DEFINITION_OF_DONE.md)** — print in terminal with **`make dod`**.

### Compared to GitHub spec-kit

[github/spec-kit](https://github.com/github/spec-kit) uses phases like constitution → specify → plan → tasks → implement via slash commands. **This template adds:**

| spec-kit idea | ai-dev-system equivalent |
|---------------|---------------------------|
| Feature spec | `PROJECT_BRAIN.md` + BRD/PRD prompts |
| Technical plan | `docs/planning/IMPLEMENTATION_PLAN.md` |
| tasks.md | `docs/planning/TASKS_DETAILED.md` (with Laravel layers, contract refs, `[P]` markers) |
| Status | `docs/planning/PROGRESS.md` (living ledger) |
| Implement | You implement in Cursor following tasks + `api-contract/` |

Use **`make planning-scaffold`** then **`make full-plan`** paste into Cursor for the deepest planning pass.

---

## Master command reference (`make` + scripts)

All commands are run from the **repository root** unless noted.

| Command | What it does | When to use |
|--------|----------------|-------------|
| `make help` | Lists all Make targets | Anytime you forget names |
| `./init` | Creates `api`, `frontend`, `api-contract`, `mobile`; copies `.cursor` rules/prompts into `api/.cursor`; seeds contracts | **Right after cloning** a new project copy |
| `make init` | Same as `./init` | Same |
| `make bootstrap` | Alias for `init` | Same |
| `make verify` | Checks required files, guides, prompts, rules; warns if `api/.cursor` needs refresh | After clone, pull, or editing template files |
| `make dod` | Prints **`docs/DEFINITION_OF_DONE.md`** (merge gate checklist) | Before PR / release |
| `make generate-docs` | Prints **analysis + BRD** prompt (one paste into Cursor) | When you want architecture + business doc in **one** chat |
| `make full-plan` | Prints **spec-kit++** prompt: master plan, implementation plan, **detailed tasks**, **progress ledger** | After `PROJECT_BRAIN.md` is filled — richer than default [spec-kit](https://github.com/github/spec-kit) task dumps |
| `make planning-scaffold` | Creates `docs/planning/*.md` from `docs/templates/planning/` | Before pasting AI output from `make full-plan` |
| `make spec-new SLUG=…` | Creates next **`specs/NNN-slug/`** with `SPEC`, `PLAN`, `TASKS`, `PROGRESS` | Each feature/fix increment (numbered automatically) |
| `make spec-elicit` | Prints prompt: **up to 20 questions** until ~98% clarity, then fills those four files | After `spec-new`, paste in Cursor with the folder path |
| `make stakeholder-brd` | Prints stakeholder interview → BRD prompt | When the idea is **vague** — questions + BRD-shaped output |
| `make ba-kickoff` | Alias for `make stakeholder-brd` | Same |
| `make security-review` | Prints security audit checklist prompt | Before merge or after sensitive changes |
| `make quality-review` | Prints maintainability/architecture review prompt | PR prep |
| `make progress` | Prints progress report prompt | Standups / status |
| `make feature-check` | Prints “ready to build feature?” gate prompt | Before starting a new feature |
| `make reviewers-doc` | Prints reviewer-focused summary prompt | PR description / reviewer notes |
| `make contract-add` | Runs `scripts/contract-add.sh` — append endpoint stub to registry | **Every new API endpoint** |
| `make deploy` | Runs production deploy script (**needs `APP_DIR`**) | On the **server** with Laravel installed |
| `make nginx-test` | Prints nginx test + reload commands | Server/nginx changes |
| `make supervisor-reload` | Prints supervisor reread/update commands | Worker config changes |
| `make ops-copy DEST=…` | Copies `docs/templates/ops/` to `DEST` | Customize nginx/supervisor/cron for your host |
| `make ops-help` | Prints `scripts/ops.sh` usage | Ops CLI reference |

### Scripts you can call directly

| Script | Purpose |
|--------|---------|
| `scripts/init.sh` | Same as `./init` |
| `scripts/verify.sh` | Same as `make verify` |
| `scripts/contract-add.sh` | Interactive or `METHOD PATH "NAME" [auth]` — updates `api-contract/contracts/API_ENDPOINTS.md` |
| `scripts/ops.sh` | `help`, `deploy`, `nginx-test`, `supervisor-reload`, `ops-copy <dir>` |
| `scripts/planning-scaffold.sh` | Creates `docs/planning/` Markdown files from templates | Same as `make planning-scaffold` |
| `scripts/spec-create.sh` | Next incremental folder under `SPEC_ROOT` (default `specs/`) | Same as `make spec-new` |

**Merge gate (not a script):** **`docs/DEFINITION_OF_DONE.md`** — same content as **`make dod`**.

**Incremental specs folder (optional `SPEC_ROOT`):**

```bash
make spec-new SLUG=user-profile TITLE="User profile API"
SPEC_ROOT=api/specs make spec-new SLUG=auth-endpoints
```

### Contract helper (non-interactive)

```bash
bash scripts/contract-add.sh POST /api/v1/orders "Create order" sanctum
```

### Deploy (server)

```bash
APP_DIR=/var/www/your-app make deploy
```

---

## Prompt library (`.cursor/prompts/`)

These files are **printed** by `make` targets above, or you can open them in the editor. Use them in Cursor by pasting content plus your context.

| Prompt file | Typical use |
|-------------|----------------|
| `generate-docs.md` | Analysis + BRD in one shot |
| `full-project-plan.md` | Master + implementation + detailed tasks + progress (spec-kit++) |
| `spec-elicit.md` | **Up to 20 questions** → then **SPEC, PLAN, TASKS, PROGRESS** for `specs/NNN-slug/` |
| `stakeholder-brd.md` | Vague idea → clarified BRD |
| `analyze-project.md` | Scope, modules, risks, milestones only |
| `generate-brd.md` | BRD only |
| `generate-prd.md` | PRD |
| `generate-srs.md` | SRS / requirements detail |
| `generate-feature.md` | Single feature spec |
| `generate-module.md` | Module boundary spec |
| `generate-api.md` | API design |
| `generate-db-schema.md` | MySQL schema design |
| `review-code.md` | General code review |
| `security-review.md` | Security-focused review |
| `code-quality-review.md` | Maintainability review |
| `feature-add-check.md` | Pre-build gate |
| `development-progress.md` | Progress snapshot |
| `reviewers-doc.md` | Reviewer notes |

---

## Cursor rules (`.cursor/rules/`)

Rules steer **how** the AI writes code (stack, security, Laravel patterns). They apply when Cursor loads the workspace. Key files:

| Rule file | Focus |
|-----------|--------|
| `general.mdc` | Clean code, no secrets in code, SOLID pragmatism |
| `ai-behavior.mdc` | Docs before code; tests and security after |
| `security.mdc` | OWASP-style baseline + prod defaults |
| `laravel-backend.mdc` | Domain structure, strict types, services/actions |
| `laravel-api.mdc` | Thin controllers, Form Requests, Resources |
| `laravel-i18n.mdc` | `__('file.key')`, flat keys |
| `laravel-advanced-patterns.mdc` | Auditing, settings, providers |
| `laravel-production-ops.mdc` | Deploy/cache/worker expectations |
| `mysql.mdc` | Indexes, N+1, FKs |
| `react-spa.mdc` | SPA structure and a11y |
| `react-native.mdc` | Mobile/API abstraction |

---

## Repository layout (what each folder is for)

| Path | Role |
|------|------|
| `.cursor/rules/` | AI behavior and standards |
| `.cursor/prompts/` | Copy/paste prompts for Cursor |
| `docs/guides/` | Deep guides (Laravel, security, Docker, production) |
| `docs/templates/ops/` | Nginx, Supervisor, cron, deploy script templates |
| `docs/templates/api-contract/` | Endpoint contract snippet template |
| `docs/templates/planning/` | MASTER / IMPLEMENTATION / TASKS / PROGRESS templates |
| `docs/planning/` | **Your** filled planning artifacts (created by `make planning-scaffold`) |
| `specs/NNN-slug/` | **Per-feature** `SPEC`, `PLAN`, `TASKS`, `PROGRESS` (created by `make spec-new`) |
| `api/` | Laravel API codebase (you create the app here) |
| `api/.cursor/` | **Copy** of rules/prompts + context for backend-focused workspaces |
| `frontend/` | React SPA |
| `mobile/` | React Native |
| `api-contract/` | Shared API contracts — **`contracts/API_ENDPOINTS.md` is the registry** |
| `scripts/` | `init`, `verify`, `contract-add`, `ops` |

---

## Recommended workflows

### A) Brand-new project (first day)

1. Clone template → open folder in Cursor (repo root).
2. `./init` → `make verify`.
3. Fill **`PROJECT_BRAIN.md`** (problem, KPIs, MVP, non-goals).
4. Run **`make generate-docs`** → paste into Cursor → save outputs under `docs/` as needed.
5. Follow **`START_PROJECT.md`** kickoff (PRD, SRS, schema, API structure, tasks).
6. Put Laravel in **`api/`**; register endpoints in **`api-contract/contracts/API_ENDPOINTS.md`**.

### B) Idea still fuzzy

1. **`make stakeholder-brd`** → paste → merge answers into **`PROJECT_BRAIN.md`**.
2. Then **`make generate-docs`** or individual **`generate-prd` / `generate-srs`** prompts.

### C) New API endpoint

1. **`make contract-add`** (or `bash scripts/contract-add.sh POST /api/v1/... "Name" sanctum`).
2. Implement in Laravel; keep response shapes aligned with the contract.

### D) Before merge / release

1. Walk the full checklist: **`docs/DEFINITION_OF_DONE.md`** or **`make dod`**.
2. **`make quality-review`** + **`make security-review`** (paste into Cursor with diff or file paths); **`make reviewers-doc`** for the PR body.
3. On this **template** repo only: **`make verify`** after merging template changes.

### E) Deep planning (richer than [spec-kit](https://github.com/github/spec-kit) defaults)

1. Fill **`PROJECT_BRAIN.md`** (KPIs, MVP, non-goals).
2. **`make planning-scaffold`** → creates `docs/planning/MASTER_PLAN.md`, `IMPLEMENTATION_PLAN.md`, `TASKS_DETAILED.md`, `PROGRESS.md`.
3. **`make full-plan`** → paste into Cursor → copy outputs into those files (replace placeholders).
4. Keep **`PROGRESS.md`** updated after each milestone or PR (blockers, % done, dated log).

### F) Server deploy

1. **`make ops-copy DEST=./deploy/ops`** → edit configs for your domain/paths.
2. On server: **`APP_DIR=/var/www/app make deploy`** (after SSL and `.env` are correct).

### G) One feature or bugfix (numbered spec folder)

1. **`make spec-new SLUG=my-change TITLE="Optional title"`** — creates `specs/NNN-my-change/` with four starter files (or set **`SPEC_ROOT=api/specs`** for Laravel-only layout).
2. **`make spec-elicit`** — paste into Cursor **with:** (a) path to that folder, (b) short intent (“add X”, “fix Y”).
3. Answer the AI’s questions (up to **20**) until it reports ~**98%** confidence.
4. Save or apply the four Markdown sections into **`SPEC.md`**, **`PLAN.md`**, **`TASKS.md`**, **`PROGRESS.md`** in that folder.
5. Implement following **`TASKS.md`**; update **`PROGRESS.md`** as you go.

### H) End-to-end: one feature from idea to merge

1. **`make spec-new SLUG=…`** → **`make spec-elicit`** → finalize **`specs/NNN-slug/`** (or use **`docs/planning/`** for program-sized work).
2. **`make feature-check`** → **`make contract-add`** for any new endpoints.
3. Implement in **`api/`** / **`frontend/`** / **`mobile/`** following **`TASKS.md`** and **`.cursor/rules/`**.
4. Add/update tests until acceptance criteria are covered.
5. If the feature is performance-sensitive, measure and fix hotspots (queries, payloads, UI lists).
6. **`make quality-review`**, **`make security-review`**, **`make reviewers-doc`** → open PR.
7. Satisfy **`docs/DEFINITION_OF_DONE.md`** — run **`make dod`** to print the checklist → merge.

---

## Troubleshooting

| Issue | What to do |
|-------|------------|
| AI ignores Laravel conventions | Confirm workspace root includes this repo; check `.cursor/rules`. |
| Rules missing under `api/` | Run `./init` again to refresh `api/.cursor`. |
| `make verify` warns about `api/.cursor` | Run `./init`. |
| `make deploy` fails locally | Deploy is meant for a machine where **`APP_DIR` exists** and Laravel is installed. |

---

## See also

- [`README.md`](../README.md) — short overview and quick links
- [`START_PROJECT.md`](../START_PROJECT.md) — full bootstrap prompt for Cursor
- [`PROJECT_BRAIN.md`](../PROJECT_BRAIN.md) — fill this first for product clarity
- [`DEFINITION_OF_DONE.md`](DEFINITION_OF_DONE.md) — merge gate checklist (**`make dod`**)
