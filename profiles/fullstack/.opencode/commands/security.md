---
description: Security review or remediation for code, config, Docker, CI/CD, auth, input validation, and secrets.
agent: security/security
subtask: true
---

Load the security skill. Review or fix this security concern: $ARGUMENTS

Treat all client inputs as UNTRUSTED (HTTP headers, query, body, path, file uploads, WebSocket). Prioritize realistic risks: secrets in source/Docker/CI, auth/authz bypasses, injection (SQL/shell/XSS/path traversal), SSRF, wildcard CORS, PII in logs, CI permission exposure. Never print or echo secret values. Recommend rotation for any committed secrets.
