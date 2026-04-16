# Assistant installer pack

Use this pack when you want AI-Ready Bootstrap to be installed by the AI you already use instead of by the CLI.

This path is different from `ai-ready install`:

- the AI audits the repository first
- the canonical `.ai/` layer is still the target shape
- the generated files should be grounded to the real repo on the first pass
- the AI should avoid leaving generic placeholders unless evidence is missing

## Pick the entry point

| File | Use when | Outcome |
| --- | --- | --- |
| [SKILL.md](SKILL.md) | your AI supports custom skills, reusable prompts, or task playbooks | the AI gets a stable installation workflow it can reuse across repos |
| [PROMPT.md](PROMPT.md) | your AI only supports pasted prompts or custom instructions | you can run the same install flow without a native skill format |

## What this path should do

1. Inspect the repository structure, build files, modules, packages, targets, tests, and existing AI files.
2. Detect the project type from evidence.
3. Decide which runtime adapters to create.
4. Create the canonical `.ai/` structure.
5. Fill `.ai/context*` with grounded repository knowledge, not generic filler.
6. Leave explicit open questions where the repo does not provide enough evidence.
7. Stop after installation and summarize the new AI layer plus unknowns.

## When to prefer this over the CLI

- You already work inside an AI with local repo access.
- You want the first install to be repo-specific, not template-first.
- You are bootstrapping one repo interactively rather than many repos in batch.

## When to prefer the CLI instead

- You want deterministic scaffolding from a shell command.
- You need repeatable non-interactive runs.
- You want to standardize many repositories with the same flags.
- You are okay with the CLI generating the frame first and the AI grounding it immediately after.
