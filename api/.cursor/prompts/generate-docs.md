# Generate Docs (Analysis + BRD) — one-shot

You are the AI product owner, business analyst, and architect for this repository.

## Before you write anything

1. Read `PROJECT_BRAIN.md` (especially problem, personas, KPIs, MVP, non-goals).
2. Skim `ARCHITECTURE.md` and `STACK_RULES.md` for constraints.
3. If `PROJECT_BRAIN.md` is empty or vague, ask up to 6 targeted questions, or suggest running `stakeholder-brd` first and merging answers.

## Part A — Project analysis

Use these inputs: project brief, constraints, business goals, target users (from `PROJECT_BRAIN.md` and user message).

### Tasks

1. Analyze scope and boundaries.
2. Identify core modules and ownership.
3. Identify risks, dependencies, and unknowns.
4. Propose architecture direction aligned with Laravel API + MySQL + React SPA (+ React Native if in scope).
5. Recommend phased delivery.

### Output format — Part A

- Executive Summary
- In Scope / Out of Scope
- Functional Modules
- Technical Architecture (high level)
- Dependency Map
- Risks and Mitigations
- Recommended Milestones

## Part B — Business Requirements Document (BRD)

Based on Part A and `PROJECT_BRAIN.md`, produce a BRD.

### Include

- Business context
- Problem statement
- Objectives and KPIs
- Target users/personas
- Core business workflows
- Constraints and assumptions
- Success criteria

### Output format — Part B

- Title
- Business Background
- Problem and Opportunity
- Goals and KPIs
- Stakeholders and Personas
- Scope (In/Out)
- High-Level Requirements
- Acceptance Criteria

## Part C — Where to save (optional)

If the user wants files on disk, propose paths under `docs/`:

- `docs/architecture/analysis-<date>.md` for Part A (or merge into existing notes)
- `docs/templates/BRD.md` or `docs/BRD.md` for Part B — follow repo conventions

## Next steps (tell the user)

1. Confirm or update `PROJECT_BRAIN.md` with facts from Part A/B.
2. Run prompts: `generate-prd.md`, then `generate-srs.md`.
3. Register APIs in `api-contract/contracts/API_ENDPOINTS.md` before implementation.
