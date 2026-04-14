---
name: Deploy
description: Generate deployment configuration
tags: deploy, vercel, railway, render, deployment
---

# Deploy

Generate deployment configuration.

Create deployment configs for common platforms like Vercel, Railway, Render, or custom deployment.

## Detection

Auto-detect deployment target:

- **Next.js**: Often Vercel
- **Node.js**: Often Railway/Render
- **Python**: Often Railway/Render/Fly.io
- **Any**: Check for existing configs

## Platforms

### Vercel (Next.js)

- Auto-detected if Next.js project
- `vercel.json` or `vercel.config.js`

### Railway

- `railway.json`

### Render

- `render.yaml`

### Fly.io

- `Dockerfile` + `fly.toml`

## Options

- `--platform vercel|railway|render|fly`
- `--auto`: Auto-detect best platform
- `--env`: Include environment setup

## Usage

```
/deploy
```

or:

```
/deploy --platform vercel
/deploy --platform railway
```

## Aliases

- `/deploy-vercel`
- `/deploy-railway`