---
name: compose
description: Checklist for Docker Compose services — file naming, override patterns, networks, volumes, env vars, ports, healthchecks.
---

## File Naming and Override Pattern

- [ ] Main file is named `compose.yml` — not `docker-compose.yml`.
- [ ] Local overrides use `compose.override.yml` (Docker auto-loads it); this file is gitignored.
- [ ] Environment-specific templates live in `templates/compose/`:
  - `compose.override.dev.yml`
  - `compose.override.staging.yml`
  - `compose.override.prod.yml`
- [ ] Developers copy the relevant template to `compose.override.yml` for local use.
- [ ] Templates are shared defaults — never edited for personal tweaks.
- [ ] Changes meant for everyone go into the template, not a personal override.
- [ ] Avoid chaining multiple `-f` flags — prefer `compose.yml` + `compose.override.yml`.

## Services

- [ ] Service names are meaningful, lowercase, and consistent with project conventions.
- [ ] Images/build contexts point to the intended Dockerfiles.
- [ ] Commands and entrypoints are explicit when overriding image defaults.
- [ ] Profiles separate optional/local-only services when needed.

## Networking and Ports

- [ ] Internal service-to-service traffic uses named Compose networks, not host ports.
- [ ] Only externally needed ports are published.
- [ ] Port mappings are documented and avoid common local port conflicts.

## Environment and Secrets

- [ ] Required environment variables documented in `.env.example` — no real values committed.
- [ ] Secrets are not hardcoded in compose YAML — reference `env_file: .env`.
- [ ] `.env` is gitignored; `.env.example` is the committed template.
- [ ] Local/staging/production env concerns are clearly separated by override files.

## Volumes and Data

- [ ] Persistent data uses named volumes.
- [ ] Anonymous volumes are avoided for databases and stateful services.
- [ ] `logs/` and `data/` in the repo are gitignored symlinks pointing to external paths.
- [ ] Destructive cleanup commands (`docker volume rm`, `docker system prune`) are never issued by default.

## Health and Startup

- [ ] Depended-on services expose healthchecks.
- [ ] `depends_on` with `condition: service_healthy` used where startup order matters.
- [ ] `docker compose config` validation passes before proceeding.

## Verification

- [ ] `docker compose up --build` succeeds from a clean state.
- [ ] All services reach their expected health status.
- [ ] Override workflow tested: copy template → `docker compose up` → service reachable.
