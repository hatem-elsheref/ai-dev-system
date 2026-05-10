# Documentation index

- **[USAGE.md](USAGE.md)** — **Start here:** **Quick start (share with anyone)**, then full commands, prompts, rules, workflows, output formats.
- **[DEFINITION_OF_DONE.md](DEFINITION_OF_DONE.md)** — **Merge gate:** product → implementation → tests → performance → security → review (`make dod`).
- **Guides** (`guides/`) — Laravel backend, security, Docker, production, i18n.
- **Templates** (`templates/`) — Ops configs, API contract snippets, **planning** (spec-kit++), **incremental feature specs** (`templates/spec-feature/` — used by `make spec-new`).
- **Planning** (`planning/`) — your project’s `MASTER_PLAN`, `IMPLEMENTATION_PLAN`, `TASKS_DETAILED`, `PROGRESS` (scaffold with `make planning-scaffold`).
- **`specs/`** (repo root or under `api/` via **`SPEC_ROOT`**) — numbered folders `NNN-slug/` with `SPEC`, `PLAN`, `TASKS`, `PROGRESS` per feature or fix.
