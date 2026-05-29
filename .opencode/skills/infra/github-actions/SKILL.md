---
name: github-actions
description: Checklist for GitHub Actions CI/CD — gates, permissions, secrets, caching, artifacts, SemVer versioning, and releases.
---

## Workflow Shape

- [ ] Triggers match intent: PR checks on `dev`/`main`, builds on tag push, manual dispatch for deploys.
- [ ] Jobs are named clearly and ordered by dependencies (`needs:`).
- [ ] Lint, test, build, and deploy are separate gates — not combined into one job.
- [ ] Deployment jobs require successful test/build jobs.
- [ ] Environment promotion follows GitFlow: `dev → main → staging → prod`.

## Versioning and Releases

- [ ] Release tags follow SemVer: `v<MAJOR>.<MINOR>.<PATCH>` (e.g. `v1.4.2`).
- [ ] Git tag matches the version in `VERSION`, `package.json`, `pyproject.toml`, or `Cargo.toml`.
- [ ] Conventional Commit type determines the SemVer bump automatically:
  - `fix` → PATCH
  - `feat` → MINOR
  - `feat!` or `BREAKING CHANGE:` footer → MAJOR
- [ ] `.github/release.yml` categorizes release notes by Conventional Commit types.
- [ ] `CHANGELOG.md` generated or updated on release when tooling is configured.

## Security

- [ ] `permissions` set to least-privilege at workflow or job level (`contents: read` by default).
- [ ] Forked PRs cannot access production secrets — use `pull_request`, not `pull_request_target`, for untrusted code.
- [ ] Secrets referenced from GitHub Secrets/Environments — never inline in YAML.
- [ ] Shell commands quote all variables — no untrusted input interpolation.
- [ ] Actions pinned to a stable release tag or commit SHA — not `@main` or `@master`.

## Image Build and Push

- [ ] Docker images tagged with SemVer and/or commit SHA.
- [ ] Images pushed to GCR or Artifact Registry using Workload Identity or stored credentials.
- [ ] `latest` not used as the primary deployment reference in CI.
- [ ] Vulnerability scan step runs after image build when enabled (Trivy or equivalent).

## Dependencies and Caching

- [ ] `dependabot.yml` or Renovate configured for automated dependency updates.
- [ ] Cache keys include dependency lockfiles and OS/runtime dimensions.
- [ ] Cache restore paths do not mix incompatible dependency sets across jobs.

## Artifacts and Releases

- [ ] Artifacts have explicit names and retention periods where relevant.
- [ ] Release labels/categories follow `.github/release.yml` conventions.
- [ ] Build outputs uploaded as artifacts — never committed to the repository.

## Verification

- [ ] YAML syntax validated before merge.
- [ ] Changed workflows reviewed for secret exposure and deploy permission risk.
- [ ] Workflow runs end-to-end in a branch before merging to `dev` or `main`.
