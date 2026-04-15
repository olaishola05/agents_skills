# Agents

AI agents for code generation, testing, and review.

## Available Agents

| Agent | Description |
|-------|-------------|
| `agent-code` | Generate code with automatic TDD |
| `agent-tdd` | Test-driven development |
| `agent-review` | Code review with checklist |

---

## Usage

```bash
/agent-code add login page
/agent-tdd create authentication tests
/agent-review
```

---

## Agent Details

### agent-code

Generates code with automatic TDD integration.

**Workflow:**
1. Notify user: "First calling agent-tdd..."
2. Call agent-tdd to write tests
3. Implement feature based on tests
4. Validate with pre-commit hook
5. Optionally call agent-review

```
/agent-code add user authentication
/agent-code add api endpoint --no-commit
/agent-code add feature --skip-tdd   # Skip TDD
```

**Auto-calls agent-tdd**: Always writes tests first (notify user first).

### agent-tdd

Test-driven development agent.

**Workflow:**
1. Analyze feature requirements
2. Write failing tests first
3. Implement code to pass tests
4. Refactor while keeping tests passing
5. Validate with pre-commit hook

```
/agent-tdd add login tests
/agent-tdd create user model tests
```

### agent-review

Code review with quality checklist.

**Checks:**
- Code quality (conventions, functions, error handling)
- Security (secrets, input validation, SQL injection)
- Testing (unit tests, edge cases)
- Performance (N+1 queries, indexing)
- Documentation (APIs, complex logic)

```
/agent-review
/agent-review --files src/auth.ts
/agent-review --security-only
```

---

## Workflow Integration

```
User asks to build feature
        ↓
   agent-code
        ↓
 [agent-tdd writes tests]
        ↓
 [implements feature]
        ↓
 [validates with hooks]
        ↓
 [agent-review - optional]
```

---

## Options

### agent-code Options
- `--no-commit`: Don't commit after implementing
- `--skip-tdd`: Skip TDD, just write code
- `--watch`: Run tests in watch mode

### agent-review Options
- `--files`: Specific files to review
- `--strict`: Enforce all checks
- `--security-only`: Focus on security

---

## Hooks Reference

Agents use hooks for validation:

| Hook | Runs | Purpose |
|------|------|---------|
| `pre-commit` | On commit | lint → typecheck → test → build |
| `pre-push` | On push | security → pre-commit |
| `security` | Always | Secrets detection |