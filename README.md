<div align="center">
  <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/opencode.svg" width="100" alt="opencode logo" />
  <h1>OpenCode Developer Workflow Pack</h1>
  <p>A reusable, <strong>profile-based</strong> <a href="https://opencode.ai">OpenCode</a> configuration from HumbleBee AI. Each profile is a small engineering team scoped to one kind of work — only the commands, skills, agents, and MCP servers that profile actually needs.</p>
</div>

---

## Why profiles

OpenCode discovers every command in `.opencode/commands/` and can't hide them through config. So instead of one bloated setup where a frontend engineer sees Docker, Nginx, and database commands, the pack ships **self-contained profiles** — each its own `.opencode/`, `opencode.json`, and docs. You pick the profile that matches your work and get a lean, focused toolset.

| Profile     | Commands                                                                   | Skills                                   | MCP servers              |
| ----------- | ------------------------------------------------------------------------- | ---------------------------------------- | ------------------------ |
| `frontend`  | architect, frontend, test, review, refactor, commit, docs                 | frontend, testing                        | context7, playwright     |
| `backend`   | architect, backend, security, test, review, refactor, commit, docs        | backend, security, testing               | context7, postgres       |
| `infra`     | architect, docker, compose, nginx, github-actions, deploy, deploy-check, security, test, review, refactor, commit, docs | docker, compose, nginx, github-actions, deployment, security, testing | context7, github         |
| `fullstack` | everything (all 16 commands)                                              | all                                      | context7, playwright, github, postgres, linear |

Every profile includes the shared core — `architect`, `test`, `review`, `refactor`, `commit`, `docs` — plus the matching read-only analyzer subagents. `security` is in backend/infra/fullstack; `linear` lives only in fullstack.

### Framework profiles

Narrower specializations that layer HumbleBee's framework conventions (as a loadable skill) on top of a domain base. The skills also ship in `fullstack`.

| Profile      | Based on            | Convention skill         | Notes                                                        |
| ------------ | ------------------- | ------------------------ | ----------------------------------------------------------- |
| `fastapi`    | backend             | `frameworks/fastapi`     | scaffolds from `rest-fastapi-template` / `-orm-template`     |
| `nextjs`     | frontend            | `frameworks/nextjs`      | Next.js App Router + shadcn/ui                               |
| `python-sdk` | backend (lean)      | `frameworks/python-sdk`  | scaffolds from `module-python-template`                      |
| `docs`       | docs + core         | `frameworks/docs-mkdocs` | scaffolds from `docs-mkdocs-template`                        |
| `docker`     | docker + compose    | `infra/docker` (enriched) | ships `reference.Dockerfile` + `docker-entrypoint.sh`; conventions enforced by the docker-build analyzer |

The `docker` skill encodes the required Dockerfile conventions — `# syntax` directive, version-pinned base, multi-stage builds, BuildKit cache/bind mounts, non-root user (with root→user drop in the entrypoint), and `docker-entrypoint.sh` that `exec`s under `tini`. Compose: `compose.yml` (not `docker-compose.yml`) and no fixed `container_name`.

## Use a profile

**Option A — run it in place:**

```bash
cd profiles/frontend
opencode
```

**Option B — install it into your project:**

```bash
./install.sh frontend /path/to/your/project
```

The installer copies the profile's `.opencode/`, `opencode.json`, `AGENTS.md`, `.env.example`, and `.ignore` into the target. It backs up an existing `.opencode/` and never clobbers an existing `opencode.json` or `AGENTS.md`.

## Requirements

- [OpenCode](https://opencode.ai): `npm install -g opencode-ai`
- A model configured in OpenCode. The pack is **provider-agnostic** — it pins no model, so every agent and command uses your configured default (Anthropic, OpenAI, any provider). Set one by running `opencode` and picking a model, or add a top-level default to the profile's `opencode.json`:

  ```json
  { "model": "anthropic/claude-sonnet-4-6" }
  ```

## Environment & MCP servers

```bash
cd profiles/<name>
cp .env.example .env
```

`context7` (live library docs) is enabled in every profile and needs no credentials. The rest are scoped per profile and only need setup when you use them:

| Server       | In profiles            | Default      | Needs                          |
| ------------ | ---------------------- | ------------ | ------------------------------ |
| `context7`   | all                    | **enabled**  | nothing                        |
| `playwright` | frontend, fullstack    | **enabled**  | nothing (downloads a browser)  |
| `postgres`   | backend, fullstack     | disabled     | `DATABASE_URL`                 |
| `github`     | infra, fullstack       | disabled     | `GITHUB_TOKEN`                 |
| `linear`     | fullstack              | disabled     | Linear OAuth (backs `/linear`) |

Credentialed servers ship disabled so a fresh clone never errors. Flip `"enabled": true` in the profile's `opencode.json` and add the env var to enable one.

## Permissions

`bash` runs under a pattern allow-list (shared across all profiles): read-only inspection, version checks, linters/formatters, and test runners run without a prompt; state-changing git and unrecognized commands prompt; destructive commands (`rm -rf`, `sudo`, `git push --force`, …) are denied. Subagents are fully read-only. Details and the full list are in each profile's `AGENTS.md` and `opencode.json` → `permission.bash`.

## Customizing & extending

`profiles/fullstack/` is the **source of truth**. The other profiles are generated from it — don't hand-edit them.

```bash
# 1. edit the library: profiles/fullstack/.opencode/ or profiles/fullstack/opencode.json
# 2. regenerate the scoped profiles:
./build-profiles.sh
```

**Add a profile** — for a new framework or a finer variant (the `fastapi`, `nextjs`, `python-sdk`, `docs`, and `docker` profiles are built exactly this way): drop a convention skill under `profiles/fullstack/.opencode/skills/frameworks/<name>/`, add a `build_profile` call in `build-profiles.sh` listing the agents, commands, skills, MCP set, and default agent it needs, then re-run. Keeping profiles narrow — by domain or by framework — is the point.

## Repo structure

```
.
├── README.md
├── install.sh                 # install a profile into a project
├── build-profiles.sh          # regenerate scoped profiles from fullstack
└── profiles/
    ├── fullstack/             # SOURCE OF TRUTH — full library, hand-edited
    │   ├── .opencode/{agents,commands,skills}/
    │   ├── opencode.json
    │   ├── AGENTS.md
    │   ├── .env.example
    │   └── .ignore
    ├── frontend/              # generated slice
    ├── backend/               # generated slice
    ├── infra/                 # generated slice
    ├── fastapi/               # generated — backend + FastAPI conventions
    ├── nextjs/                # generated — frontend + Next.js/shadcn conventions
    ├── python-sdk/            # generated — Python library + conventions
    ├── docs/                  # generated — MkDocs documentation
    └── docker/                # generated — Dockerfile + Compose conventions
```

## License

MIT
