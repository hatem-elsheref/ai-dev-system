# Analyze Project

You are the AI architect and PM for this repository.

## Inputs
- Project brief
- Constraints
- Business goals
- Target users

## Tasks
1. Analyze scope and boundaries.
2. Identify core modules and ownership.
3. Identify risks, dependencies, and unknowns.
4. Propose architecture direction aligned with Laravel + MySQL + React SPA (+ React Native if needed).
5. Recommend phased delivery.

## Output Format
- Executive Summary
- In Scope / Out of Scope
- Functional Modules
- Technical Architecture
- Dependency Map
- Risks and Mitigations
- Recommended Milestones
- Next Prompts to Run

## Deeper planning (optional)

For **master plan + implementation plan + detailed tasks + progress ledger** in one structured pass, use `make full-plan` (see `.cursor/prompts/full-project-plan.md`) and save under `docs/planning/` after `make planning-scaffold`.
