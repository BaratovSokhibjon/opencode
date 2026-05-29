---
description: Backend API, service, database, auth, validation, logging, and integration work.
agent: backend/backend
model: openai/gpt-5.5
---

Load the backend and testing skills when relevant. Work on this backend request: $ARGUMENTS

Validate ALL client inputs at boundaries (headers, path params, query params, body, file uploads). Enforce auth before logic using identity/role — not caller-supplied IDs. Use structured JSON logging with request_id/trace_id; never log PII or secrets. Follow existing project patterns, prefer additive migrations, run `scripts/test.sh` before completion, and report Changed / Risk / Tests.
