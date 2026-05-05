<div align="center">
  <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/opencode.svg" width="100" alt="opencode logo" />
  <h1>opencode config</h1>
  <p>Personal <a href="https://opencode.ai">opencode</a> configuration with custom AI agents for code review, semantic commits, and refactoring.</p>
</div>

---

## Overview

This repository contains a ready-to-use [opencode](https://opencode.ai) workspace configuration. It ships with three purpose-built agents and sensible defaults for permissions and formatting.

## Getting Started

1. **Install opencode**

   ```bash
   npm install -g opencode-ai
   ```

2. **Clone this config into your project**

   Copy the files below into the root of any project you want to use opencode with:

   ```
   .env.example      → environment variable template
   .ignore           → paths opencode should never index
   opencode.json     → main configuration
   .opencode/        → agent definitions
   ```

3. **Set up your environment**

   ```bash
   cp .env.example .env
   ```

   | Variable                  | Description                                   |
   | ------------------------- | --------------------------------------------- |
   | `OPENCODE_ENABLE_EXA`     | Set to `1` to enable Exa web search           |
   | `OPENCODE_EXPERIMENTAL`   | Set to `true` to unlock experimental features |

4. **Run opencode**

   ```bash
   opencode
   ```

## Configuration

`opencode.json` sets the following defaults:

| Setting       | Value                                                              |
| ------------- | ------------------------------------------------------------------ |
| Formatter     | Prettier (`npx prettier --write $FILE`)                            |
| Instructions  | `CONTRIBUTING.md`, `docs/guidelines.md` (add to your project)     |
| Permissions   | Read / grep / glob / list / LSP / question / todowrite / webfetch → **allow**; bash → **ask** |

## Custom Agents

### `review` — Code Review

Performs a structured read-only code review of all current changes and writes a report to `/tmp/code-review.md`.

**Findings are categorised as:**
- 🔴 **CRITICAL** — bugs, security issues, data-loss risks
- 🟡 **WARNING** — style violations, performance concerns, missing error handling
- 🔵 **SUGGESTION** — readability improvements and structural enhancements

**Usage:**

```
/agent review
```

---

### `commit` — Semantic Commits

Analyses all uncommitted changes, groups them by logical concern (not by file), and creates clean [Conventional Commits](https://www.conventionalcommits.org/) — one commit per feature/fix/chore.

**Commit types supported:** `feat`, `fix`, `refactor`, `chore`, `docs`, `style`, `test`, `perf`, `ci`, `build`

> The agent always presents a plan and waits for your confirmation before staging anything.

**Usage:**

```
/agent commit
```

---

### `refactor` — Google Style Refactor

Refactors changed files to follow [Google Style Guides](https://google.github.io/styleguide/) for Python, TypeScript/JavaScript, Go, Java, and C++. It adds section markers (`MARK:`), removes dead code, enforces naming conventions, and breaks down long functions.

**Usage:**

```
/agent refactor
```

## File Structure

```
.
├── .env.example             # Environment variable template
├── .ignore                  # Paths excluded from opencode indexing
├── opencode.json            # Main opencode configuration
└── .opencode/
    └── agents/
        ├── commit.md        # Semantic commit agent
        ├── refactor.md      # Google-style refactor agent
        └── review.md        # Code review agent
```

## License

MIT
