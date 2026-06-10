---
name: python-sdk
description: HumbleBee Python library/SDK conventions — scaffold from the module template, then packaging, public API, typing, and tests.
---

## Start from the template

Scaffold every new Python module/SDK from the company template:

- https://github.com/humblebeeai/module-python-template

Mirror its layout (`src/<package>/`, `tests/`, `pyproject.toml`, `scripts/`) and tooling rather than
inventing a new structure.

## Conventions

- **`pyproject.toml`** is the single source of build metadata and dependencies; keep **SemVer** in one
  place (`VERSION` / `__version__`).
- **`src/` layout** so tests import the installed package, not the working dir; `tests/` mirrors `src/`.
- **Explicit public API** via `__init__.py` and `__all__`; keep internals private (`_module`).
- **Full type hints**; ship `py.typed`. The package must import without optional/runtime-only deps.
- **Docstrings** on public functions/classes; usage examples in the README.
- **Lint / type / test** with the template's tooling (e.g. ruff, mypy, pytest); run them before publishing.
- **No side effects on import**; no secrets or environment assumptions baked into the library.

## Use with

Load alongside the `backend` (general Python) and `testing` skills.
