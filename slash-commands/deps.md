---
name: Deps
description: Audit project dependencies for outdated versions or vulnerabilities.
tags: dependencies, audit, security, outdated, npm, pip, go
---

# Deps

Audit dependencies for vulnerabilities and outdated versions.

## Workflow

1. Detect the package manager (npm, yarn, pnpm, pip, go mod, cargo, etc.).
2. Run the respective audit/outdated command (e.g., `npm audit`, `npm outdated`).
3. Summarize the findings, grouping by severity (Critical, High, Medium, Low).
4. Suggest commands to update or fix specific dependencies.

## Usage

```
/deps
```
