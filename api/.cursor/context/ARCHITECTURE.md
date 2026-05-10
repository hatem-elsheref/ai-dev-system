# AI Dev System Architecture

## Intent
`ai-dev-system` is a reusable repository template for AI-assisted SaaS development with:
- Laravel API
- MySQL
- React SPA
- React Native (optional)

## Layers
1. **Control layer**: `.cursor/rules/` governs AI behavior and coding standards.
2. **Generation layer**: `.cursor/prompts/` produces architecture, specs, modules, and tasks.
3. **Knowledge layer**: `PROJECT_BRAIN.md` acts as persistent project memory.
4. **Documentation layer**: `docs/` stores generated and curated technical artifacts.

## Delivery principle
Generate docs and architecture first, then implementation tasks, then code.
