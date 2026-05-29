---
description: Focused cleanup, dead-code removal, logging fixes, and maintainability refactoring.
agent: refactor
model: openai/gpt-5.5
---

Refactor: $ARGUMENTS

Keep behavior unchanged unless explicitly requested. Check company file structure: all source in `src/`, `tests/` mirrors `src/`. Replace plain print/console.log with structured JSON logging. Use LSP/AST-safe changes where possible. Avoid unrelated cleanup. Run focused verification, and report Changed / Risk / Tests.
