---
description: Production deployment readiness review — env, health, registry, server naming, rollback, and CI/CD gates.
agent: infra/deployment
model: openai/gpt-5.5
subtask: true
---

Perform a deployment readiness review for: $ARGUMENTS

Inspect: `.env.example` completeness, secrets handling, Docker/Compose (`compose.yml` naming, `compose.override.yml` pattern), CI/CD gates, Nginx, migrations, `/health`/`/ping`, logs, rollback plan, and post-deploy smoke checks. Verify `VERSION` file matches git tag (`v<MAJOR>.<MINOR>.<PATCH>`). Confirm images are in GCR/Artifact Registry with explicit tags. Check server naming follows `<env>-<ownership>-<region>-<server-id>[-<extra-info>]`. Produce blockers, warnings, and required checks. Do not edit files unless explicitly asked.
