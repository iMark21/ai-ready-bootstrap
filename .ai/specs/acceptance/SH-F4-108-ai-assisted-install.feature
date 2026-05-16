Feature: SH-F4-108 — AI-assisted install

  As someone with an AI assistant and a repo I don't fully know
  I want to paste one line and have the AI install + audit + fill sdd-harness
  So that onboarding an unfamiliar codebase is a single instruction

  Scenario: The fetchable prompt is self-contained
    Given assistant-installer/PROMPT.md
    When an AI reads only that file and the target repo
    Then it has every step needed: confirm repo, install, audit, fill,
      verify hook surface, finalize — with no other file required to understand it

  Scenario: Precondition is stated
    Given a cloud chat tool with no local repo access
    When a user tries to use the prompt there
    Then the prompt itself states it needs local read/write and that
      access-less tools cannot run it

  Scenario: Install step degrades gracefully
    Given the sdd-harness CLI is not on PATH
    When the AI follows the install step
    Then it clones the repo to ~/.sdd-harness, runs install.sh, then
      sdd-harness init . --yes — assuming only git and bash

  Scenario: Audit precedes fill and forbids fabrication
    Given the workflow
    Then the audit step lists concrete sources (README, layout, manifests,
      git log, tests) and instructs the AI to ask the human rather than
      invent anything the repo does not state

  Scenario: Fill targets match BOOTSTRAP.md
    Given assistant-installer/PROMPT.md and .ai/BOOTSTRAP.md
    Then both target the same judgment-layer files
      (PRODUCT, BACKLOG, CONTEXT, glossary) with the same intent

  Scenario: Glob mis-gate is handled during AI install
    Given sdd-harness init printed the SH_CODE_GLOBS / SH_CODE_EXCLUDE_GLOBS mis-gate warning
    When the AI follows the config step
    Then it edits .ai/hooks/config.sh so implementation surface is protected
      and re-runs .ai/hooks/install.sh and confirms the hook now fires

  Scenario: The workflow ends without unprompted implementation
    When the AI completes the workflow
    Then it deletes .ai/BOOTSTRAP.md, summarizes what it wrote, and
      proposes the first story — it does not start coding a feature

  Scenario: README exposes the path
    Given the README "Install" section
    Then it offers option (c) with the one-paste fetch line and the
      develop raw URL
