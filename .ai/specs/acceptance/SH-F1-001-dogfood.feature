Feature: SH-F1-001 — Dogfood: sdd-harness governs itself via its own .ai/

  As a new contributor (human or AI) opening this repo for the first time
  I want the .ai/ layer to be self-explanatory, internally consistent, and runtime-agnostic
  So that I can open a PR following the SDD flow without external coaching

  Background:
    Given a fresh checkout of the sdd-harness repository
    And no AI runtime has been preconfigured

  Scenario: An AI runtime reaches the routing entrypoint in 3 hops or fewer
    Given the AI runtime starts at the repo root
    When it reads any of: CLAUDE.md, AGENTS.md
    Then it is pointed to .ai/ROUTING.md
    And .ai/ROUTING.md is reachable as a relative link

  Scenario: Root bootloaders are 5-line pointers (≤ 12 lines total)
    Given the files CLAUDE.md and AGENTS.md exist at the repo root
    When their line counts are inspected
    Then each file is 12 lines or fewer
    And each file contains a link to .ai/ROUTING.md
    And neither file embeds instructions that duplicate .ai/ content

  Scenario: The .ai/ layer has exactly the expected top-level shape
    Given the .ai/ directory exists
    Then it contains the following items and no others required at v1.0.0-alpha:
      | item              | type      |
      | ROUTING.md        | file      |
      | PRODUCT.md        | file      |
      | CONTEXT.md        | file      |
      | BACKLOG.md        | file      |
      | README.md         | file      |
      | adrs/             | directory |
      | agents/           | directory |
      | commands/         | directory |
      | hooks/            | directory |
      | notes/            | directory |
      | specs/            | directory |

  Scenario: Every command file follows the contract
    Given the files under .ai/commands/
    When each is read
    Then each contains the sections: "Usage", "Inputs", "Procedure", "Done criteria"
    And no command file references stack-specific tooling (Swift, Fastlane, xcodebuild, npm, cargo, etc.) as required

  Scenario: The pre-commit SDD hook is configurable per project
    Given .ai/hooks/config.sh exists
    And .ai/hooks/pre-commit-spec-check.sh exists
    When the hook is sourced
    Then it reads SH_CODE_GLOBS, SH_CODE_EXCLUDE_GLOBS, and SH_SPEC_GLOBS from config.sh
    And the hook exits 0 on branches not matching feat/* or feature/*
    And the hook blocks feat/* and feature/* commits that touch implementation surface without touching SH_SPEC_GLOBS

  Scenario: No legacy v0.5.0 artifacts remain
    Given the repo is at v1.0.0-alpha
    Then no file under .ai/ references agent-explore, agent-plan, agent-code, agent-verify
    And no file under .ai/ references the old `explore→plan→code→verify` flow
    And assistant-installer/PROMPT.md, if present, follows the SDD install workflow rather than the v0.5.0 flow

  Scenario: No domain-specific references leak from the upstream lineage
    Given the .ai/ layer
    When grepped for any hardware-protocol or stack-specific term (BLE, NFC, Keychain, Vapor, CoreBluetooth, xcodebuild, etc.)
    Then no matches are found in commands/, hooks/, agents/, ADRs, notes, or specs templates
    And the only lineage references that remain are generic phrasings like "iterated through multiple phases in a real production codebase"

  Scenario: The SDD flow is documented end-to-end
    Given .ai/notes/spec-driven-development.md exists
    Then it documents the loop: spec → review → implement → verify → review → release
    And it explains how to handle drift between code and spec
    And it lists exempted branch patterns (chore/*, docs/*, fix/hotfix/*)

  Scenario: ADR 0008 establishes the runtime-agnostic principle
    Given .ai/adrs/0008-runtime-agnostic-ai-layer.md exists
    Then its Status is "Accepted"
    And it rejects the alternative "put everything in .claude/"
    And it states that root-level adapter files are 5-line pointers with no logic
