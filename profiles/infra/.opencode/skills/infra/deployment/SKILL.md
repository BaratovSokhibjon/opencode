---
name: deployment
description: Checklist for production readiness — env vars, healthchecks, CI/CD gates, registry, server naming, rollback, and post-deploy verification.
---

## Readiness

- [ ] Required env vars documented in `.env.example` or deployment docs — no real values committed.
- [ ] No production secrets or config values hardcoded in source, Dockerfiles, or CI YAML.
- [ ] Service exposes `/health`, `/ping`, or equivalent readiness endpoint.
- [ ] Setup, deploy, and troubleshooting instructions documented in `docs/` or a runbook.
- [ ] `VERSION` file is current; git tag matches (`v<MAJOR>.<MINOR>.<PATCH>`).

## Registry and Images

- [ ] Images pushed to GCR (`gcr.io/<PROJECT_ID>/<IMAGE>:<TAG>`) or Artifact Registry (`<region>-docker.pkg.dev/<PROJECT_ID>/<REPO>/<IMAGE>:<TAG>`).
- [ ] Tags are explicit (e.g. `v1.2.3`, `commit-<sha>`) — `latest` avoided in CI/CD pipelines.
- [ ] No secrets baked into image layers.
- [ ] Base images pinned to specific versions or digests.
- [ ] Vulnerability scanning (Trivy or equivalent) run in CI when available.
- [ ] Images pull-tested from the registry before promoting to production.

## Server Context

- [ ] Target server follows naming convention: `<env>-<ownership>-<region>-<server-id>[-<extra-info>]`
  - Examples: `prod-hbai-kr-s1-4x4090`, `dev-hbai-kr-s4-3080ti`, `staging-hbai-us-s1-web`
- [ ] Deploy target environment confirmed before executing.
- [ ] IAM access uses minimum required role (`roles/artifactregistry.writer` for pushers).

## Release Safety

- [ ] Lint/test/build gates pass before deployment.
- [ ] SemVer bump matches change type: `fix` → PATCH, `feat` → MINOR, `feat!`/`BREAKING CHANGE` → MAJOR.
- [ ] Database migrations reviewed for rollback and data-loss risk.
- [ ] Rollback path documented and tested.
- [ ] Feature flags or staged rollout considered for high-risk changes.
- [ ] After a hotfix merged to `main`, `dev` is updated with the same commits.

## Infrastructure

- [ ] Docker/Compose/Nginx/CI changes are internally consistent.
- [ ] Logs and monitoring confirm service health after deploy.
- [ ] Deploy jobs protected by GitHub Environments or manual approvals when needed.

## Post-Deploy

- [ ] Smoke checks run against the critical user path.
- [ ] Health endpoints and application logs checked after rollout.
- [ ] Known failure signals and rollback triggers documented.
- [ ] Team notified via chat after successful deployment.
