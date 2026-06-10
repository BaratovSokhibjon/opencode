---
name: testing
description: Checklist for focused tests, failure analysis, regression coverage, and verification reporting.
---

## Test Design

- [ ] Each test has one clear purpose and a behavior-focused name.
- [ ] Tests are independent and do not rely on order or shared mutable state.
- [ ] Setup/teardown is explicit and predictable.
- [ ] Mocks sit at module boundaries and reset between tests.
- [ ] Test the behavior, not the implementation internals.

## Coverage

- [ ] New feature code covers the happy path and important error paths.
- [ ] Bug fixes include a regression test that would have caught the original bug.
- [ ] Critical auth/data/deploy paths have integration or E2E coverage.
- [ ] Edge cases cover empty input, null/undefined, boundary values, and permission checks.
- [ ] Run tests via `scripts/test.sh` or the project-standard test command.

## Test Types

| Type        | When Required             | Example                              |
| ----------- | ------------------------- | ------------------------------------ |
| Unit        | All service/domain logic  | Function returns correct output      |
| Integration | API endpoints, DB ops     | POST /users creates a user in DB     |
| E2E         | Critical user flows       | Login → dashboard → logout           |
| Security    | Auth/authz paths          | Unauthorized request returns 401     |
| Regression  | Every bug fix             | Reproduces the bug, confirms fix     |

## Failure Analysis

1. Read the full failure output before acting — do not guess.
2. Check whether the test setup or assertion is wrong.
3. Check whether the implementation violates expected behavior.
4. Check for missing dependencies, env vars, or fixtures.
5. Check flake/timing/shared-state causes only after reading the full output.
6. Fix the implementation, not the test — unless the test is demonstrably wrong.

## Verification Reporting

- [ ] Run the smallest proving command first.
- [ ] Report exact command, exit code, and failure snippet.
- [ ] Never claim pass without fresh output from the current code state.
- [ ] Use `scripts/test.sh` or project-standard commands for consistency across the team.
