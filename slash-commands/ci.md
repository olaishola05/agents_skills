---
name: CI
description: Generate GitHub Actions CI workflow
tags: ci, github actions, testing, automation
---

# CI

Generate GitHub Actions CI workflow.

Create a CI workflow file for automated testing and validation on pull requests.

## Detection

Auto-detect stack and appropriate CI steps:

- **Node.js**: npm test, lint, typecheck
- **Python**: pytest, ruff, mypy
- **Ruby**: rspec, rubocop
- **Go**: go test, golangci-lint

## Template (Node.js)

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
          
      - name: Install dependencies
        run: npm ci
        
      - name: Lint
        run: npm run lint
        
      - name: Typecheck
        run: npm run typecheck
        
      - name: Test
        run: npm run test -- --coverage
        
      - name: Build
        run: npm run build
```

## Template (Python)

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'
          
      - name: Install dependencies
        run: pip install -r requirements-dev.txt
        
      - name: Lint
        run: ruff check .
        
      - name: Typecheck
        run: mypy .
        
      - name: Test
        run: pytest --cov
```

## Validation Steps

1. Create workflow file: `.github/workflows/ci.yml`
2. Run workflow locally if possible
3. Verify all jobs pass

## Options

- `--node-version 18|20`
- `--python-version 3.11|3.12`
- `--coverage`: Include coverage reporting
- `--deploy`: Include deploy job

## Best Practices

- Use `npm ci` for consistent installs
- Cache dependencies
- Run lint before tests
- Fail fast on lint errors

## Usage

```
/ci
```

or:

```
/ci --coverage --node-version 20
```

## Aliases

- `/github-actions`
- `/workflow`