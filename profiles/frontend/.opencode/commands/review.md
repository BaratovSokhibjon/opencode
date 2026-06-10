---
description: Structured code review with PR checklist, CRITICAL/WARNING/SUGGESTION/TESTS findings, and verdict.
agent: review
subtask: true
---

Review: $ARGUMENTS

Check PR description completeness first (what/why/how, breaking changes, new dependencies, new/changed env vars, setup requirements, branch naming, PR title format). Then inspect diffs for correctness, security (all client inputs untrusted: headers/query/body/path/files/WebSocket), performance, logging (no PII/secrets), and maintainability. Report concrete file/line findings grouped by CRITICAL, WARNING, SUGGESTION, TESTS. Include counts and APPROVE or REQUEST_CHANGES verdict. Do not edit files.
