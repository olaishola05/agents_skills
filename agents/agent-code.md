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

### Step 1: Notify User

When called to build a feature:

```
First calling agent-tdd to write tests for [feature]...
```

This notifies user that TDD approach is being used.

### Step 2: Call agent-tdd

Automatically call agent-tdd to write tests first:

```
agent-tdd: Write tests for [feature description]
```

This creates the test file(s) based on the feature requirements.

### Step 3: Understand

After tests are ready, read existing codebase:
- Read existing codebase structure
- Identify relevant files
- Check for existing patterns/conventions

### Step 4: Plan

- Create a simple implementation plan
- Identify files to modify/create
- List dependencies and interfaces
- Get user approval before proceeding

### Step 5: Implement

Write the code that passes the tests:
- Follow test-driven development: write code to make tests pass
- Follow existing conventions
- Add comments for complex logic
- Include proper error handling

### Step 6: Validate

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

### Step 7: Commit

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

## TDD is Automatic

When agent-code is called, it automatically:
1. Notifies user: "First calling agent-tdd to write tests..."
2. Calls agent-tdd to write tests first
3. Implements the feature based on tests
4. Validates with pre-commit hook

This ensures all features are built test-first.

## Options

- `--no-commit`: Don't create commit
- `--skip-tdd`: Skip TDD and just write code
- `--watch`: Run tests in watch mode during implementation

## Integration with agent-tdd

This agent automatically integrates with agent-tdd:

```
User: /agent-code add login page
→ agent-code: First calling agent-tdd to write tests for login page...
→ agent-tdd: [Writes tests...]
→ agent-code: Tests ready. Implementing login page...
→ agent-code: [Implements feature...]
→ agent-code: Running pre-commit validation...
→ agent-code: Complete.
```

This ensures TDD is always followed.

## Best Practices

- Start simple, iterate
- Validate frequently
- Ask for feedback early
- Don't over-engineer
- Always write tests first (automatic)

## Aliases

- `/code`
- `/implement`
- `/feature`