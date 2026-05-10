.PHONY: init bootstrap help verify dod \
	stakeholder-brd ba-kickoff generate-docs full-plan planning-scaffold \
	spec-new spec-elicit \
	security-review quality-review progress feature-check reviewers-doc contract-add \
	deploy nginx-test supervisor-reload ops-copy ops-help

ROOT := $(CURDIR)
PROMPTS := $(ROOT)/.cursor/prompts

help:
	@echo "Available commands:"
	@echo "  make init              - bootstrap folders and seed api/.cursor + api-contract templates"
	@echo "  make bootstrap         - alias for init"
	@echo "  make security-review   - print security-review prompt (paste into Cursor)"
	@echo "  make quality-review    - print code-quality-review prompt"
	@echo "  make progress          - print development-progress prompt"
	@echo "  make feature-check     - print feature-add-check prompt"
	@echo "  make reviewers-doc     - print reviewers-doc prompt"
	@echo "  make contract-add      - add endpoint stub to api-contract/contracts/API_ENDPOINTS.md"
	@echo "  make stakeholder-brd   - print BA/PO prompt: vague idea -> BRD (alias: ba-kickoff)"
	@echo "  make generate-docs     - print one-shot: project analysis + BRD (paste into Cursor)"
	@echo "  make full-plan         - print spec-kit++ deep plan: master/impl/tasks/progress (paste into Cursor)"
	@echo "  make planning-scaffold - create docs/planning/*.md from templates"
	@echo "  make spec-new SLUG=x [TITLE=\"...\"] [SPEC_ROOT=specs] - next specs/NNN-slug folder"
	@echo "  make spec-elicit        - print prompt: up to 20 questions then SPEC/PLAN/TASKS/PROGRESS"
	@echo "  make deploy            - run deploy script (set APP_DIR to Laravel root on server)"
	@echo "  make nginx-test        - print nginx test + reload commands"
	@echo "  make supervisor-reload - print supervisor reread/update commands"
	@echo "  make ops-copy          - copy ops templates (use: make ops-copy DEST=./deploy/ops)"
	@echo "  make ops-help          - ops.sh usage"
	@echo "  make verify            - sanity-check template files and prompts"
	@echo "  make dod               - print Definition of Done merge checklist (docs/DEFINITION_OF_DONE.md)"

init:
	@bash scripts/init.sh

bootstrap: init

verify:
	@bash scripts/verify.sh

dod:
	@cat "$(ROOT)/docs/DEFINITION_OF_DONE.md"

security-review:
	@echo "--- Security review prompt (.cursor/prompts/security-review.md) ---"
	@cat "$(PROMPTS)/security-review.md"

quality-review:
	@echo "--- Code quality review prompt (.cursor/prompts/code-quality-review.md) ---"
	@cat "$(PROMPTS)/code-quality-review.md"

progress:
	@echo "--- Development progress prompt (.cursor/prompts/development-progress.md) ---"
	@cat "$(PROMPTS)/development-progress.md"

feature-check:
	@echo "--- Feature add check prompt (.cursor/prompts/feature-add-check.md) ---"
	@cat "$(PROMPTS)/feature-add-check.md"

reviewers-doc:
	@echo "--- Reviewers doc prompt (.cursor/prompts/reviewers-doc.md) ---"
	@cat "$(PROMPTS)/reviewers-doc.md"

stakeholder-brd:
	@echo "--- Stakeholder interview -> BRD (.cursor/prompts/stakeholder-brd.md) ---"
	@cat "$(PROMPTS)/stakeholder-brd.md"

ba-kickoff: stakeholder-brd

generate-docs:
	@echo "--- One-shot: analysis + BRD (.cursor/prompts/generate-docs.md) ---"
	@cat "$(PROMPTS)/generate-docs.md"

full-plan:
	@echo "--- Full plan: master + implementation + tasks + progress (.cursor/prompts/full-project-plan.md) ---"
	@cat "$(PROMPTS)/full-project-plan.md"

planning-scaffold:
	@bash scripts/planning-scaffold.sh

spec-new:
	@test -n "$(SLUG)" || (echo "Usage: make spec-new SLUG=short-name [TITLE=\"My title\"] [SPEC_ROOT=specs]" && false)
	@bash scripts/spec-create.sh "$(SLUG)" "$(TITLE)"

spec-elicit:
	@echo "--- Spec elicitation: questions then fill SPEC/PLAN/TASKS/PROGRESS (.cursor/prompts/spec-elicit.md) ---"
	@cat "$(PROMPTS)/spec-elicit.md"

contract-add:
	@bash scripts/contract-add.sh

deploy:
	@bash scripts/ops.sh deploy

nginx-test:
	@bash scripts/ops.sh nginx-test

supervisor-reload:
	@bash scripts/ops.sh supervisor-reload

ops-copy:
	@test -n "$(DEST)" || (echo "Usage: make ops-copy DEST=./deploy/ops" && false)
	@bash scripts/ops.sh ops-copy "$(DEST)"

ops-help:
	@bash scripts/ops.sh help
