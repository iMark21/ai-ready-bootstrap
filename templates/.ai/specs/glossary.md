# {{PROJECT_NAME}} — Glossary

Vocabulary shared across product, code, and contributor onboarding. If a term appears in specs/code/ADRs and isn't here, add it.

| Term | Definition |
|---|---|
| **Spec** | Document under `.ai/specs/` that is the source of truth for a product layer. Code that contradicts a spec must update the spec first. |
| **ADR** | Architecture Decision Record. Short document capturing an architectural decision and what was rejected. Format: lightweight MADR. |
| **SDD** | Spec-Driven Development. Discipline in which the spec precedes the code and governs the tests. Enforced by `pre-commit-spec-check.sh`. |
| **Story ({{STORY_PREFIX}}-NNN)** | A unit of work tracked in `BACKLOG.md`. One story = one acceptance feature. |
| **Acceptance** | A `.feature` file in Gherkin defining the verifiable expected behaviour for a story. Lives in `.ai/specs/acceptance/`. |
| **(Your domain term)** | (Definition. Add one per non-obvious term used in this project.) |
