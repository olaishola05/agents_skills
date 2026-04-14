---
name: Docker
description: Generate Dockerfile and docker-compose.yml for the project
tags: docker, container, devops, deployment
---

# Docker

Generate Dockerfile and docker-compose.yml for the project.

Create Docker configuration tailored to the project's technology stack.

## Detection

Auto-detect from project files:

- **Node.js**: `package.json` exists
- **Python**: `pyproject.toml` or `requirements.txt` exists
- **Ruby**: `Gemfile` exists
- **Go**: `go.mod` exists

## Template Files

### Dockerfile (Node.js)

```dockerfile
FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY . .

EXPOSE 3000

CMD ["node", "dist/main.js"]
```

### Dockerfile (Python)

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0"]
```

### docker-compose.yml

```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    depends_on:
      - db

  db:
    image: postgres:15-alpine
    environment:
      - POSTGRES_DB=app
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
```

## Database Options

Add common databases:

- **PostgreSQL**: `postgres:15-alpine`
- **MySQL**: `mysql:8`
- **MongoDB**: `mongo:7`
- **Redis**: `redis:7-alpine`

## Validation Steps

1. Build image: `docker build -t app .`
2. Run container: `docker-compose up -d`
3. Verify: `docker-compose ps`
4. Check logs: `docker-compose logs`

## Options

- `--db postgres|mysql|mongo|none`
- `--node-version 18|20`
- `--python-version 3.11|3.12`
- `--multi-stage`: Optimize for production

## Best Practices

- Use specific version tags
- Use alpine images for smaller size
- Multi-stage builds for Node.js
- Health checks included

## Usage

```
/docker
```

or:

```
/docker --db postgres --node-version 20
```

## Aliases

- `/dockerfile`
- `/container`