---
description: Docker Compose services, override patterns, networks, volumes, env vars, and healthchecks.
agent: compose
---

Load compose and security guidance. Work on this Compose request: $ARGUMENTS

Use `compose.yml` as the main file name (not `docker-compose.yml`). Use `compose.override.yml` for local overrides (gitignored); environment templates go in `templates/compose/`. Check named volumes, explicit networks, `.env.example` completeness, healthchecks, `depends_on` conditions, port exposure, and syntax with `docker compose config`.
