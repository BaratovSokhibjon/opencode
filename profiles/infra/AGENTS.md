# OpenCode Developer Workflow Pack — `infra` profile

This is the **`infra`** profile of the HumbleBee OpenCode workflow pack. Only the commands, agents, skills, and MCP servers listed below are installed in this profile. The pack works like a small engineering team: primary agents do the work, read-only subagents analyze focused areas, commands are slash-entry points, and skills are reusable checklists agents load on demand.

Typical cycle: **research → plan → implement → test → review → commit**, using the commands available below.

## Commands

Slash commands available in this profile:

| Command           | Purpose                                                                                                           |
| ----------------- | ----------------------------------------------------------------------------------------------------------------- |
| `/architect`      | Architecture design, tradeoff analysis, decomposition, and implementation planning.                               |
| `/research`       | Research external docs, SDKs, APIs, or frameworks before implementation.                                          |
| `/commit`         | Analyze changes, group by concern, and create Conventional Commits with branch convention check.                  |
| `/compose`        | Docker Compose services, override patterns, networks, volumes, env vars, and healthchecks.                        |
| `/deploy-check`   | Production deployment readiness review — env, health, registry, server naming, rollback, and CI/CD gates.         |
| `/deploy`         | Deployment implementation and readiness fixes — registry, server context, rollback, and post-deploy verification. |
| `/docker`         | Dockerfile, image build, caching, runtime safety, and GCR/Artifact Registry work.                                 |
| `/docs`           | Documentation updates — MkDocs pages, README, runbooks, changelogs, with company conventions.                     |
| `/github-actions` | GitHub Actions CI/CD, SemVer releases, permissions, caching, and deploy gates.                                    |
| `/nginx`          | Nginx routing, reverse proxy, TLS, security headers, caching, and upstreams.                                      |
| `/refactor`       | Focused cleanup, dead-code removal, logging fixes, and maintainability refactoring.                               |
| `/review`         | Structured code review with PR checklist, CRITICAL/WARNING/SUGGESTION/TESTS findings, and verdict.                |
| `/security`       | Security review or remediation for code, config, Docker, CI/CD, auth, input validation, and secrets.              |
| `/test`           | Run, analyze, or design focused tests — use scripts/test.sh, read failures fully, never skip tests.               |

## Agents

**Primary** (do the work):

- `architect` — Plans larger changes, decomposes systems, identifies tradeoffs, and produces implementation-ready designs.
- `research` — Researches external documentation, SDKs, APIs, and frameworks before implementation; summarizes auth, endpoints, patterns, breaking changes, and recommended approaches with linked sources. Read-only.
- `commit` — Analyzes changes, groups them by feature, stages granularly, and creates semantic commits following company conventions
- `docs` — Updates docs, READMEs, runbooks, changelogs, and MkDocs knowledge-base pages using project conventions.
- `compose` — Implements Docker Compose services, networks, volumes, env wiring, healthchecks, and override patterns.
- `deployment` — Checks and implements deployment readiness, registry, server context, rollback, monitoring, and post-deploy verification.
- `docker` — Implements Dockerfile, image build, runtime user, caching, container safety, and GCR/Artifact Registry work.
- `github-actions` — Implements GitHub Actions CI/CD workflows, SemVer releases, permissions, caching, and deploy gates.
- `nginx` — Implements Nginx routing, reverse proxy, TLS, security headers, static assets, and upstream health behavior.
- `refactor` — Analyzes and refactors code to follow Google style guides, company conventions, and improve maintainability
- `review` — Reviews recent code changes and produces a structured feedback report with PR and security checklists
- `security` — Reviews and remediates realistic security risks across app code, infrastructure, CI/CD, and docs.
- `tester` — Runs tests, analyzes failures, verifies fixes, and reports focused reproduction steps.

**Subagents** (read-only analysis):

- `infra/compose-service-analyzer` — Read-only specialist for Compose services, networks, volumes, ports, env vars, healthchecks, and data safety.
- `infra/deployment-readiness-checker` — Read-only specialist for production readiness, config completeness, healthchecks, registry, server naming, rollback, and post-deploy checks.
- `infra/docker-build-analyzer` — Read-only specialist for Dockerfile build correctness, caching, image size, runtime safety, and secret leakage.
- `infra/github-actions-workflow-analyzer` — Read-only specialist for GitHub Actions workflows, test gates, build artifacts, secrets, caches, deploy safety, and releases.
- `infra/nginx-routing-analyzer` — Read-only specialist for Nginx routes, upstreams, TLS, proxy headers, caching, and security headers.
- `security/risk-scanner` — Read-only scanner for realistic security risks in code, configuration, Docker, CI/CD, and documentation.

## Skills

Reusable checklists, loaded on demand:

- `compose` — Checklist for Docker Compose services — file naming, override patterns, networks, volumes, env vars, ports, healthchecks.
- `deployment` — Checklist for production readiness — env vars, healthchecks, CI/CD gates, registry, server naming, rollback, and post-deploy verification.
- `docker` — Checklist for Dockerfile and container image work — builds, caching, runtime safety, secrets, and GCR/Artifact Registry conventions.
- `github-actions` — Checklist for GitHub Actions CI/CD — gates, permissions, secrets, caching, artifacts, SemVer versioning, and releases.
- `nginx` — Checklist for Nginx routing — reverse proxy, TLS, security headers, upstreams, caching, and static assets.
- `security` — Checklist for security review — auth, secrets, input validation, injection, SSRF, XSS, CORS, logging, Docker, and CI/CD risks.
- `testing` — Checklist for focused tests, failure analysis, regression coverage, and verification reporting.

## MCP servers

- `context7` — enabled
- `github` — disabled (set `"enabled": true` and provide credentials to use)

## Permissions

`bash` runs under an allow-list defined in `opencode.json`: read-only inspection, version checks, linters, formatters, and test runners execute without a prompt; state-changing git and anything unrecognized prompts for confirmation; destructive commands are denied. Run safe inspection commands freely — reserve confirmation for operations that actually change state. Subagents are fully read-only. Use the `context7` MCP to fetch current library docs before writing non-trivial code against a dependency — don't rely on memory for API details.

## Safety Rules

These apply to every agent in this pack:

1. **Never commit without user confirmation.** Stage changes, show a diff summary, and wait.
2. **Never run destructive commands** (`DROP TABLE`, `rm -rf`, `kubectl delete`, `docker system prune`) without explicit confirmation.
3. **Never expose or log secrets.** Refuse tasks that would write credentials to files, stdout, or commit history.
4. **Prefer small, reversible changes.** One logical change per commit. Avoid large rewrites unless explicitly requested.
5. **Summarize before acting.** When about to make changes, briefly state: what files will change, what the risk is, and whether tests cover it.

## Output Convention

When an agent completes a task, it should report:

```
Changed: <list of modified files>
Risk:    <none | low | medium — with reason>
Tests:   <added | existing | none — with reason>
```

If risk is medium or higher, wait for confirmation before proceeding.
