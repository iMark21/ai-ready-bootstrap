Feature: SH-F4-104/105 — Install helpers (stack detection + README migration)

  As a new adopter of sdd-harness on an existing project
  I want init to detect my stack and migrate my existing roadmap
  So that BOOTSTRAP.md can seed content faster and I spend less time on boilerplate

  Background:
    Given the sdd-harness CLI is installed
    And a target git repository with a README.md file

  # SH-F4-104: Stack detection via --stack flag
  # (Not automatic heuristic; explicit flag only)

  Scenario: User specifies stack via --stack flag
    Given a Python project with "pyproject.toml"
    When I run "sdd-harness init . --stack python --yes"
    Then ".ai/PRODUCT.md" contains a Python-specific tech stack stub
    And ".ai/CONTEXT.md" has a "Stack:" line with "python"
    And no error is raised
    And the hook config "SH_CODE_GLOBS" includes "*.py"

  Scenario: --stack flag accepts common stacks
    When I run "sdd-harness init . --stack <stack> --yes"
    Then the init succeeds and ".ai/PRODUCT.md" reflects "<stack>"
    Examples:
      | stack     |
      | swift     |
      | android   |
      | python    |
      | node      |
      | go        |
      | rust      |

  Scenario: --stack flag rejects unknown stacks
    When I run "sdd-harness init . --stack lolwat --yes"
    Then init exits with code 1
    And prints a message listing supported stacks
    And suggests running "--stack help" or "--list-stacks"

  Scenario: --stack flag is optional (defaults to "generic")
    Given no --stack flag is provided
    When I run "sdd-harness init . --yes"
    Then ".ai/PRODUCT.md" has a generic (blank) tech stack stub
    And ".ai/CONTEXT.md" has "Stack: generic"

  # SH-F4-105: README -> BACKLOG migration

  Scenario: README ## TODO section is migrated to BACKLOG.md
    Given a README with a "## TODO" section listing items like:
      """
      ## TODO
      - Add unit tests
      - Refactor auth module
      - Write API docs
      """
    When I run "sdd-harness init . --yes"
    Then ".ai/BACKLOG.md" has a section "## From README TODO"
    And each item from README TODO is a row in the backlog table as "todo" status
    And the README ## TODO section is left untouched

  Scenario: README ## Roadmap section is migrated as stories
    Given a README with "## Roadmap" containing phases:
      """
      ## Roadmap
      - Q2 2026: Auth refactor
      - Q3 2026: API versioning
      """
    When I run "sdd-harness init . --yes"
    Then ".ai/BACKLOG.md" has a section "## From README Roadmap"
    And each phase is a row with status "todo"

  Scenario: Missing README ## TODO / ## Roadmap produces a note
    Given a README without a "## TODO" or "## Roadmap" section
    When I run "sdd-harness init . --yes"
    Then ".ai/BACKLOG.md" has a comment explaining that no roadmap was found
    And it suggests "Run `specify clarify` to scaffold backlog from AI questions"

  Scenario: --dry-run shows what would be migrated without writing
    Given a README with "## TODO" items
    When I run "sdd-harness init . --dry-run --yes"
    Then output announces "Would migrate X items from README to BACKLOG.md"
    And ".ai/BACKLOG.md" is NOT created
    And ".ai/CONTEXT.md" is NOT created

  # Integration

  Scenario: Init output lists what was done
    When I run "sdd-harness init . --stack python --yes"
    Then the post-install message includes:
      """
      ✓ Detected stack: python
      ✓ Migrated 5 items from README ## TODO
      ✓ BOOTSTRAP.md ready for AI handoff
      """

  Scenario: List available stacks
    When I run "sdd-harness init . --list-stacks"
    Then it prints a table of all supported stacks with brief descriptions
    And exits with code 0
    And does NOT initialize the repo
