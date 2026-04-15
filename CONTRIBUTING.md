# Contributing

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

- run `bash -n bin/ai-ready`
- run the smoke checks you touched
- keep README and MANUAL aligned with the actual CLI
