---
name: docs-mkdocs
description: HumbleBee documentation-site conventions — scaffold from the MkDocs template, then structure, nav, and the preview/build workflow.
---

## Start from the template

Build documentation sites from the company MkDocs template:

- https://github.com/humblebeeai/docs-mkdocs-template

Mirror its `mkdocs.yml`, `docs/` structure, and theme setup rather than starting from scratch.

## Conventions

- **MkDocs** with the template's theme (Material); all configuration lives in `mkdocs.yml`.
- **Explicit `nav:`** in `mkdocs.yml` — don't rely on implicit ordering; keep the tree shallow and logical.
- **Content under `docs/`**, assets under `docs/assets/`; one H1 per page.
- **Preview with `mkdocs serve`** while writing; **`mkdocs build --strict`** must pass (no broken links or refs) before merge.
- **Relative links** between pages so they work both on the built site and in the repo.
- **Diataxis structure** where it fits: tutorials / how-to / reference / explanation.

## Use with

Load alongside the `docs` agent for writing and structuring content.
