# Hooks

Automated quality gates for pre-commit and pre-push validation.

## Available Hooks

| Hook | Runs | Description |
|------|------|-------------|
| `pre-commit` | On `git commit` | lint → typecheck → test → build |
| `pre-push` | On `git push` | security → pre-commit |
| `security` | On push + manual | Secrets detection |

---

## Usage

### Pre-commit Hook

Runs automatically on `git commit`:

```bash
git commit -m "feat: add login"
# Automatically runs: lint → typecheck → test → build
```

### Pre-push Hook

Runs automatically on `git push`:

```bash
git push
# Automatically runs: security → pre-commit
```

### Run Hooks Manually

```bash
./hooks/pre-commit    # Run validation
./hooks/pre-push     # Run push validation
./hooks/security    # Run security check only
```

---

## Hook Details

### pre-commit

**Runs:** lint → typecheck → test → build

**Stack-specific:**

| Stack | Lint | Typecheck | Test | Build |
|-------|------|----------|------|-------|
| Node.js | ESLint | tsc | vitest/npm test | npm run build |
| Python | ruff | mypy | pytest | py_compile |
| Ruby | rubocop | (none) | rspec | (none) |
| Go | golangci-lint | go vet | go test | go build |

**Fails if any step fails.**

### pre-push

**Runs:** security → pre-commit

**Flow:**
1. Security hook (secrets detection)
2. Pre-commit hook (validation)
3. If both pass, push proceeds

**Security hook runs first** to fail fast on secrets.

### security

**Checks:**
- Hardcoded secrets (API keys, tokens, passwords)
- Large files (>5MB)
- .env files in staged changes
- Known secret patterns

**Fails if secrets detected.**

---

## Configuration

### Skip Hooks

```bash
git commit --no-verify    # Skip pre-commit
git push --no-verify     # Skip pre-push
```

### Hook Skipping

Not recommended - validation exists for quality.

---

## Security Hook Details

The security hook checks for:

### Secrets Detection
- AWS keys: `AKIA...`
- GitHub tokens: `ghp_...`
- Private keys: `-----BEGIN`
- Generic patterns: `api_key`, `password`, `secret`

### File Checks
- No `.env` files staged
- No `.pem` files
- No large binary files

---

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | Validation failed |

---

## Best Practices

- Always let hooks run (don't skip with `--no-verify`)
- Fix issues, don't skip hooks
- Run hooks manually before pushing if unsure

---

## Integration with Agents

Agents run hooks automatically:

```
agent-code: implementing feature...
→ runs pre-commit validation
→ if fail: fix and retry
→ if pass: continue
```