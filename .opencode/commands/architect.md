---
description: Architecture design, tradeoff analysis, decomposition, and implementation planning.
agent: architect
model: openai/gpt-5.5
---

Read relevant code, docs, deployment context (Docker/Compose/CI), and constraints first. Then analyze and plan: $ARGUMENTS

Identify tradeoffs and risks. Propose small reversible slices that decompose cleanly into independently testable units. Respect company file structure (all source in `src/`, `tests/` mirrors `src/`). Produce an implementation-ready plan with exact files, commands, and verification steps only when scope is clear.
