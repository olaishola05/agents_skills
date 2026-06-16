---
name: Init Frontend
description: Scaffold a frontend application with best practices
tags: scaffolding, frontend, react, nextjs, vue
---

# Init Frontend

Scaffold a frontend application with React, Vue, or other frameworks, including proper tooling and structure.

## Detection

Auto-detect framework from dependencies:

- **Next.js**: If `package.json` contains `next`
- **React**: If `package.json` contains `react`
- **Vue**: If `package.json` contains `vue`
- **Svelte**: If `package.json` contains `svelte`

If no dependencies detected, prompt user to choose.

## Scaffold Template

### For Next.js

```
project/
├── app/
│   ├── layout.tsx
│   ├── page.tsx
│   └── globals.css
├── src/
│   ├── components/
│   ├── hooks/
│   ├── lib/
│   └── types/
├── public/
├── package.json
├── tsconfig.json
├── tailwind.config.ts (if using Tailwind)
├── vitest.config.ts
├── next.config.js
└── .eslintrc.json
```

### For React (Vite)

```
project/
├── src/
│   ├── components/
│   ├── hooks/
│   ├── lib/
│   ├── types/
│   ├── App.tsx
│   └── main.tsx
├── public/
├── index.html
├── package.json
├── tsconfig.json
├── vite.config.ts
├── vitest.config.ts
└── .eslintrc.json
```

### For Vue

```
project/
├── src/
│   ├── components/
│   ├── composables/
│   ├── router/
│   ├── stores/
│   ├── App.vue
│   └── main.ts
├── public/
├── index.html
├── package.json
├── vite.config.ts
├── vitest.config.ts
└── .eslintrc.json
```

## Validation Steps

After scaffolding:

1. Install dependencies: `npm install`
2. Run lint: `npm run lint`
3. Run typecheck: `npm run typecheck`
4. Run tests: `npm run test`
5. Verify dev server starts: `npm run dev`
6. **Wire AI workflow**: `~/.config/agents_skills/scripts/init-project.sh`
   (Creates symlinks, AGENTS.md, CONTEXT.md, WORKFLOW.md, and activates git hooks)

## Options

- `--framework nextjs|react|vue|svelte`
- `--css tailwind|scss|css`
- `--ts` or `--js` (default: ts)
- `--test vitest|jest`

## Best Practices

- Use TypeScript
- Set up Vitest for testing
- Include Tailwind CSS (optional)
- Add proper directory structure
- Include basic component tests

## Usage

```
/init-frontend
```

or with options:

```
/init-frontend --framework react --css tailwind
```

## With PRD Flag

Use `--prd` to create PRD and plan before scaffolding:

```
/init-frontend --prd
```

## Aliases

- `/init-front`
- `/init-client`
- `/init-ui`