---
name: Changelog
description: Generate a CHANGELOG.md entry from recent git commits
tags: git, changelog, documentation, release
---

# Changelog

Generate a standard CHANGELOG.md entry from recent git commits.

## Workflow

1. Retrieve the git commit history since the last tag, or for the last N commits using `git log`.
2. Group commits by conventional commit types (feat, fix, docs, chore, etc.).
3. Format into a Markdown changelog entry following Keep a Changelog standards.
4. Present the draft to the user for review.
5. If approved, output the entry or prepend it to `CHANGELOG.md`.

## Usage

```
/changelog
/changelog --since HEAD~5
/changelog --write
```
