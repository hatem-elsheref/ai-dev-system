# Full project plan (spec-kit inspired, Laravel SaaS extended)

You are a **staff product manager + staff architect**. Goal: produce planning artifacts **richer than** the default [GitHub spec-kit](https://github.com/github/spec-kit) flow (`constitution` → `specify` → `plan` → `tasks` → `implement`) by adding **stack-specific depth**, **API contract traceability**, **security/ops gates**, and a **living progress ledger**.

## Inputs (must read)

1. `PROJECT_BRAIN.md` — problem, KPIs, MVP, non-goals, personas  
2. `ARCHITECTURE.md` — if empty, propose one  
3. `api-contract/contracts/API_ENDPOINTS.md` — note gaps as you design APIs  
4. Stack rules in `STACK_RULES.md` / `docs/guides/laravel-backend-bible.md`

## What to produce (four coordinated outputs)

Generate content suitable for saving as:

### A) `docs/planning/MASTER_PLAN.md`

- Executive summary tied to KPIs  
- In/out scope aligned with `PROJECT_BRAIN` non-goals  
- Phases (P0 discovery, P1 MVP, P2+) with **exit criteria**  
- Top 5 risks with mitigations  
- Links to B/C/D below  

### B) `docs/planning/IMPLEMENTATION_PLAN.md`

- Architecture/context diagram (mermaid optional)  
- Module boundaries (`api/` Laravel domains vs `frontend/` vs `mobile/`)  
- Key technical decisions table (options → choice → why)  
- Data model overview + indexing strategy  
- API versioning + contract ownership (`api-contract/`)  
- NFR: security, performance, observability (Horizon, Sentry, nginx from guides)  
- Open questions  

### C) `docs/planning/TASKS_DETAILED.md`

Go **deeper than typical spec-kit tasks**:

- Epics → Stories → **numbered tasks** `T-001…`  
- Each task row conceptually includes: **description**, **deps**, **`[P]` if parallelizable**, **touchpoints** (`api/...`, `frontend/...`, migrations), **contract stub id or path**, **DoD**  
- Explicit ordering: migrations → models → policies → services → controllers/resources → tests → frontend API client → UI  
- Include tasks for: translations (`lang/`), Form Requests, API Resources, feature tests, contract registry updates  
- Dependency graph (ASCII or mermaid)  
- Mark setup tasks (Sanctum, permissions, Redis queue) explicitly  

### D) `docs/planning/PROGRESS.md`

Initialize a **progress ledger**:

- Table: epic | status | % feel  
- Blockers section (empty or hypothesized)  
- **“Recent updates”** log with dated entries  
- Next 7 days checklist  

Set overall status to `in_progress` once planning is accepted.

## Rules

- Prefer **no code** in this pass — planning only unless asked.  
- Every endpoint batch must mention updating **`api-contract/contracts/API_ENDPOINTS.md`**.  
- Avoid nested translation keys; follow `docs/guides/laravel-translation-guide.md`.  
- Keep MVP thin; push extras to P2 with traceability to non-goals.

## After generation (tell the user)

1. Run `make planning-scaffold` if `docs/planning/` does not exist yet, then paste sections into the scaffolded files.  
2. Re-run `make progress` prompt periodically or edit `PROGRESS.md` after merges.  
3. Implement using task order in `TASKS_DETAILED.md`.

## Output format in chat

Use headings **A / B / C / D** matching the files above so the user can copy-paste into each file.
