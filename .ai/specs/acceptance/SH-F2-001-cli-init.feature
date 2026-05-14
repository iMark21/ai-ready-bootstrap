Feature: SH-F2-001 — `sdd-harness init` lays down the .ai/ layer in any repo

  As an engineer adopting sdd-harness in a new or existing repository
  I want a single `init` command that detects state and does the right thing
  So that I get a working .ai/ layer plus runtime bootloaders with one invocation

  Background:
    Given the sdd-harness CLI is installed at $HOME/.local/bin/sdd-harness
    And the templates/ directory ships under the sdd-harness repo root

  Scenario: Fresh repo install
    Given a fresh git repository at /tmp/fresh-test/
    When I run "sdd-harness init /tmp/fresh-test"
    Then the CLI prints "Fresh repo detected. Routing to 'install'."
    And the following files exist:
      | path                                          |
      | /tmp/fresh-test/.ai/ROUTING.md                |
      | /tmp/fresh-test/.ai/PRODUCT.md                |
      | /tmp/fresh-test/.ai/CONTEXT.md                |
      | /tmp/fresh-test/.ai/BACKLOG.md                |
      | /tmp/fresh-test/.ai/README.md                 |
      | /tmp/fresh-test/.ai/adrs/0008-runtime-agnostic-ai-layer.md |
      | /tmp/fresh-test/.ai/agents/spec-writer.md     |
      | /tmp/fresh-test/.ai/commands/spec.md          |
      | /tmp/fresh-test/.ai/commands/story.md         |
      | /tmp/fresh-test/.ai/commands/implement.md     |
      | /tmp/fresh-test/.ai/commands/verify.md        |
      | /tmp/fresh-test/.ai/commands/review.md        |
      | /tmp/fresh-test/.ai/commands/release.md       |
      | /tmp/fresh-test/.ai/hooks/install.sh          |
      | /tmp/fresh-test/.ai/hooks/pre-commit-spec-check.sh |
      | /tmp/fresh-test/.ai/hooks/config.sh           |
      | /tmp/fresh-test/.ai/notes/spec-driven-development.md |
      | /tmp/fresh-test/.ai/specs/PRD.md              |
      | /tmp/fresh-test/.ai/specs/glossary.md         |
      | /tmp/fresh-test/CLAUDE.md                     |
      | /tmp/fresh-test/AGENTS.md                     |
    And no file under /tmp/fresh-test/.ai/ contains an unresolved {{PROJECT_NAME}} placeholder
    And no file under /tmp/fresh-test/.ai/ contains an unresolved {{STORY_PREFIX}} placeholder
    And no file under /tmp/fresh-test/.ai/ contains an unresolved {{TODAY}} placeholder

  Scenario: Placeholder substitution uses the directory basename
    Given a fresh git repository at /tmp/my-cool-project/
    When I run "sdd-harness init /tmp/my-cool-project"
    Then /tmp/my-cool-project/.ai/PRODUCT.md contains "my-cool-project"
    And /tmp/my-cool-project/.ai/BACKLOG.md contains the prefix "MCP" or a similar 3-letter uppercase derivation
    And /tmp/my-cool-project/.ai/CONTEXT.md contains today's date in YYYY-MM-DD format

  Scenario: Dry-run never writes files
    Given a fresh git repository at /tmp/dry-test/
    When I run "sdd-harness init /tmp/dry-test --dry-run"
    Then the CLI prints actions prefixed with "[dry-run]"
    And no .ai/ directory exists under /tmp/dry-test/
    And no CLAUDE.md or AGENTS.md exists under /tmp/dry-test/

  Scenario: Install refuses to overwrite existing AI files
    Given a repository at /tmp/existing-test/ that already contains CLAUDE.md
    When I run "sdd-harness install /tmp/existing-test"
    Then the CLI exits non-zero
    And the error message mentions "already has AI files" and "standardize"

  Scenario: Standardize backs up existing files and reinstalls
    Given a repository at /tmp/standardize-test/ with an existing .ai/ directory
    When I run "sdd-harness standardize /tmp/standardize-test --yes"
    Then a directory matching ".ai-backup-YYYYMMDD-HHMMSS" is created under /tmp/standardize-test/
    And the original .ai/ contents are moved into that backup directory
    And a fresh .ai/ from templates/ is installed
    And the new .ai/ICONTEXT.md does not reference the backed-up content

  Scenario: Init auto-routes between install and standardize
    Given a repository at /tmp/auto-test/
    And the repository has no AI files
    When I run "sdd-harness init /tmp/auto-test"
    Then the CLI announces routing to "install"
    Given the same repository now has AI files from a previous install
    When I run "sdd-harness init /tmp/auto-test --yes"
    Then the CLI announces routing to "standardize"

  Scenario: Audit reports the current state without modifying anything
    Given a repository at /tmp/audit-test/ with a previous sdd-harness install
    When I run "sdd-harness audit /tmp/audit-test"
    Then the CLI lists detected AI-layer files
    And it lists the contents of .ai/ up to depth 2
    And no files are modified

  Scenario: Unsupported runtime is rejected
    When I run "sdd-harness init /tmp/any --runtimes cursor"
    Then the CLI exits non-zero
    And the error message states the supported runtimes for v1.0.0-alpha (claude, codex)

  Scenario: Non-interactive mode fails fast on conflicts
    Given a repository at /tmp/ni-test/ with existing AI files
    When I run "sdd-harness standardize /tmp/ni-test --non-interactive"
    Then the CLI exits non-zero
    And the error message instructs the user to pass --yes
