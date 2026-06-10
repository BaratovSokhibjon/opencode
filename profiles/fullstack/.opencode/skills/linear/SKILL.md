---
name: linear
description: Checklist for Linear ticket drafting and updates — title, context, acceptance criteria, branch/PR links, and follow-through.
---

## Ticket Title

- [ ] Imperative verb, ≤60 characters: describes the outcome, not the symptom.
- [ ] Specific enough to understand without reading the body.
- [ ] Include the issue key when known: `[PROJ-123] Add Google OAuth login`.
- [ ] Avoid vague titles like "Fix bug" or "Update code" — name the component and what changes.

Good: `[PROJ-88] Rate-limit password reset endpoint`
Bad: `Fix security issue`

## Description

- [ ] **Context**: why this work matters — the user impact or business reason.
- [ ] **Current behavior**: what happens today (for bugs: exact reproduction steps).
- [ ] **Expected behavior**: what should happen after the change.
- [ ] **Technical notes**: relevant implementation constraints, related files, or prior art.
- [ ] Does not contain real credentials, private tokens, internal server IPs, or sensitive data.

## Acceptance Criteria

- [ ] Written as a checkbox list — each item is independently testable.
- [ ] Written from the user's or system's perspective, not the implementer's.
- [ ] Edge cases and failure paths included, not just the happy path.
- [ ] No ambiguous items — if it can be interpreted two ways, rewrite it.

Example format:

```text
- [ ] User can log in with a Google account on /login
- [ ] Existing email/password accounts are unaffected
- [ ] Auth token expires after 7 days; silent refresh on expiry
- [ ] Login fails gracefully if Google is unavailable (user sees error message)
```

## Explicit Call-outs

When any of these apply, state them explicitly in the description:

- [ ] **Breaking change**: describe what breaks and who is affected.
- [ ] **New dependency**: library name, version, why it was chosen over alternatives.
- [ ] **New/changed env vars**: variable name, purpose, where to get the value.
- [ ] **Setup required**: migration to run, script to execute, config to set before deploy.
- [ ] **Rollout risk**: data migration, performance impact, feature flag needed.

## Labels and Priority

- [ ] Label reflects the type: `bug` / `feature` / `chore` / `tech-debt` / `infra` / `security`.
- [ ] Priority set: `Urgent` (blocks current release) / `High` (current sprint) / `Medium` (next sprint) / `Low` (backlog).

## Links and Branch Convention

- [ ] Branch name follows: `<type>/<ISSUE-KEY>-<brief-description>` e.g. `feat/PROJ-123-google-oauth`.
- [ ] PR title follows Conventional Commits: `type(scope): summary` e.g. `feat(auth): add Google OAuth login`.
- [ ] Related PRs, docs, error logs, screenshots, or recordings linked when available.
- [ ] Parent, blocking, and blocked-by issue relationships set when relevant.

## Workflow

- [ ] Team, project, status, and assignee set before sharing externally.
- [ ] Do not create or update a ticket visible to the team without explicit user confirmation.
- [ ] After creation: output ticket URL, title, suggested branch name, and next action.
