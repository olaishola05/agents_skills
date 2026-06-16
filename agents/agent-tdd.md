---
name: Agent TDD
description: Test-Driven Development loop: write tests first, implement until pass
tags: agent, tdd, testing, test-driven
---

# Agent TDD

Test-Driven Development loop: write tests first, implement until pass.

Implement a feature using TDD methodology: write failing tests, implement until tests pass, then refactor.

## Usage

```
/agent-tdd [feature description]
```

Example:

```
/agent-tdd user login functionality
```

## TDD Process

### Step 1: Write Failing Test

- Create test file or add to existing tests
- Write test that describes expected behavior
- Run test → should FAIL (red)

### Step 2: Implement Minimum Code

- Write minimal code to make test pass
- Don't over-engineer
- Run test → should PASS (green)

### Step 3: Refactor

- Clean up code
- Ensure tests still pass
- Add edge case tests if needed

### Step 4: Validate (Targeted — AI Side Only)

> **⚠️ TOKEN RULE — NEVER run the global test suite inside the AI terminal.**
> Running `./hooks/pre-commit` or `pnpm run test` floods the conversation with all
> test output, exhausting tokens in minutes. Always use **targeted, file-isolated** commands.

Run **only the specific test file** you just wrote:

```bash
# Node.js (vitest)
npx vitest run path/to/my-feature.test.ts

# Python
pytest path/to/test_my_feature.py -v

# Go
go test ./path/to/package/...
```

Once the targeted test is GREEN, **stop**. Tell the user:

```
✅ Test passed. Please run locally to validate the full suite:
   ./hooks/pre-commit
```

The full `./hooks/pre-commit` sweep (lint → typecheck → all tests → build) runs on the
**user's local machine only** — never inside the AI conversation loop.

## Validation Gates

### AI-Side Gates (run inside the conversation)

1. **Targeted test**: Run only `npx vitest run path/to/file.test.ts` (or equivalent). GREEN = done.
2. **Integration Coverage**: If the feature touches routing, session gating, or page-level navigation:
   - Write integration tests that assert redirect flow.
   - Verify entry pages (e.g. `/dashboard`) invoke and respond to gating logic correctly.

### User-Side Gates (run locally, NEVER inside AI context)

3. **Linting**: `pnpm run lint`
4. **Type check**: `pnpm run typecheck`
5. **Full test suite**: `pnpm run test` (all tests pass)
6. **Build**: `pnpm run build` (optional, on pre-push)

All user-side gates are enforced automatically by `./hooks/pre-commit` on the local machine.

## Hooks Reference

| Hook | Runs Where | What it does |
|------|------------|------|
| `npx vitest run path/to/file.test.ts` | **AI terminal** ✅ | Targeted — one test file only |
| `./hooks/pre-commit` | **User's machine** 🖥 | Full sweep: lint → type → all tests |
| `./hooks/pre-push` | **User's machine** 🖥 | Secrets scan + pre-commit |

## Options

- `--test-framework vitest|jest|pytest|rspec`
- `--coverage` (require minimum coverage)

## Best Practices

- Write one test at a time
- Keep tests small and focused
- Use descriptive test names
- Test edge cases and error states

## Aliases

- `/tdd`
- `/test-first`