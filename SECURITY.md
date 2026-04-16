# Security Policy

## Scope

agentlayer is a local CLI tool. It reads the target repository and writes Markdown files and optional Git hooks. It does not transmit data, require network access, or execute code from the repositories it processes.

The primary security surface is:

- **File writes**: the tool creates and overwrites files in the target repository under `.ai/`, and optionally in the root (`AGENTS.md`, `CLAUDE.md`, etc.)
- **Git hook installation**: with `--no-git-hook` omitted, the tool writes a pre-commit hook to the target repo's `.githooks/` directory and sets `core.hooksPath`
- **Git identity**: with `--apply-git-config`, the tool runs `git config --local` to set `user.name` and `user.email` in the target repo

## Reporting a vulnerability

If you discover a security issue, please do **not** open a public GitHub issue.

Instead, report it by:

1. Opening a [GitHub Security Advisory](https://github.com/iMark21/agentlayer/security/advisories/new) (preferred)
2. Or emailing the maintainer directly — contact information is on the GitHub profile

Please include:

- A description of the issue and its potential impact
- Steps to reproduce or a proof of concept
- Any suggested mitigations

You will receive a response within 7 days. If the issue is confirmed, a fix will be prioritized and a new release will be made as soon as possible.

## Supported versions

Only the latest release on `main` is actively maintained.
