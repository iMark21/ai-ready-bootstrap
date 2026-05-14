Feature: SH-F3-001 — `phase-close` keeps CONTEXT.md as a faithful mirror

  As a contributor closing a phase
  I want a disciplined procedure that updates CONTEXT.md and BACKLOG.md
  So that the project's living state stays legible to humans and AIs

  Background:
    Given the project has `.ai/CONTEXT.md` with the five required sections:
      | section            |
      | Current state      |
      | Done               |
      | Immediate next     |
      | Decisions taken    |
      | Open risks         |
    And `.ai/commands/phase-close.md` is the canonical procedure
    And `.ai/notes/governance-mirror.md` documents the why

  Scenario: A phase cannot close while a story is still in-progress
    Given .ai/BACKLOG.md has at least one story tagged with the current phase that is `in-progress`
    When the contributor runs the phase-close procedure
    Then the procedure stops at step 1 ("Verify the phase actually closed")
    And the contributor either finishes the story or makes an explicit carry-forward decision

  Scenario: Phase close updates the Current state header
    Given the current phase is F2
    And every F2 story in BACKLOG.md is `done`, `parked`, or `cut`
    When the contributor closes F2 and opens F3 via the phase-close procedure
    Then CONTEXT.md "Phase:" line is updated to "F3 — <name>"
    And CONTEXT.md "Last update:" line is today's date in YYYY-MM-DD format
    And CONTEXT.md "Branch:" line reflects the branch the next phase will use

  Scenario: Done section is append-only within the active phase
    Given CONTEXT.md "Done" section lists items from prior phases
    When the contributor closes a phase
    Then the items from the just-closed phase appear as a new sub-section in "Done"
    And no prior-phase items are deleted (older phases may be collapsed into a single summary bullet, but never removed silently)

  Scenario: Decisions longer than two lines become ADRs
    Given the just-closed phase produced a decision that would take more than two lines to explain
    When the contributor reaches step 5 ("Update Decisions taken")
    Then a new ADR file is created under .ai/adrs/
    And the "Decisions taken" bullet references the ADR by number
    And the ADR file follows the lightweight MADR format (Status, Context, Decision, Consequences, Rejected alternatives)

  Scenario: Open risks reflect the live state
    Given the previous phase had a risk that has now materialized or no longer applies
    When the contributor reaches step 6 ("Update Open risks")
    Then the obsolete risk is removed from the table (not crossed out, not left with "RESOLVED")
    And any newly emerged risk is added

  Scenario: BACKLOG.md status flips to done for closed stories
    Given the just-closed phase had stories X, Y, Z
    When the contributor reaches step 7 ("Update BACKLOG.md")
    Then stories X, Y, Z have status `done` in BACKLOG.md
    And no story closed in this phase still appears as `in-progress`

  Scenario: An AI assistant reading CONTEXT.md after phase-close has full context
    Given CONTEXT.md has been freshly closed for phase F2 and opened for F3
    When an AI assistant reads CONTEXT.md as its first action
    Then it can answer:
      | question                                          |
      | What phase is the project in right now?           |
      | What branch is active?                            |
      | What was the last thing that shipped?             |
      | What is the next task to pick up?                 |
      | Which decisions of the prior phase are still live?|
      | Which risks are currently being mitigated?        |
    Without reading any other file in the repo

  Scenario: phase-close as the squash-merge commit
    Given the phase work has happened on a feature branch
    When the contributor closes the phase
    Then the CONTEXT.md and BACKLOG.md updates are included in the squash-merge commit to `develop`
    And the squash-merge commit message follows the convention: `feat: "<phase-id> — <one-line summary>"`
