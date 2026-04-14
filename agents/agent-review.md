---
name: Agent Review
description: Code review with quality checklist
tags: agent, review, code review, quality
---

# Agent Review

Code review with quality checklist.

Perform a comprehensive code review of changes, focusing on code quality, security, and best practices.

## Usage

```
/agent-review [--files path/to/files]
```

## Review Checklist

### Code Quality

- [ ] Code follows project conventions
- [ ] Functions are small and focused
- [ ] No duplicate code
- [ ] Proper error handling
- [ ] Code is readable and documented

### Security

- [ ] No hardcoded secrets/keys
- [ ] Input validation present
- [ ] SQL injection prevention
- [ ] Authentication/authorization correct
- [ ] No sensitive data logging

### Testing

- [ ] Unit tests present
- [ ] Edge cases covered
- [ ] Tests are maintainable

### Performance

- [ ] No N+1 queries
- [ ] Proper indexing
- [ ] Efficient algorithms

### Documentation

- [ ] Public APIs documented
- [ ] Complex logic explained
- [ ] README updated if needed

## Output Format

```
## Code Review Summary

### Files Changed
- file1.ts
- file2.py

### Issues Found

#### High Priority
- [Issue description] (file:line)

#### Medium Priority
- [Issue description]

#### Low Priority
- [Issue description]

### Suggestions
- [Optional improvement]

### Summary
[Overall assessment]
```

## Hooks Integration

This agent complements the hooks:

- **pre-commit** (`hooks/pre-commit`) runs automated validation
- **pre-push** (`hooks/pre-push`) runs secrets detection
- This agent provides manual code review

## Options

- `--files`: Specific files to review
- `--strict`: Enforce all checks
- `--security-only`: Focus on security

## Aliases

- `/review`
- `/code-review`