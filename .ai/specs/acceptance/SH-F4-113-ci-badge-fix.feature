Feature: SH-F4-113 — Public-readiness fixup: CI badge branch reference

  As a new visitor landing on the GitHub repo from the LinkedIn launch
  I want the CI status badge to show the health of the public (main) branch
  So that I see a reliable indicator of the project's public release status,
  not the development branch's transient state

  Background:
    Given the sdd-harness repo is on the main branch
    And README.md contains a CI status badge

  Scenario: CI badge URL references main branch, not develop
    When I inspect the README.md CI badge HTML
    Then the badge src URL includes parameter "branch=main"
    And the badge src URL does not include "branch=develop"

  Scenario: Badge link still points to CI workflow
    When I inspect the README.md CI badge
    Then the <a> href points to ".../workflows/ci.yml"
    And the shields.io URL is well-formed

  Scenario: Badge renders without 404
    Given the README.md is deployed to GitHub
    When the CI badge image URL is fetched
    Then the HTTP status is 200 (not 404 or 500)
    And the badge displays a status state (passing, failing, or pending)

  Scenario: No other badges changed
    When I compare README.md before/after the fix
    Then only the CI badge's branch parameter changed
    And the license badge remains "...license/iMark21/sdd-harness"
    And the version badge remains ".../releases"
    And the deps badge remains "bash + git"

  Scenario: Badge label and color unchanged
    When I inspect the CI badge shields.io URL
    Then the label parameter is still "&label=CI"
    And no "color" or "style" parameter was added or removed
