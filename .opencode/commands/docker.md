---
description: Dockerfile, image build, caching, runtime safety, and GCR/Artifact Registry work.
agent: infra/docker
model: openai/gpt-5.5
---

Load docker and security guidance. Work on this Docker request: $ARGUMENTS

Check Dockerfile, .dockerignore, build context, pinned base images, non-root runtime user, multi-stage build, cache layers, and no secrets in layers. For private images: push to GCR (`gcr.io/<PROJECT_ID>/<IMAGE>:<TAG>`) or Artifact Registry with explicit tags (e.g. `v1.2.3`) — never `latest` in CI. Validate with `docker build` and runtime test.
