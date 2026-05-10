# Definition of Done — idea → implementation → tested → reviewed

Use this as the **merge gate** for every meaningful change (feature, refactor with risk, or fix). Adapt strictness to risk: **higher risk → every box;** trivial typo → subset.

**Quick command cheat sheet** (run from repo root):

| Phase | Commands / artifacts |
|-------|------------------------|
| Clarify idea | `make stakeholder-brd` → merge into `PROJECT_BRAIN.md` |
| Plan (whole product) | `make planning-scaffold` → `make full-plan` → `docs/planning/*.md` |
| Plan (one feature) | `make spec-new SLUG=…` → `make spec-elicit` → `specs/NNN-slug/*.md` |
| Ready to build? | `make feature-check` |
| API surface | `make contract-add` → `api-contract/contracts/API_ENDPOINTS.md` |
| Before merge | `make quality-review`, `make security-review`, `make reviewers-doc` |
| Full checklist | **`make dod`** (prints this file) or open this document |

---

## 1. Product & scope (what “done” means for users)

- [ ] **Problem and outcome** are written (who benefits, what changes when shipped).
- [ ] **Acceptance criteria** are testable (given / when / then or checklist).
- [ ] **Non-goals** and **out of scope** are explicit so scope creep is visible.
- [ ] Source of truth: **`PROJECT_BRAIN.md`** plus either **`docs/planning/`** (program-level) or **`specs/NNN-slug/SPEC.md`** (incremental).

If the idea was vague, run **`make stakeholder-brd`** before locking scope.

---

## 2. Specification & tasks (implementation-ready)

- [ ] **Tasks** exist with clear order and dependencies (`TASKS_DETAILED.md` or `specs/NNN-slug/TASKS.md`).
- [ ] **API changes** are listed before coding; new endpoints registered with **`make contract-add`** in **`api-contract/contracts/API_ENDPOINTS.md`**.
- [ ] **Auth / roles** state who may perform each action (or “public read-only,” etc.).
- [ ] **Failure cases** are considered (validation errors, 403/404, idempotency if relevant).

Optional gate before coding: **`make feature-check`**.

---

## 3. Implementation (clean, consistent, secure by default)

- [ ] Code follows **`.cursor/rules/`** and project guides (`CODING_RULES.md`, `STACK_RULES.md`, Laravel guides as applicable).
- [ ] **Inputs validated** (Form Requests / DTOs); **authorization** checked on every protected path.
- [ ] **No secrets** in code or logs; **prod defaults** respected (`APP_DEBUG`, HTTPS, CORS, rate limits where needed).
- [ ] **SQL** via parameterized queries / Eloquent; no raw concatenation of user input.

---

## 4. Testing (prove behavior matches spec)

- [ ] **Automated tests** cover acceptance criteria (unit/feature/API tests in `api/`, tests in `frontend/` / `mobile/` as applicable).
- [ ] **Manual smoke** walkthrough if automation cannot cover UI/device edge cases — document what was checked.
- [ ] **Regression**: existing critical paths still pass (CI or local suite).

---

## 5. Performance (when the feature touches hot paths or UI perceived speed)

- [ ] **Budget** stated (e.g. max queries per request, p95 latency target, or “no full-table scan”).
- [ ] **N+1** and obvious heavy loops addressed on paths that matter.
- [ ] **Frontend:** large lists/virtualization if needed; avoid useless re-renders on critical screens.

---

## 6. Code review & security review (human + AI-assisted)

- [ ] **`make quality-review`** — maintainability, boundaries, naming, duplication.
- [ ] **`make security-review`** — especially auth, input, uploads, payments, PII.
- [ ] **`make reviewers-doc`** — short brief for PR description so reviewers have context.
- [ ] Review feedback addressed or **explicitly** deferred with ticket/risk note.

---

## 7. Traceability & progress

- [ ] **`docs/planning/PROGRESS.md`** and/or **`specs/NNN-slug/PROGRESS.md`** updated (status, date, blockers cleared).
- [ ] PR description links **spec/plan/task** references so history is searchable.

---

## Done = merge allowed when

All sections **applicable to this change** are satisfied. For **small safe changes**, sections 5 (performance) may be “N/A” with a one-line rationale in the PR.

For the **full narrative** (workflows, all `make` targets), see **[USAGE.md](USAGE.md)**.
