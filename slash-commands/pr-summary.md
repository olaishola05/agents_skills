---
name: PR Summary
description: Generate PR description from git diff
tags: pr, git, changelog, conventional commits
---

# PR Summary

Generate PR description from git diff.

Analyze the current changes and generate a well-structured PR description.

## Usage

```
/pr-summary
```

or with options:

```
/pr-summary --format conventional
/pr-summary --include-changelog
```

## Process

### Step 1: Analyze Changes

- Get git diff of staged/uncommitted changes
- Identify modified files
- Analyze commit messages
- Check for related issues/tickets

### Step 2: Categorize Changes

Group changes by type:

- **Features**: New functionality
- **Fixes**: Bug fixes
- **Refactoring**: Code improvements
- **Tests**: Test additions/changes
- **Docs**: Documentation updates
- **Chore**: Maintenance tasks

### Step 3: Generate Description

Output format:

```
## Summary
[Brief description of changes]

## Changes Made
- [Change 1]
- [Change 2]

## Type
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Refactoring

## Testing
- [ ] Tests added/updated
- [ ] Manual testing done

## Checklist
- [ ] No hardcoded secrets
- [ ] Documentation updated
- [ ] Related issues linked
```

## Conventional Commit Format

For conventional commits:

```
<type>(<scope>): <description>

[body]

[footer]
```

Types: feat, fix, docs, style, refactor, test, chore

## Options

- `--format conventional|markdown`
- `--include-changelog`: Generate changelog entry
- `--scope`: Set commit scope

## Include Implementation Plan

If `./plans/` directory exists, check for related plan files and include in PR:

```
## Implementation Plan

### Phase 1: <Title>
- [ ] Criterion 1
- [ ] Criterion 2

### Phase 2: <Title>
...
```

This links the PR to the planned phases from `prd-to-plan` skill.

## Aliases

- `/pr`
- `/changelog`