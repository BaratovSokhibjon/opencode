# OpenCode Developer Workflow Pack — `fastapi` profile

This is the **`fastapi`** profile of the HumbleBee OpenCode workflow pack. Only the commands, agents, skills, and MCP servers listed below are installed in this profile. The pack works like a small engineering team: primary agents do the work, read-only subagents analyze focused areas, commands are slash-entry points, and skills are reusable checklists agents load on demand.

Typical cycle: **plan → implement → test → review → commit**, using the commands available below.

## Commands

Slash commands available in this profile:

| Command | Purpose |
| --- | --- |
| `/architect` | Architecture design, tradeoff analysis, decomposition, and implementation planning. |
| `/backend` | Backend API, service, database, auth, validation, logging, and integration work. |
| `/commit` | Analyze changes, group by concern, and create Conventional Commits with branch convention check. |
| `/docs` | Documentation updates — MkDocs pages, README, runbooks, changelogs, with company conventions. |
| `/refactor` | Focused cleanup, dead-code removal, logging fixes, and maintainability refactoring. |
| `/review` | Structured code review with PR checklist, CRITICAL/WARNING/SUGGESTION/TESTS findings, and verdict. |
| `/security` | Security review or remediation for code, config, Docker, CI/CD, auth, input validation, and secrets. |
| `/test` | Run, analyze, or design focused tests — use scripts/test.sh, read failures fully, never skip tests. |

## Agents

**Primary** (do the work):

- `architect` — Plans larger changes, decomposes systems, identifies tradeoffs, and produces implementation-ready designs.
- `backend/backend` — Implements backend API, service, database, authentication, validation, logging, and integration work.
- `commit` — Analyzes changes, groups them by feature, stages granularly, and creates semantic commits following company conventions
- `docs` — Updates docs, READMEs, runbooks, changelogs, and MkDocs knowledge-base pages using project conventions.
- `refactor` — Analyzes and refactors code to follow Google style guides, company conventions, and improve maintainability
- `review` — Reviews recent code changes and produces a structured feedback report with PR and security checklists
- `security/security` — Reviews and remediates realistic security risks across app code, infrastructure, CI/CD, and docs.
- `tester` — Runs tests, analyzes failures, verifies fixes, and reports focused reproduction steps.

**Subagents** (read-only analysis):

- `backend/api-analyzer` — Read-only specialist for backend routes, handlers, validation, response contracts, and API error behavior.
- `backend/auth-checker` — Read-only specialist for authentication, authorization, session, token, and tenant-boundary risks.
- `backend/db-analyzer` — Read-only specialist for database queries, migrations, transactions, indexes, and data consistency risks.
- `backend/performance-analyzer` — Read-only specialist for backend performance and resilience — caching, connection pooling, rate limiting, async offloading, timeouts, retries, and idempotency.
- `security/risk-scanner` — Read-only scanner for realistic security risks in code, configuration, Docker, CI/CD, and documentation.

## Skills

Reusable checklists, loaded on demand:

- `backend` — Checklist for backend implementation — APIs, services, DB, auth, validation, logging, and tests.
- `fastapi` — HumbleBee FastAPI REST service conventions — scaffold from the company template, then structure, validation, auth, and logging.
- `security` — Checklist for security review — auth, secrets, input validation, injection, SSRF, XSS, CORS, logging, Docker, and CI/CD risks.
- `testing` — Checklist for focused tests, failure analysis, regression coverage, and verification reporting.

## MCP servers

- `context7` — enabled
- `postgres` — disabled (set `"enabled": true` and provide credentials to use)

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
