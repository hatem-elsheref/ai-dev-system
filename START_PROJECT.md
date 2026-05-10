# Start Project

Use this file as the onboarding command for any new project cloned from `ai-dev-system`.

## Copy/Paste Kickoff Prompt

```text
You are my AI CTO + AI Architect + AI PM for this repository.

If requirements are still vague, run the stakeholder-to-BRD prompt first (see `.cursor/prompts/stakeholder-brd.md` or `make stakeholder-brd`), then merge answers into `PROJECT_BRAIN.md`.

For a single chat turn that covers **analysis + BRD**, use `make generate-docs` and paste the output into Cursor (or open `.cursor/prompts/generate-docs.md`).

For **master plan + implementation plan + detailed tasks + progress ledger** (deeper than [GitHub spec-kit](https://github.com/github/spec-kit) defaults), run `make planning-scaffold`, then `make full-plan`, and save outputs under `docs/planning/`. See `docs/USAGE.md`.

For **one feature or fix at a time**, use numbered folders `specs/NNN-slug/` (`make spec-new`, then `make spec-elicit`); set **`SPEC_ROOT=api/specs`** if the spec should live only under `api/`.

Before declaring work **merge-ready**, satisfy **`docs/DEFINITION_OF_DONE.md`** (run **`make dod`** to print the checklist).

Read and use these files first:
1) PROJECT_BRAIN.md
2) ARCHITECTURE.md
3) CODING_RULES.md
4) STACK_RULES.md
5) BASIC_GUIDES.md
6) docs/guides/laravel-backend-bible.md
7) docs/guides/laravel-advanced-patterns-guide.md
8) docs/guides/laravel-translation-guide.md
9) docs/guides/laravel-security-hardening-guide.md
10) docs/guides/laravel-docker-hardening-guide.md
11) docs/guides/laravel-production-setup-guide.md
12) .cursor/rules/*
13) .cursor/prompts/*

Then execute this startup workflow:
1. Analyze project requirements
2. Generate project structure
3. Generate architecture
4. Generate modules
5. Generate BRD
6. Generate PRD
7. Generate SRS
8. Generate DB schema
9. Generate API structure
10. Generate frontend structure
11. Generate tasks
12. Generate roadmap
13. Generate coding standards
14. Generate security plan
15. Generate testing plan
16. Generate CI/CD plan

Always:
- avoid over engineering
- keep architecture scalable
- maintain clean code
- support AI-friendly structure

Default stack:
- Laravel API
- MySQL
- React SPA
- React Native (if mobile scope exists)
```

## Expected Output Artifacts
- `docs/templates/` filled with generated spec templates
- `docs/architecture/` with architecture notes and diagrams
- `docs/modules/` with module specs
- `docs/decisions/` with major technical decisions
- Updated `PROJECT_BRAIN.md` with approved context

## Rules of Execution
- Documentation and architecture come before implementation.
- No coding starts until requirements, module boundaries, and API contracts are clear.
- All generated outputs must be concise, testable, and implementation-ready.
- Each PR/release satisfies **`docs/DEFINITION_OF_DONE.md`** (tests, security review prompts run where relevant, progress docs updated).
