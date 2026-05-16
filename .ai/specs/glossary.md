# sdd-harness — Glossary

Vocabulary shared across product, code, and contributor onboarding. If a term appears in specs/code/ADRs and isn't here, add it.

| Term | Definition |
|---|---|
| **Spec** | Document under `.ai/specs/` that is the source of truth for a product layer. Code that contradicts a spec must update the spec first. |
| **ADR** | Architecture Decision Record. Short document capturing an architectural decision and what was rejected. Format: lightweight MADR. |
| **SDD** | Spec-Driven Development. Discipline in which the spec precedes the code and governs the tests. Enforced by `pre-commit-spec-check.sh`. |
| **Story (SH-NNN)** | A unit of work tracked in `BACKLOG.md`. One story = one acceptance feature. |
| **Acceptance** | A `.feature` file in Gherkin defining the verifiable expected behaviour for a story. Lives in `.ai/specs/acceptance/`. |
| **Harness** | A set of automation, gates, and conventions that disciplines development without prescribing architecture. sdd-harness is itself an example of a harness. |
| **Runtime-agnostic AI layer** | The `.ai/` directory plus root-level pointer files (`CLAUDE.md`, `AGENTS.md`). Any AI runtime reads `.ai/` for instructions; no AI-specific files inside `.ai/`. See ADR 0008. |
| **Command** | A reusable workflow defined in `.ai/commands/<name>.md`. Invoked by a human or AI to drive a repeatable step (e.g. `spec`, `story`, `implement`, `verify`, `review`, `release`). |
| **Agent** | A reusable role/persona declared in `.ai/agents/<name>.md`. The AI assumes this role for specific review or analysis tasks. |
| **Hook** | A shell script under `.ai/hooks/` wired into Git or CI to enforce a gate (e.g. spec-check on commit). |
| **Implementation surface** | Tracked paths that the SDD hook treats as feature implementation requiring a spec or ADR touch. A path is protected when it matches `SH_CODE_GLOBS` and does not match `SH_CODE_EXCLUDE_GLOBS`. |
| **Code globs** | The include/exclude path patterns declared in `.ai/hooks/config.sh` that define the implementation surface. Per-project tunable. |
| **Drift** | When the implementation diverges from the spec. SDD treats drift as a process failure: the spec is updated first, then code follows. |
| **Phase (F0..FN)** | A named milestone in the project plan. Each phase closes with `CONTEXT.md` updated to reflect what's done and what's next. |
| **Governance mirror** | The practice of updating `CONTEXT.md` at every phase close to keep the living state of the project legible to humans and AIs. Implementation lands in F3. |
