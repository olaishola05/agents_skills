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

### Step 4: Validate

Run validation using pre-commit hook:

```bash
./hooks/pre-commit
```

This runs stack-appropriate validation:
- **Node.js**: lint → typecheck → test → build
- **Python**: ruff → mypy → pytest
- **Ruby**: rubocop → rspec
- **Go**: golangci-lint → vet → test

## Validation Gates

All must pass before completing:

1. **Test coverage**: New code has tests
2. **Linting**: Code follows style
3. **Types**: No type errors
4. **All tests**: Full test suite passes

## Hooks Reference

| Hook | File | Runs |
|------|------|------|
| pre-commit | `hooks/pre-commit` | Validation before commit |

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