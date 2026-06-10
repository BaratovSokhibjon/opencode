---
description: Analyze changes, group by concern, and create Conventional Commits with branch convention check.
agent: commit
---

Prepare commits for: $ARGUMENTS

Inspect all staged/unstaged changes. Confirm branch name follows `<type>/<description>` or `<type>/<ISSUE-KEY>-<description>` convention (e.g. `feat/user-auth`, `fix/PROJ-123-login-crash`). Group changes by logical concern, use Conventional Commits (feat/fix/refactor/chore/docs/test/perf/ci/build) with Jira/Linear keys when visible. Show a plan and wait for explicit confirmation before staging or committing. Never commit `.env` or secrets.
