---
name: Commit
description: Create a git commit with context
tags: git, commit, version control
---

# Commit

Create a git commit with context.

## Context

The agent will automatically run:

- `git status` - Current git status
- `git diff HEAD` - Current git diff
- `git branch --show-current` - Current branch
- `git log --oneline -10` - Recent commits

## Your Task

Based on the changes, create a single git commit.

If a message was provided via arguments, use it: $ARGUMENTS

Otherwise, analyze the changes and create an appropriate commit message following conventional commits format:

- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation changes
- `refactor:` for code refactoring
- `test:` for adding tests
- `chore:` for maintenance tasks
- `perf:` for performance improvements
- `style:` for code style changes

## Commit Message Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Examples

```
feat(auth): add user login endpoint

fix(api): handle null response from database

docs(readme): update installation instructions

refactor(utils): simplify date formatting function

test(auth): add unit tests for login
```

## Steps

1. Run git status to see changed files
2. Run git diff to see the changes
3. Analyze the changes
4. Create an appropriate commit message
5. Create the commit

## Validation

- Commit message follows conventional commits
- Changes are appropriate for the commit
- No secrets or sensitive data in commit

## Usage

```
/commit
```

or with message:

```
/commit fix(auth): resolve login timeout issue
```

## Aliases

- `/git-commit`
- `/gc`