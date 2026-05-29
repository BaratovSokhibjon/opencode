---
description: Run, analyze, or design focused tests — use scripts/test.sh, read failures fully, never skip tests.
agent: tester
model: openai/gpt-5.5
---

Test or verify: $ARGUMENTS

Use `scripts/test.sh` or the project-standard test command. Find the smallest meaningful test command first. Bug fixes must include a regression test. Read failures fully — distinguish test defect, implementation defect, environment gap, or flake. Report exact commands, exit codes, and failure snippets. Never claim pass without fresh output.
