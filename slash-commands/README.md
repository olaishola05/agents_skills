# Slash Commands

Reusable commands for common development tasks.

## All Commands

### Init Commands

| Command | Description |
|---------|-------------|
| `/init-api` | Scaffold backend API with repository pattern |
| `/init-frontend` | Scaffold frontend app |
| `/init-python` | Scaffold Python API (FastAPI, Flask, Django) |
| `/init-rails` | Scaffold Ruby on Rails app |

**All support `--prd` flag** to create PRD first:
```bash
/init-api --prd         # PRD → Plan → Scaffold
/init-frontend --prd
/init-python --prd
/init-rails --prd
```

### Development Commands

| Command | Description |
|---------|-------------|
| `/fix` | Analyze errors, suggest fixes, auto-apply with test verification |
| `/clean` | Remove console.log, print statements, unnecessary comments |
| `/load-context` | Load PRD/docs into AI context |
| `/optimize` | Performance optimization suggestions |

### Git Commands

| Command | Description |
|---------|-------------|
| `/commit` | Conventional commit with validation |
| `/push` | Pre-push validation (security first) |
| `/pr-summary` | Generate PR description from git diff |

### DevOps Commands

| Command | Description |
|---------|-------------|
| `/docker` | Docker setup and configuration |
| `/ci` | CI/CD pipeline configuration |
| `/deploy` | Deployment scripts |

---

## Usage

```bash
/command-name

# Examples
/init-api --framework nestjs --name my-api
/fix
/clean --dry-run
/pr-summary --format conventional
```

---

## Command Details

### /fix

Analyzes stack traces or runtime errors:
1. Get last command from shell history
2. Re-execute (30s timeout)
3. Parse error, explain to user
4. Suggest fix, wait for confirmation
5. Apply fix, run tests
6. If tests fail, rollback and suggest new fix
7. Repeat until tests pass

```
/fix
/fix --explain-only    # Just explain, no fix
/fix --dry-run        # Show fix without applying
```

### /clean

Removes debug statements and comments:
1. Scan for logs/comments
2. Explain what will be removed
3. Wait for confirmation
4. Apply removals
5. Report success

```
/clean
/clean --logs         # Only remove logs
/clean --comments   # Only remove comments
/clean --dry-run    # Preview without applying
```

### /load-context

Loads project context (PRD, specs) into AI:
1. Search for context files (PRD.md, SPEC.md, .context/)
2. Load into context
3. If no PRD found, offer to create one

```
/load-context prd
/load-context docs/architecture.md
/load-context all
```

### /commit

Creates conventional commit:
1. Analyze staged changes
2. Check commit history
3. Generate commit message
4. Validate with pre-commit hook
5. Commit

```
/commit
/commit -- Conventional
```

### /push

Pre-push validation:
1. Run security hook (secrets detection)
2. Run pre-commit hook (lint → test → build)
3. Push

```
/push
/push --force
```

### /pr-summary

Generates PR description:
1. Analyze git diff
2. Categorize changes
3. Generate description
4. Include implementation plan if `./plans/` exists

```
/pr-summary
/pr-summary --format conventional
/pr-summary --include-changelog
```

---

## Integration

Commands work together:

- `/create-prd` → `/prd-to-plan` → `/init-api --prd`
- `/load-context` can load PRD before using `/init-api`
- `/fix` and `/clean` run validation via hooks