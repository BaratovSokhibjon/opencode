---
name: security
description: Checklist for security review — auth, secrets, input validation, injection, SSRF, XSS, CORS, logging, Docker, and CI/CD risks.
---

## Secrets

- [ ] No secrets, tokens, passwords, private keys, or `.env` values in source/config/docs/CI YAML.
- [ ] CI secrets live in GitHub Secrets/Environments — never inline in workflow YAML.
- [ ] Docker images do not copy secrets into any layer.
- [ ] If a secret was committed, rotate it immediately — removal from git history alone is insufficient.
- [ ] `.env` is gitignored; `.env.example` contains placeholders only.

## Auth and Authorization

- [ ] Tokens/sessions validate signature, expiry, and revocation rules.
- [ ] Logout invalidates sessions/refresh tokens where applicable.
- [ ] Every data access checks ownership or role — no IDOR via user-controlled IDs.
- [ ] Admin/destructive operations require explicit authorization.
- [ ] Auth checks run before protected logic, not after.

## Input Validation (All Client Inputs Are UNTRUSTED)

All inputs from clients must be validated and sanitized:

- [ ] HTTP inputs: headers, query parameters, request body, path parameters.
- [ ] Message inputs: WebSocket messages, message queue data.
- [ ] File uploads: file names, file contents, file sizes, MIME types.
- [ ] User inputs: form data, search queries, free-text fields.

## Injection Prevention

- [ ] DB queries are parameterized — no string concatenation with user input.
- [ ] Shell commands avoid user-input interpolation.
- [ ] File paths are normalized and scoped — no path traversal.
- [ ] Templates escape user content by default — no raw HTML injection.

## Web Risks

- [ ] User content is not injected as raw HTML (`innerHTML`, `dangerouslySetInnerHTML`).
- [ ] User-supplied URLs are validated and block localhost/metadata targets (SSRF prevention).
- [ ] Authenticated APIs do not use wildcard CORS (`Access-Control-Allow-Origin: *`).
- [ ] External links with `target="_blank"` include `rel="noopener noreferrer"`.
- [ ] CSRF protection enabled on state-changing endpoints.

## Logging and Data Safety

- [ ] No passwords, tokens, API keys, or PII (names, emails, phone numbers) appear in logs.
- [ ] Error messages returned to clients do not expose internal details or stack traces.
- [ ] Sensitive model fields use `SecretStr` (Pydantic) or equivalent to prevent accidental logging.

## Infra and CI

- [ ] Containers avoid root/privileged mode unless explicitly justified.
- [ ] CI permissions are least-privilege (`contents: read` by default).
- [ ] Forked PRs cannot access production secrets.
- [ ] GCR/Artifact Registry access uses IAM roles, not broad service account keys.
