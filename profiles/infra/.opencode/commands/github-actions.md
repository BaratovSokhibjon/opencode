---
description: GitHub Actions CI/CD, SemVer releases, permissions, caching, and deploy gates.
agent: infra/github-actions
---

Load GitHub Actions and security guidance. Work on this workflow request: $ARGUMENTS

Enforce environment promotion: `dev → main → staging → prod`. Release tags follow SemVer (`v<MAJOR>.<MINOR>.<PATCH>`) and must match `VERSION`/`package.json`/`pyproject.toml`. Conventional Commits determine version bump (fix=PATCH, feat=MINOR, feat!/BREAKING CHANGE=MAJOR). Check triggers, least-privilege permissions, secrets in GitHub Secrets/Environments, pinned action versions, caches, artifacts, test/build gates before deploy, and `.github/release.yml` conventions.
