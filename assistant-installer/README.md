# AI-assisted install

Paste the content of [PROMPT.md](PROMPT.md) into your AI assistant — Codex, Claude Code, Copilot, Cursor, or any other.

The prompt asks which AI runtime(s) you want, audits the repo, and generates a grounded `.ai/` layer with the standard 8 agents, 4 skills, and context files filled with real project knowledge — not generic placeholders.

The adapter formats for all supported runtimes are embedded in the prompt. No web searches needed.

## When to use this instead of the CLI

- You already work inside an AI with local repo access
- You want the first install to be repo-specific from the start, not template-first
- You are bootstrapping one repo interactively

## When to use the CLI instead

- You want deterministic scaffolding from a shell command
- You need repeatable non-interactive or batch runs
- You want to standardize many repositories with the same flags
