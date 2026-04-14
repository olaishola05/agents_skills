---
name: Agent Code
description: Spawn a sub-agent to implement a feature with validation loop
tags: agent, implementation, feature, validation
---

# Agent Code

Spawn a sub-agent to implement a feature with validation loop.

Launch a sub-agent to implement a specific feature or fix, with validation to ensure quality.

## Usage

```
/agent-code [feature description]
```

Example:

```
/agent-code add user authentication endpoint
```

## Process

### Step 1: Understand

- Read existing codebase structure
- Identify relevant files
- Check for existing patterns/conventions
- Ask clarifying questions if needed

### Step 2: Plan

- Create a simple implementation plan
- Identify files to modify/create
- List dependencies and interfaces
- Get user approval before proceeding

### Step 3: Implement

- Write the code
- Follow existing conventions
- Add comments for complex logic
- Include proper error handling

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

If validation fails → fix → re-run hook → repeat

### Step 5: Commit

Using /commit or directly:

```bash
git add .
git commit -m "[message]"
```

## Validation Gates

Before completing, all must pass:

1. **Linting**: Code follows style guidelines
2. **Type check**: No type errors
3. **Tests**: All tests pass
4. **Build**: Project builds successfully

## Hooks Reference

| Hook | File | Runs |
|------|------|------|
| pre-commit | `hooks/pre-commit` | Validation before commit |
| pre-push | `hooks/pre-push` | Secrets check + validation |

To run hooks:

```bash
./hooks/pre-commit    # Run before commit
./hooks/pre-push     # Run before push
```

## Options

- `--no-commit`: Don't create commit
- `--test-first`: Write tests before implementation (TDD mode)
- `--watch`: Run tests in watch mode during implementation

## Best Practices

- Start simple, iterate
- Validate frequently
- Ask for feedback early
- Don't over-engineer

## Aliases

- `/code`
- `/implement`
- `/feature`