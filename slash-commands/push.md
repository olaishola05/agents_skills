---
name: Push
description: Commit and push to remote with hooks
tags: git, push, commit, remote, pull request, hook
---

# Push

Commit and push to remote. Hooks run automatically.

## Workflow

### 1. Analyze Changes

Run:

- `git status` - Show modified/added/deleted/untracked files
- `git diff --stat` - Show change statistics

### 2. Request Confirmation

Present summary:

```
📊 Changes Summary:
- X files modified, Y added, Z deleted
- Total: +AAA insertions, -BBB deletions

🌿 Branch: [name] → origin/[name]

I will: /commit → git push
(hooks will run automatically)

Type 'yes' to proceed or 'no' to cancel.
```

**WAIT for explicit "yes" before proceeding.**

### 3. Create Commit

Using /commit:

```
/commit [optional message]
```

Or with issue reference:

```
/commit fix issue #123
/commit "Closes #123"
```

### 4. Push

```bash
git push
```

**Note:** Run hooks manually if not automatic:

```bash
./hooks/pre-commit    # Before commit
./hooks/pre-push     # Before push
```

## Hooks Reference

| Hook | File | Runs |
|------|------|------|
| pre-commit | `hooks/pre-commit` | lint → typecheck → test → build |
| pre-push | `hooks/pre-push` | secrets check → validation |

## If Hook Fails

1. **pre-commit fails**: Fix issues → retry commit
2. **pre-push fails**: Fix secrets/validation → retry push

## Error Handling

- **git push fails**:
  - Non-fast-forward: `git pull --rebase && git push`
  - No remote branch: `git push -u origin [branch]`
  - Protected branch: Use PR workflow instead

## Usage

```
/push
/push fix issue #123
/push "Closes #456"
```

## Aliases

- `/git-push`
- `/gp`