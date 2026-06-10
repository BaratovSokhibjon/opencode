---
name: docker
description: Checklist for Dockerfile and container image work — builds, caching, runtime safety, secrets, and GCR/Artifact Registry conventions.
---

## HumbleBee Dockerfile Conventions (required)

Apply these to every Dockerfile. A full reference implementation sits next to this skill in
[`reference.Dockerfile`](./reference.Dockerfile) — read it and reuse its patterns.

- **`# syntax=docker/dockerfile:1`** as the first line (enables the BuildKit features below).
- **Pin the base image to a fixed version through `ARG`** — e.g. `ARG PYTHON_VERSION=3.10` and
  `ARG BASE_IMAGE=python:${PYTHON_VERSION}-slim-bookworm`. Never `latest` or a floating tag.
- **Multi-stage build** — a `builder` stage with compilers/headers, then a slim runtime stage.
  Install deps in the builder with `--prefix=/install`, then `COPY --from=builder /install /usr/local`.
- **BuildKit cache and bind mounts** instead of copy-then-delete:
  - `RUN --mount=type=cache,target=/root/.cache,sharing=locked ...` for pip/apt caches.
  - `RUN --mount=type=bind,source=requirements.txt,target=requirements.txt ...` to install without a COPY layer.
- **`SHELL ["/bin/bash", "-o", "pipefail", "-c"]`** so piped build steps fail correctly.
- **Lean apt**: `apt-get install -y --no-install-recommends ...`, then remove
  `/var/lib/apt/lists/*`, `/var/cache/apt/archives/*`, `/tmp/*` in the same `RUN` layer.
- **`COPY --chown=${UID}:${GID}`** (and `--chmod=` when needed) — never `COPY` then `chown` in a later layer.
- **Structured runtime dirs** for data / logs / tmp, created and owned by the non-root user.

## Non-root user (required)

- The main process must not run as root. Create a dedicated group/user with **explicit `UID`/`GID`**
  (`addgroup --gid`, `useradd -u … -g …`) and end the final stage with `USER ${UID}:${GID}`.
- Running an earlier stage as root is fine **as long as the process is dropped to the non-root user** —
  either via `USER` in the final stage, or stepped down inside the entrypoint (e.g. `gosu`/`su-exec`)
  when the container must start as root (for example to fix mounted-volume ownership first).

## Entrypoint (required)

- **Always use `docker-entrypoint.sh`.** Put startup logic and the launch command there, not inline in
  `CMD`. Ship it with `COPY --chmod=0770 ./scripts/docker/*.sh /usr/local/bin/` and set
  `ENTRYPOINT ["docker-entrypoint.sh"]`. A starting point sits next to this skill in
  [`docker-entrypoint.sh`](./docker-entrypoint.sh).
- **The entrypoint must `exec` the real process** (or run it under **`tini`**) so it becomes PID 1 and
  receives signals (graceful shutdown, no zombie processes). Never leave the process as a child of the shell.

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
