---
name: backend
description: Checklist for backend implementation — APIs, services, DB, auth, validation, logging, and tests.
---

## Project Structure

- [ ] All source code lives in `src/`.
- [ ] `scripts/` contains automation helpers (`build.sh`, `test.sh`, `bump-version.sh`).
- [ ] `.env.example` is up to date with all required variables — no real values committed.
- [ ] `VERSION` file reflects the current SemVer release (`MAJOR.MINOR.PATCH`).
- [ ] `tests/` mirrors the `src/` directory structure.

## API Contracts

- [ ] Route follows the project's REST/RPC convention and version prefix (e.g. `/api/v1/`).
- [ ] All client inputs validated at the boundary — headers, path params, query params, request body.
- [ ] Response shape and HTTP status codes are consistent with existing APIs.
- [ ] Pagination/filtering defaults are safe for list endpoints.

## Business Logic

- [ ] Business rules live in service/domain code, not in route handlers.
- [ ] Route handlers stay thin and orchestration-focused.
- [ ] Side effects (email, queue, cache, webhooks) are isolated and independently testable.

## Data Layer

- [ ] Queries are parameterized — no string concatenation with user input.
- [ ] Multi-step writes use transactions.
- [ ] Migrations are additive unless a destructive change is explicitly approved.
- [ ] Indexes support new WHERE/JOIN/ORDER patterns.
- [ ] No N+1 queries — use JOINs or batch loading.

## Auth and Security

- [ ] Auth check runs before protected logic, never after.
- [ ] Authorization uses authenticated identity and role, not caller-supplied IDs (no IDOR risk).
- [ ] Admin/destructive actions have explicit role checks.
- [ ] All client inputs treated as untrusted and sanitized (SQL, HTML, shell commands, file paths).
- [ ] No secrets, credentials, or PII are logged.

## Logging

- [ ] Structured JSON logging used — not plain `print()` or unformatted strings.
- [ ] Log levels match environment: DEBUG (dev), INFO/WARNING (staging/prod).
- [ ] Every log entry includes: `timestamp`, `level`, `message`, `filename`, `line`.
- [ ] Production/distributed logs include: `service`, `request_id`, `trace_id`, `user_id` when applicable.
- [ ] Exceptions logged with full stack trace at the point of context, then re-raised.
- [ ] No passwords, tokens, API keys, or PII (names, emails, phone numbers) in log output.
- [ ] Log rotation configured: max 10–100 MB per file, daily rotation.
- [ ] Separate log files: `error.log` (ERROR/CRITICAL/WARNING), `app.log` (INFO/DEBUG).
- [ ] Console (stdout) output is mandatory; file and remote handlers as needed.

## Error Handling

- [ ] Errors handled explicitly at every level — never silently swallowed.
- [ ] User-facing error messages are clear and do not expose internal details or stack traces.
- [ ] Server-side errors logged with full context before returning safe responses to clients.

## Tests and Verification

- [ ] Unit tests cover service/domain logic.
- [ ] Integration tests cover API success and at least one failure path per endpoint.
- [ ] Auth-protected routes tested with valid and invalid credentials.
- [ ] Bug fixes include a regression test.
- [ ] Run `scripts/test.sh` or the project-standard test command before claiming completion.
