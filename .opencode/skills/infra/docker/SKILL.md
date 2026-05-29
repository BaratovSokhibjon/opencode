---
name: docker
description: Checklist for Dockerfile and container image work — builds, caching, runtime safety, secrets, and GCR/Artifact Registry conventions.
---

## Build Correctness

- [ ] Base image pinned to a specific version or digest — no floating `latest` in production.
- [ ] Multi-stage build separates build dependencies from runtime image when useful.
- [ ] Dependency install happens before copying frequently-changing source files (layer cache efficiency).
- [ ] Build context limited by a correct `.dockerignore` — exclude `.env`, `node_modules`, `.git`, `logs/`, `data/`.

## Runtime Safety

- [ ] Final image runs as a non-root user (`USER nonroot` or equivalent).
- [ ] Entrypoint/CMD matches the deployed process exactly.
- [ ] Healthcheck or service-level readiness documented where applicable.
- [ ] Only necessary runtime files copied into the final image.
- [ ] Container does not run with `--privileged` or unnecessary Linux capabilities.

## Secrets and Supply Chain

- [ ] No `.env`, tokens, SSH keys, credentials, or private files copied into any image layer.
- [ ] Build args do not carry secrets — use `--secret` mounts for sensitive build-time values.
- [ ] Package manager caches do not persist credentials across layers.
- [ ] Base images are official or company-approved — not random third-party images.

## Registry (GCR / Artifact Registry)

- [ ] Private images stored in GCR (`gcr.io/<PROJECT_ID>/<IMAGE>:<TAG>`) or Artifact Registry (`<region>-docker.pkg.dev/<PROJECT_ID>/<REPO>/<IMAGE>:<TAG>`).
- [ ] Tags are explicit (e.g. `v1.2.3`, `commit-<sha>`) — `latest` avoided as a deployment reference.
- [ ] Docker auth configured via `gcloud auth configure-docker` or Workload Identity in CI.
- [ ] Pusher account granted `roles/artifactregistry.writer` — not broader roles.
- [ ] Tags treated as immutable — publish a new tag for any change, never retag.
- [ ] Vulnerability scanning (`trivy image <image>`) run in CI when enabled.
- [ ] Cleanup/retention policies configured via Artifact Registry lifecycle rules.

## Verification

- [ ] `docker build` succeeds without errors.
- [ ] Container starts and responds correctly locally or via Compose.
- [ ] Image size and final layer contents are reasonable for the project type.
- [ ] Pushed image pull-tested from the registry before promoting to staging or production.
