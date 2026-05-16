Feature: SH-F2-002 — Deterministic CI with stack plugins

  As a project maintainer using sdd-harness
  I want a stack-aware CI harness that runs locally and remotely without CI-specific YAML
  So that my dev loop (lint, test, build) is identical on my laptop and in GitHub Actions

  Background:
    Given a target repository with sdd-harness installed
    And the repository has a declared stack in .ai/CONTEXT.md

  # Dispatcher

  Scenario: Dispatcher routes to the correct plugin based on stack
    Given .ai/CONTEXT.md declares "Stack: python"
    And tools/ci/python.sh exists
    When I run "tools/ci.sh"
    Then it executes the python plugin
    And exit code reflects the plugin's result

  Scenario: Dispatcher accepts explicit stack override
    Given .ai/CONTEXT.md declares "Stack: python"
    And tools/ci/swift.sh exists
    When I run "tools/ci.sh --stack swift"
    Then it executes the swift plugin (not python)
    And exit code reflects the swift plugin's result

  Scenario: Dispatcher rejects unknown stacks
    When I run "tools/ci.sh --stack lolwat"
    Then it exits with code 1
    And prints a message listing supported plugins

  Scenario: Dispatcher lists available plugins
    Given tools/ci/ contains {python, swift, js, go}.sh
    When I run "tools/ci.sh --list"
    Then it prints all available plugins with one-line descriptions
    And exits with code 0

  Scenario: Dispatcher can run all plugins (CI farm mode)
    Given tools/ci/ contains {python, swift, js}.sh
    When I run "tools/ci.sh --all"
    Then it runs all three plugins sequentially
    And reports aggregated exit code (0 if all pass, 1 if any fail)

  # Plugin interface

  Scenario: Plugin implements the standard interface
    Given the plugin script tools/ci/swift.sh
    When I inspect its functions
    Then it defines: plugin_check, plugin_lint, plugin_test, plugin_build
    And each function returns 0 on success, non-zero on failure
    And each function produces grep-able output (no binary/escaped data)

  Scenario: plugin_check validates the stack toolchain is present
    Given a Python project without pytest installed
    When I run "tools/ci.sh && source tools/ci/python.sh && plugin_check"
    Then it exits with non-zero
    And prints "pytest not found" or similar

  Scenario: plugin_lint runs the stack's linter
    Given a Python project with ruff configured
    When I run "source tools/ci/python.sh && plugin_lint"
    Then it runs "ruff check ." (or equivalent)
    And returns the linter's exit code

  Scenario: plugin_test runs the stack's test suite
    Given a Python project with pytest configured
    When I run "source tools/ci/python.sh && plugin_test"
    Then it runs "pytest"
    And returns pytest's exit code

  Scenario: plugin_build creates the stack's artifacts
    Given a Swift project with a Package.swift
    When I run "source tools/ci/swift.sh && plugin_build"
    Then it runs "swift build"
    And returns the build's exit code

  # Stack plugins (initial set)

  Scenario: swift plugin uses XcodeGen + xcodebuild + swift test
    Given a Swift project
    When I run "tools/ci.sh --stack swift"
    Then the plugin checks for: swiftc, xcodegen, xcodebuild, swift
    And runs: xcodegen + xcodebuild build + swift test
    And returns aggregated result

  Scenario: python plugin uses pytest + ruff + mypy
    Given a Python project with pyproject.toml
    When I run "tools/ci.sh --stack python"
    Then the plugin checks for: python, pytest
    And runs: ruff check + pytest + mypy (if pyproject.toml specifies it)
    And returns aggregated result

  Scenario: js plugin uses npm test + tsc + eslint
    Given a Node.js project with package.json
    When I run "tools/ci.sh --stack js"
    Then the plugin checks for: node, npm
    And runs: npm lint (eslint) + npm test + npm run tsc (if tsconfig.json exists)
    And returns aggregated result

  Scenario: go plugin uses go test + go vet + staticcheck
    Given a Go project with go.mod
    When I run "tools/ci.sh --stack go"
    Then the plugin checks for: go
    And runs: go vet ./... + go test ./... + staticcheck ./... (if installed)
    And returns aggregated result

  # Integration with SDD harness

  Scenario: Dispatcher reads stack from .ai/CONTEXT.md
    Given .ai/CONTEXT.md has "**Stack:** python"
    And no tools/ci/stack override file exists
    When I run "tools/ci.sh"
    Then it extracts "python" from CONTEXT.md
    And routes to the python plugin

  Scenario: Override file takes precedence over CONTEXT.md
    Given .ai/CONTEXT.md declares "Stack: python"
    And tools/ci/stack contains "swift"
    When I run "tools/ci.sh"
    Then it uses "swift" (from override file)

  # GitHub Actions integration (template)

  Scenario: CI template workflow invokes tools/ci.sh
    Given a .github/workflows/ci.yml template in sdd-harness
    When I copy it into a consumer project
    Then the workflow runs exactly: "bash tools/ci.sh"
    And does not hardcode python, swift, node, go, etc.
    And does not reference stack-specific tools in the YAML

  Scenario: CI workflow passes on local success
    Given tools/ci.sh passes locally
    When the same command runs in GitHub Actions
    Then the workflow job succeeds (exit code 0)
    And no environment differences cause failure

  # Common plugin helpers

  Scenario: Plugins use shared logging from tools/ci/common.sh
    Given a plugin script
    When it sources tools/ci/common.sh
    Then it can call: log, warn, die
    And log output is consistent across plugins

  Scenario: Common helpers provide timing/summaries
    When a plugin runs multiple sub-steps (check, lint, test)
    Then common.sh helpers emit: "✓ step completed in Xms"
    And aggregates wall-clock time
