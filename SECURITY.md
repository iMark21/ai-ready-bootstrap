# Security Policy

## Scope

sdd-harness is a local CLI and repository scaffold. It reads the target repository and writes Markdown files, runtime bootloaders, CI helper scripts, and optional Git hooks. It does not transmit repository contents to any external service and it does not execute code from the target repository during installation.

The primary security surface is:

- **File writes**: the tool creates and overwrites files in the target repository under `.ai/`, `tools/`, and optional runtime bootloader paths (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursor/rules/`, `.github/copilot-instructions.md`).
- **Git hook installation**: with hook installation enabled, the tool writes local Git hook wrappers that delegate to `.ai/hooks/` scripts.
- **AI-assisted bootstrap**: the assistant prompt asks a local AI tool to read the repository and fill project-owned `.ai/` files. The CLI itself never shells out to an AI provider.

## Reporting a vulnerability

If you discover a security issue, please do **not** open a public GitHub issue.

Instead, report it by:

1. Opening a [GitHub Security Advisory](https://github.com/iMark21/sdd-harness/security/advisories/new) (preferred)
2. Or emailing the maintainer directly — contact information is on the GitHub profile

Please include:

- A description of the issue and its potential impact
- Steps to reproduce or a proof of concept
- Any suggested mitigations

You will receive a response within 7 days. If the issue is confirmed, a fix will be prioritized and a new release will be made as soon as possible.

## Supported versions

Only the latest release on `main` is actively maintained.
