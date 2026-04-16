# Assistant installer pack

AI-Ready Bootstrap gives any repository a canonical `.ai/` context layer that AI assistants can read before acting. This pack lets you install that layer using the AI you already work with — instead of running a CLI command.

Use this pack when you want AI-Ready Bootstrap to be installed by the AI you already use instead of by the CLI.

## The stupid-simple path

If you use Codex and just want the ready-made skill:

1. Open [addon/README.md](addon/README.md).
2. Copy the packaged folder `addon/ai-ready-bootstrap-installer/` into your local Codex skills directory.
3. Restart Codex or open a new session.
4. In the target repository, say: `Use the ai-ready-bootstrap-installer skill in this repository.`

If your AI does not support installed skills, skip the add-on and use [PROMPT.md](PROMPT.md).

## Pick the entry point

| File | Use when | Outcome |
| --- | --- | --- |
| [addon/README.md](addon/README.md) | you want the most explicit copy-this-here skill install path for Codex | a packaged add-on folder you can drop into your skills directory |
| [SKILL.md](SKILL.md) | your AI supports custom skills, reusable prompts, or task playbooks | the AI gets a stable installation workflow it can reuse across repos |
| [PROMPT.md](PROMPT.md) | your AI only supports pasted prompts or custom instructions | you can run the same install flow without a native skill format |

## What is what

| File | Purpose |
| --- | --- |
| `addon/ai-ready-bootstrap-installer/SKILL.md` | packaged copy of the installer skill, ready to drop into a Codex skills folder |
| `SKILL.md` | source version of the same workflow, useful if you want to adapt it |
| `PROMPT.md` | fallback when the AI supports prompts but not installed skills |

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
- You want a skill or add-on that another teammate can install without reading the whole manual.

## When to prefer the CLI instead

- You want deterministic scaffolding from a shell command.
- You need repeatable non-interactive runs.
- You want to standardize many repositories with the same flags.
- You are okay with the CLI generating the frame first and the AI grounding it immediately after.
