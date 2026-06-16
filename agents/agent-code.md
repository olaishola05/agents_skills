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

### Step 6: Validate (Targeted — AI Side Only)

> **⚠️ TOKEN RULE — NEVER run `./hooks/pre-commit` or `pnpm run test` inside the AI terminal.**
> Running the full test suite dumps every test log into your conversation, exhausting
> tokens in minutes. Always use **targeted, file-isolated** test commands.

Run **only the specific test file** you just created:

```bash
# Node.js (vitest)
npx vitest run path/to/my-feature.test.ts

# Python
pytest path/to/test_my_feature.py -v

# Go
go test ./path/to/package/...
```

Once the targeted test is GREEN, **stop and tell the user**:

```
✅ Tests passed: path/to/my-feature.test.ts
Please run locally to validate the full suite before committing:
   ./hooks/pre-commit
```

If the targeted test fails → fix the implementation → re-run the same targeted command → repeat.

### Step 7: Commit

Using /commit or directly:

```bash
git add .
git commit -m "[message]"
```

## Validation Gates

### AI-Side Gates (inside the conversation)

1. **Targeted test** — `npx vitest run path/to/file.test.ts`. Must be GREEN before stopping.
2. **Type narrows** — only run `pnpm exec tsc --noEmit` if you are debugging a type error.
   Never run it speculatively; the output is large.

### User-Side Gates (on the local machine, enforced by hooks)

3. **Linting** — `pnpm run lint`
4. **Type check** — `pnpm run typecheck`
5. **Full test suite** — `pnpm run test`
6. **Build** — `pnpm run build` (triggered automatically on `git push` via `pre-push`)

## Hooks Reference

| Hook | Runs Where | What it does |
|------|------------|------|
| `npx vitest run path/to/file.test.ts` | **AI terminal** ✅ | Targeted — one file only, minimal output |
| `./hooks/pre-commit` | **User's machine** 🖥 | Full sweep: lint → type → all tests |
| `./hooks/pre-push` | **User's machine** 🖥 | Secrets scan + pre-commit |

## TDD is Automatic

When agent-code is called, it automatically:
1. Notifies user: "First calling agent-tdd to write tests..."
2. Calls agent-tdd to write tests first
3. Implements the feature based on tests
4. Validates with a **targeted** test command (not the full suite)
5. Tells user to run `./hooks/pre-commit` locally

This ensures all features are built test-first **without exhausting conversation tokens**.

**Correct flow:**
```
User: /agent-code add login page
→ agent-code: First calling agent-tdd to write tests for login page...
→ agent-tdd: [Writes tests...]
→ agent-code: Tests ready. Implementing login page...
→ agent-code: [Implements feature...]
→ agent-code: Running targeted test: npx vitest run src/app/login/__tests__/page.test.ts
→ agent-code: ✅ Tests passed.
→ agent-code: Please run `./hooks/pre-commit` locally before committing.
```

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