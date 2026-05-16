Feature: SH-F4-111 — Universal code surface default

  As someone installing sdd-harness in an arbitrary repository
  I want the SDD hook to protect implementation files by default
  So that iOS, web, backend, monorepo, and unusual layouts do not require
  manual glob tuning before the first feature commit

  Background:
    Given the sdd-harness CLI is installed
    And a target git repository

  Scenario: Fresh install uses universal include and explicit excludes
    When I run "sdd-harness init . --yes"
    Then ".ai/hooks/config.sh" declares SH_CODE_GLOBS with "*"
    And ".ai/hooks/config.sh" declares SH_CODE_EXCLUDE_GLOBS

  Scenario: Nested Android layout is protected without manual tuning
    Given the repo keeps code under "Marvel/app/src/X.kt"
    When I run "sdd-harness init . --yes"
    Then no glob-sanity warning is printed
    And a feature commit touching only "Marvel/app/src/X.kt" is blocked

  Scenario: iOS layout is protected without manual tuning
    Given the repo keeps code under "MyApp/AppDelegate.swift"
    When I run "sdd-harness init . --yes"
    Then no glob-sanity warning is printed
    And a feature commit touching only "MyApp/AppDelegate.swift" is blocked

  Scenario: Go layout is protected without manual tuning
    Given the repo keeps code under "cmd/server/main.go"
    When I run "sdd-harness init . --yes"
    Then no glob-sanity warning is printed
    And a feature commit touching only "cmd/server/main.go" is blocked

  Scenario: Documentation-only feature commit is allowed
    Given the repo has only "README.md" changed on a feature branch
    When the pre-commit hook runs
    Then the commit is allowed without a spec touch

  Scenario: Docs-only repository still warns during install
    Given the repo tracks only excluded documentation files
    When I run "sdd-harness init . --yes"
    Then the glob-sanity warning is printed
    And it names SH_CODE_GLOBS and SH_CODE_EXCLUDE_GLOBS
