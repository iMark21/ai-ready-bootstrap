# Contributing

Contributions are welcome. Bug reports, feature requests, new runtime adapters, additional project type support, and documentation improvements are all useful.

If you are unsure whether something is a good fit, open an issue first to discuss it before writing code.

## Branching

- `develop` is the default integration branch
- `main` is reserved for release-ready history
- create short-lived branches from `develop`

Examples:

- `feature/ci-release-flow`
- `fix/standardize-backup`
- `docs/readme-polish`

## Commits

- format: `[branch_name] type: "title"`
- types: `feat`, `fix`, `refactor`, `docs`, `chore`, `test`, `style`
- do not add AI co-author trailers

## Merge Flow

1. branch from `develop`
2. commit on the feature branch
3. merge back into `develop`
4. move `main` only through a deliberate release step

## Validation

Before pushing:

- run `bash -n bin/agentlayer`
- run the smoke checks you touched
- keep README and MANUAL aligned with the actual CLI
