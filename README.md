# agentlayer

![AgentLayer](docs/cover.png)

Your AI assistant writes better code when it actually knows your project.

agentlayer adds a structured `.ai/` layer to any existing repository so that Codex, Claude Code, Copilot, Cursor — or any AI — stops guessing and starts following your real architecture, conventions, and decisions from the first prompt.

No dependencies. Any AI runtime. Any tech stack.

## Install

One command. It detects the repo state, asks which AI you use, and sets everything up.

```bash
# 1. Get the CLI (clone somewhere persistent — /tmp gets cleaned and breaks the symlink)
git clone https://github.com/iMark21/agentlayer.git ~/.agentlayer
cd ~/.agentlayer && bash install.sh

# 2. Inside your repo
cd /path/to/your-repo
agentlayer init
```

`init` auto-routes to the right action:

- **Repo has no AI files yet** → installs a fresh canonical `.ai/` layer plus the adapter for the runtime you pick
- **Repo already has AI files** (`AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`, etc.) → runs `standardize` instead, backing up the old files and rewriting the layout

At the end, `init` prints a copy-paste-ready prompt for your AI so you can ground the generated context in the real repo.

### Alternative — let your AI install it

If you prefer, paste this into any AI assistant with local read/write access to the repo:

```
Fetch https://raw.githubusercontent.com/iMark21/agentlayer/main/assistant-installer/PROMPT.md
and follow the complete installation workflow defined there for this repository.
```

**Prerequisites for the AI-assisted path:** the assistant must be able to read files in and write files to this repository from your local machine (Codex, Claude Code, Cursor, Copilot CLI, or any other with local filesystem access). Cloud-only chat tools without repo access will not work — use the CLI path above.

If your AI cannot fetch URLs directly:

```bash
curl -sO https://raw.githubusercontent.com/iMark21/agentlayer/main/assistant-installer/PROMPT.md
```

Then ask it: `Read PROMPT.md in this directory and follow the installation workflow.` Delete the file when done.

## What you get

A team of agents that follow a structured workflow:

```
agent-explore → agent-plan → agent-code → agent-verify
```

Plus specialized agents for bug fixes (`agent-fix`), refactors (`agent-tech`), and investigations (`agent-spike`), and four reusable skills (context refresh, feature scaffold, migration audit, context bootstrap).

Every installation produces the same deterministic skeleton: 8 agents, 4 skills, 5 context files, scoped rules by file type, and thin adapters for each AI runtime. The **structure** is fixed. The **content** is filled with real knowledge from your repository.

## Using it — example

Adding a login screen:

1. **Explore:** *"Use agent-explore. I need to add a login screen with email and password."* — the AI reads `.ai/context/architecture.md`, maps your existing auth code, and reports back before writing anything.
2. **Plan:** *"Use agent-plan. Plan the login screen feature."* — file-level plan: which files to create, which to modify, which tests to add.
3. **Implement:** *"Use agent-code. Implement the approved plan."* — task by task. Stops and reports if a step fails.
4. **Verify:** *"Use agent-verify. Verify the login feature."* — runs tests, checks acceptance criteria, documents residual risk.

The feature is recorded under `.ai/features/login.md` so the next session already has context.

For bug fixes: *"Use agent-fix. The total is not updating when I remove an item from the cart."*
For refactor decisions: *"Use agent-spike. Is it worth extracting the payment logic into its own module?"* — returns a decision document, no code.

## Supported runtimes and project types

- Runtimes: Codex, Claude Code, GitHub Copilot, Cursor, or a tool-agnostic `AGENTLAYER.md` for any other AI.
- Project types (auto-detected): Android, iOS, web, backend, or generic fallback.

See [MANUAL.md](MANUAL.md) for the full reference — every command, every flag, every adapter format, every rule generated.

## Read more

- [MANUAL.md](MANUAL.md) — full reference: commands, flags, workflows, generated structure
- [CHANGELOG.md](CHANGELOG.md) — version history
- [CONTRIBUTING.md](CONTRIBUTING.md) — how to contribute
