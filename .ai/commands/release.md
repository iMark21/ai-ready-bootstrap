# Command: `release`

Drive a release through your project's release toolchain.

## Usage

```
release [lane]
```

`lane` defaults to `beta`. Common values: `test`, `beta`, `release`. Your project may define different lanes — declare them in your project's release ADR.

## Inputs

- Your project's release tooling (e.g. Fastlane lanes for iOS, npm publish for libraries, Docker build + push for services, etc.).
- Current branch + commit hash.
- Project-level build settings.

## Procedure

1. Confirm the branch is up to date with `develop` (or `main` for `release`).
2. Run the `test` lane: unit + integration tests must be green.
3. For `beta`:
   - Bump build identifier.
   - Sign artifacts with the configured release credential.
   - Distribute to the internal channel (TestFlight, internal registry, staging environment, etc.).
   - Post the link to chat / commit.
4. For `release`:
   - Verify the version tag matches the version manifest (`Info.plist`, `package.json`, `Cargo.toml`, etc.).
   - Submit / publish per your distribution channel's policy.
5. Update `../CONTEXT.md` "Done" with the release identifier.

## Constraints

- Never sign with non-canonical credentials (use the project's declared signing strategy).
- Never disable hooks (`--no-verify`, `--no-gpg-sign`) without explicit human authorization.
- Never push to `main` without an approved PR.

## Done criteria

- Build succeeded; distributed if applicable.
- Release notes drafted in user-facing language (no internal tech jargon).
- `CONTEXT.md` updated.
