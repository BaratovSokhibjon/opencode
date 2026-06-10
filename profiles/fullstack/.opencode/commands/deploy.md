---
description: Deployment implementation and readiness fixes — registry, server context, rollback, and post-deploy verification.
agent: infra/deployment
---

Load deployment, security, and testing guidance. Work on this deployment request: $ARGUMENTS

Confirm `VERSION` file is current and git tag matches. Verify images are in GCR/Artifact Registry with explicit tags (not `latest`). Check server naming convention (`prod-hbai-kr-s1-4x4090` format). Confirm env docs, health endpoints, lint/build/test gates, migrations, rollback plan, monitoring, and post-deploy smoke checks. After hotfixes to `main`, ensure `dev` is updated. Do not deploy or mutate shared infrastructure without explicit confirmation.
