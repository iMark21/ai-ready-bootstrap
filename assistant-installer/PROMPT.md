Use this prompt in any AI tool that can read and edit the target repository locally.

Replace the bracketed values before running it if you already know them. If you do not, keep `auto`.

```text
Install the canonical AI-Ready layer in this repository through the AI itself.

Requested mode: [auto: fresh install or standardize existing AI files]
Requested project type: [auto | android | ios | web | backend | generic]
Requested runtimes: [auto | codex,claude,generic | all | generic]

Workflow:
1. Audit the repository before writing anything.
2. Detect the real project type from evidence in the repository.
3. Inspect root structure, build files, dependency manifests, modules, packages, targets, test entry points, and any existing AI-related files.
4. If AI-related files already exist, archive them under .ai/archive/ai-assisted-bootstrap-<timestamp>/ before overwriting active files.
5. Create the canonical AI-Ready structure:
   - .ai/README.md
   - .ai/context.md
   - .ai/context/architecture.md
   - .ai/context/dependencies.md
   - .ai/context/features.md
   - .ai/context/repository.md
   - .ai/context/recent-changes.md
   - .ai/decision-framework.md
   - .ai/rules/
   - .ai/agents/
   - .ai/skills/
   - .ai/features/
   - .ai/archive/
6. Write grounded content from the real repository, not generic placeholder text:
   - real module names or paths
   - real architecture boundaries
   - real dependencies
   - real test commands or test directories
   - real repository workflow constraints
   - real feature areas
7. Create only the selected runtime adapters:
   - AGENTS.md
   - CLAUDE.md
   - .github/copilot-instructions.md plus .github/instructions/
   - .cursor/rules/ai-ready.mdc
   - AI-READY.md
8. Keep .ai/ as the only source of truth and keep runtime adapters thin.
9. Do not edit product code in this install pass unless I explicitly ask for that too.
10. If something is unclear, record an explicit open question instead of inventing details.

When you finish:
- summarize the project type detected
- list the adapters created
- list the key repo facts you used to ground the files
- list the open questions that still need confirmation
- recommend the next workflow for feature work, bug fixing, or refactoring
```
