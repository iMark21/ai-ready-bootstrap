# AI-Ready Bootstrap — Backlog

## In Progress

_None_

## Backlog

| ID | Task | Priority | Phase | Est | Notes |
| --- | --- | --- | --- | --- | --- |
| ARB-29 | PR3 — Positioning: agentlayer + OpenSpec coexistence section in README + `openspec/` detection in `audit` + tighten "canonical" language | P2 | Positioning | S | No `.ai/changes/` artifact introduced here. |
| ARB-30 | PR4 (optional) — Experiment: deterministic `agentlayer refresh` command + OpenSpec bridge via `.ai/changes/<slug>.md` | P3 | Product expansion | M | Only if ARB-28 validates the onboarding path. Re-evaluate after PR2/3 ship. |
| ARB-03 | Add config-file driven non-interactive setup and template overrides | P1 | Automation | M | Reduce CLI flag repetition |
| ARB-06 | Release automation + semantic versioning: git tags `vX.Y.Z`, GitHub Release creation on tag, tag-source-branch validation, tag/CHANGELOG/docs version coherence check, branch protection on `main`/`develop` | P1 | Distribution | M | Replaces previous informal scope. Stays behind ARB-27/28/29. |

## Done

| ID | Task | Completed | Branch |
| --- | --- | --- | --- |
| ARB-01 | Initial bootstrap CLI + README + MANUAL + workspace onboarding | 2026-04-16 | feature/ai-ready-bootstrap |
| ARB-02 | Publish standalone repo to GitHub (`main` + `develop`) | 2026-04-16 | feature/ai-ready-bootstrap |
| ARB-04 | Expand runtime coverage with explicit Cursor and generic adapters | 2026-04-16 | feature/ios-generic-runtime |
| ARB-05 | Extract to standalone local repo with Git config, hook path, and GitFlow branches | 2026-04-16 | feature/ai-ready-bootstrap |
| ARB-07 | Add GitHub Actions CI and set `develop` as the default branch | 2026-04-16 | feature/ai-ready-bootstrap |
| ARB-08 | Add iOS-first bootstrap flows, runtime diagrams, and post-install usage prompts | 2026-04-16 | feature/ios-generic-runtime |
| ARB-09 | Add external install flow and real end-to-end agent workflows to the docs | 2026-04-16 | feature/external-install-docs |
| ARB-10 | Add first-pass context bootstrap workflow so installed `.ai/context*` gets grounded from the real repo | 2026-04-16 | feature/context-bootstrap-workflow |
| ARB-11 | Add AI-assisted install path and simplify README landing around install choices and use cases | 2026-04-16 | feature/ai-install-paths |
| ARB-12 | Release `v0.1.0` on `main` and sync the release merge back into `develop` | 2026-04-16 | release/0.1.0 |
| ARB-13 | Clarify how to install the skill and add a ready-to-copy Codex add-on package | 2026-04-16 | docs/skill-install-addon |
| ARB-14 | Release `v0.1.1` on `main` and sync the release merge back into `develop` | 2026-04-16 | release/0.1.1 |
| ARB-15 | Polish the ES/EN LinkedIn launch copy so it is paste-ready for LinkedIn | 2026-04-17 | develop |
| ARB-16 | Create a dedicated A5 LinkedIn brochure and export flow separate from the longer manual PDF | 2026-04-17 | develop |
| ARB-17 | Refine the LinkedIn brochure around agents/skills messaging and fix PDF pagination/footer layout issues | 2026-04-17 | develop |
| ARB-18 | Public launch overhaul: CONTRIBUTING.md, CHANGELOG, CODE_OF_CONDUCT, SECURITY, GH templates — release v0.2.0 | 2026-04-16 | docs/public-launch-overhaul |
| ARB-19 | Rewrite README as scenario-driven guide with runtime-specific install blocks and real workflow examples — release v0.2.1 | 2026-04-16 | docs/readme-storytelling-v2 |
| ARB-20 | Rename generated agents from `proj-` prefix to `agent-` prefix across all templates — release v0.3.0 | 2026-04-16 | feat/rename-agents |
| ARB-21 | Collapse install section to one universal AI prompt that works with Codex, Claude, Copilot, Cursor — release v0.3.1 | 2026-04-16 | docs/unified-install |
| ARB-22 | Fix prompt blocking: require runtime selection before creating files; embed all adapter formats inline in PROMPT.md — release v0.3.2 | 2026-04-16 | fix/prompt-blocking-question |
| ARB-23 | PROMPT.md generates copy-paste-ready next-step prompts using real project context after install — release v0.3.3 | 2026-04-17 | fix/copy-paste-next-steps |
| ARB-24 | Remove SKILL.md and addon; PROMPT.md is the single universal installer — release v0.4.0 | 2026-04-17 | chore/remove-skill-addon |
| ARB-25 | Rename project to agentlayer; move GitHub repo to `iMark21/agentlayer` — release v0.5.0 | 2026-04-17 | chore/rename-to-agentlayer |
| ARB-26 | Add cover preview image to README — PR #1 merged to main | 2026-04-17 | docs/readme-cover-preview |
| ARB-27 | PR1 trust fixes: path normalization, `--non-interactive` fail-fast, install conflict detection (incl. `.github/instructions/`), paste-ready next-step output, `/tmp` warning + CI cases — PR #2 squash-merged | 2026-04-23 | fix/install-trust-fixes |
| ARB-28 | PR2 unified onboarding: `agentlayer init` wrapper, auto-route to `install`/`standardize`, README first-use recut, explicit AI-assisted prereqs, CI cases — PR #3 squash-merged | 2026-04-23 | feat/agentlayer-init |
