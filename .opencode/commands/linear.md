---
description: Create or update Linear tickets with branch/PR conventions, acceptance criteria, and breaking change docs.
agent: linear
model: openai/gpt-5.5
---

Prepare a Linear workflow action for: $ARGUMENTS

Use concise imperative title (≤60 chars). Include: what/why, acceptance criteria (checkbox format), breaking changes, new dependencies, setup requirements, new/changed env vars. Branch naming: `<type>/<ISSUE-KEY>-<brief-description>` (e.g. `feat/PROJ-123-user-auth`). PR title: `type(scope): summary`. Link related PRs/docs/logs when available. Ask before creating or updating anything visible externally.
