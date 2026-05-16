Feature: SH-F4-110 — Install completeness

  As someone adopting sdd-harness on an existing repo
  I want init to finish the deterministic work and flag a mis-gated hook
  So that the SDD discipline is actually enforced and I am not left with
  empty templates and no guidance

  Background:
    Given the sdd-harness CLI is installed
    And a target git repository

  Scenario: Docs-only layout triggers the glob sanity warning
    Given the repo tracks only excluded documentation files
    When I run "sdd-harness init . --yes"
    Then the install completes with exit code 0
    And it prints a warning that no tracked implementation file matches SH_CODE_GLOBS after SH_CODE_EXCLUDE_GLOBS
    And the warning lists the repo's top-level directories
    And the warning names ".ai/hooks/config.sh", "SH_CODE_GLOBS", and "SH_CODE_EXCLUDE_GLOBS" as what to edit

  Scenario: Conventional layout produces no warning
    Given the repo keeps code under "src/"
    When I run "sdd-harness init . --yes"
    Then no glob-sanity warning is printed

  Scenario: CONTEXT.md Branch line reflects the real branch
    Given the repo's current branch is "trunk"
    When I run "sdd-harness init . --yes"
    Then ".ai/CONTEXT.md" has a Branch line referencing "trunk"
    And no "{{GIT_BRANCH}}" placeholder remains in any .ai/ file

  Scenario: Bootstrap handoff file is written and referenced
    When I run "sdd-harness init . --yes"
    Then ".ai/BOOTSTRAP.md" exists
    And it contains a paste-ready prompt that fills PRODUCT/CONTEXT/BACKLOG/glossary from the repo
    And the post-install message references ".ai/BOOTSTRAP.md" as step 1

  Scenario: Dry-run writes nothing and still announces the handoff
    When I run "sdd-harness init . --dry-run --yes"
    Then no ".ai" directory is created
    And no ".ai/BOOTSTRAP.md" is created
    And the output announces that BOOTSTRAP.md and the glob check would run

  Scenario: The dry-run matcher cannot disagree with the real hook
    Given a tracked file path P and the repo's SH_CODE_GLOBS / SH_CODE_EXCLUDE_GLOBS
    When the install glob-sanity check evaluates P
    Then it uses the same case-pattern matching as pre-commit-spec-check.sh
    And a path the hook would treat as code is also seen as code by the check
