---
name: Init Python
description: Scaffold a Python project with best practices
tags: scaffolding, python, fastapi, flask
---

# Init Python

Scaffold a Python project with FastAPI, Flask, or custom setup, including testing and Docker.

## Detection

Auto-detect framework:

- **FastAPI**: If dependencies contain `fastapi`
- **Flask**: If dependencies contain `flask`
- **Django**: If dependencies contain `django`

Default to FastAPI if no framework detected.

## Scaffold Template

### For FastAPI

```
project/
├── app/
│   ├── __init__.py
│   ├── main.py
│   ├── routers/
│   │   └── __init__.py
│   ├── models/
│   └── schemas/
├── tests/
│   ├── __init__.py
│   └── test_main.py
├── pyproject.toml
├── requirements.txt
├── requirements-dev.txt
├── Dockerfile
├── docker-compose.yml
├── .env.example
├── .gitignore
└── pytest.ini
```

### For Flask

```
project/
├── app/
│   ├── __init__.py
│   ├── routes/
│   └── models/
├── tests/
├── pyproject.toml
├── requirements.txt
├── Dockerfile
├── docker-compose.yml
└── config.py
```

## Validation Steps

After scaffolding:

1. Install dependencies: `pip install -r requirements.txt`
2. Run linter: `ruff check .`
3. Run type check: `mypy .`
4. Run tests: `pytest`
5. Verify syntax: `python -m py_compile .`

## Options

- `--framework fastapi|flask|django`
- `--package-manager pip|poetry|uv`

## Best Practices

- Use pyproject.toml
- Include ruff for linting
- Add mypy for type checking
- Use Poetry or UV for dependency management
- Include Docker configuration

## Usage

```
/init-python
```

or:

```
/init-python --framework fastapi
```

## With PRD Flag

Use `--prd` to create PRD and plan before scaffolding:

```
/init-python --prd
```

## Aliases

- `/init-py`
- `/init-flask`
- `/init-fastapi`