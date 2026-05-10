# Stakeholder Interview to BRD

Use when the idea is still vague. Act as a senior business analyst and product owner.

## Inputs (paste anything you have)

- Rough idea or pitch
- Who pays and who uses
- Constraints (time, budget, compliance)
- Competitors or manual process today

## Your tasks

1. Ask concise clarifying questions only where gaps block a BRD (max 8 questions).
2. Infer draft personas, jobs-to-be-done, and success metrics where reasonable; label assumptions clearly.
3. Produce a **BRD** aligned with `PROJECT_BRAIN.md` sections (problem, users, KPIs, MVP, non-goals).
4. List **open decisions** the human must confirm before PRD/architecture.

## Output format

### Clarifying questions (if needed)

- Numbered list or "None — sufficient context."

### Executive summary

- 5–8 bullets

### Problem and opportunity

- Problem statement
- Why now

### Target users and personas

- Persona name, goal, frustration, success criteria

### Competitors and alternatives

- Table: option | pros | cons | our differentiation

### Business goals and success metrics (KPIs)

- North-star metric
- 3–5 supporting KPIs with how measured

### MVP scope (must ship)

- Bullet list with acceptance themes

### Non-goals (explicit out of scope)

- Bullet list

### Risks and assumptions

- Risks with mitigation
- Assumptions to validate

### Stakeholders

- Role | interest | decision power

### Recommended next steps

1. Update `PROJECT_BRAIN.md` with confirmed facts
2. Run `generate-prd.md` then `generate-srs.md`
3. Capture API contracts in `api-contract/contracts/API_ENDPOINTS.md`
