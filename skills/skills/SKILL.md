---
name: skills
description: HumbleBeeAI agent setup for applying project-ready AI agent profiles and workflows.
---

# HumbleBeeAI Agent Setup
This installs HumbleBee's OpenCode profiles. Any agent can install this skill; applying a profile sets up an OpenCode configuration in the project.

This skill sets up a project with HumbleBee AI's profile-based
[OpenCode](https://opencode.ai) configuration. Each **profile** is a small,
self-contained engineering setup scoped to one kind of work — it ships only the
commands, subagents, skills, and MCP servers that kind of work actually needs.

The profiles are not moved or duplicated by this skill. They live in this repo
under `profiles/<name>/` and are applied into the target project by the repo's
existing installer. This skill is the entry point that tells an agent which
profile to apply and how.

## When to use this skill

Use this skill when the user wants to:

- Set up or bootstrap a HumbleBee AI agent environment in a project.
- Apply a specific profile/project-ready agent workflow (frontend, backend, infra, fullstack, etc.) to a project.
- Get the HumbleBee OpenCode commands, subagents, and MCP servers into a repo.

## Available profiles

Applied with the installer below. Omit the profile name to get `fullstack`
(everything).

| Profile      | For                                             |
| ------------ | ----------------------------------------------- |
| `frontend`   | Frontend work (context7, playwright)            |
| `backend`    | Backend work (context7, postgres)               |
| `infra`      | Docker / Compose / Nginx / CI / deploy (github) |
| `fullstack`  | Everything — all 16 commands, all MCP servers   |
| `fastapi`    | Backend + FastAPI conventions                   |
| `nextjs`     | Frontend + Next.js App Router / shadcn          |
| `python-sdk` | Python library + conventions                    |
| `docs`       | MkDocs documentation                            |
| `docker`     | Dockerfile + Compose conventions                |

The full profile matrix (commands, skills, MCP servers per profile) is in this
repo's `README.md`.

## How to apply a profile

Run this **inside the project you want to set up**. It fetches just that profile
and leaves no installer artifacts behind:

```bash
# a specific profile, e.g. frontend
curl -fsSL https://raw.githubusercontent.com/humblebeeai/opencode/main/install.sh | bash -s -- frontend

# omit the profile for fullstack (everything)
curl -fsSL https://raw.githubusercontent.com/humblebeeai/opencode/main/install.sh | bash
```

The installer drops the profile's `.opencode/`, `opencode.json`, `AGENTS.md`,
`.env.example`, and `.ignore` into the current directory. It backs up an
existing `.opencode/` and never clobbers an existing `opencode.json` / `AGENTS.md`,
so it is safe to run in a populated repo.

## After applying

1. Copy env vars: `cp .env.example .env` (the installer appends, never
   overwrites, if `.env` already exists).
2. Ensure OpenCode is installed: `npm install -g opencode-ai`.
3. Run `opencode`. The pack is **provider-agnostic** — it pins no model, so
   pick your model on first run (Anthropic, OpenAI, any provider).

MCP servers that need credentials (`postgres`, `github`, `linear`) ship
**disabled** so a fresh install never errors; enable them in `opencode.json`
and add the matching env var when you need them. `context7` and `playwright`
work with no credentials.

## Notes

- To try a profile from a clone without installing:
  `cd profiles/<name> && opencode`.
- Profiles are self-contained and edited directly under `profiles/<name>/` —
  there is no build step. `fullstack` is the reference for the complete set.
- This skill intentionally references the existing profiles rather than copying
  them, so the OpenCode setup and its `install.sh` remain the single source of
  truth.