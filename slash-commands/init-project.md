---
name: Init Project
description: Wire a new or existing project into the global agents_skills workflow
tags: scaffolding, setup, workflow, init, hooks
---

# Init Project

Wire any project into your global AI development workflow — symlinks, AGENTS.md,
CONTEXT.md, WORKFLOW.md, and git hooks — in one command.

## Usage

```
/init-project
```

Run from the **root directory** of your project (after `git init` or after cloning).

## What It Does

Runs `~/.config/agents_skills/scripts/init-project.sh`, which:

| Step | What happens |
|------|-------------|
| **1. Symlinks** | Creates `agents → ~/.config/agents_skills/agents`<br>`hooks → ~/.config/agents_skills/hooks`<br>`skills → ~/.config/agents_skills/skills`<br>`slash-commands → ~/.config/agents_skills/slash-commands` |
| **2. AGENTS.md** | Drops the standard token-optimised workflow rules |
| **3. CONTEXT.md** | Drops the project context template for you to fill in |
| **4. WORKFLOW.md** | Copies the global workflow cheat sheet |
| **5. Git hooks** | Verifies `git config --global core.hooksPath` is set |
| **6. .gitignore** | Adds symlink entries so they are not accidentally committed |

## After Running

1. **Edit `CONTEXT.md`** — fill in your stack, conventions, and architecture
2. **Edit `AGENTS.md`** — add any project-specific agent rules
3. **Start planning**: `/agent-plan <phase-name>`

## Process (AI Steps)

When `/init-project` is called by an AI agent:

### Step 1: Run the scaffold script

```bash
~/.config/agents_skills/scripts/init-project.sh
```

### Step 2: Confirm output

Verify the script succeeded (symlinks created, no errors).

### Step 3: Prompt for CONTEXT.md values

Ask the user:
- What is the tech stack? (e.g. Next.js 15, Prisma, PostgreSQL)
- What is the package manager? (npm / pnpm / yarn / bun)
- What test framework? (Vitest / Jest / pytest)
- What style guide? (ESLint + Prettier / Biome)

Then fill in `CONTEXT.md` with the answers.

### Step 4: Confirm

Report back:
```
✅ Project wired into agents_skills workflow.
   - agents, hooks, skills, slash-commands → symlinked
   - AGENTS.md, CONTEXT.md, WORKFLOW.md → created
   - git pre-commit + pre-push hooks → active globally

Next: run /agent-plan to start your first phase.
```

## Requirements

- `~/.config/agents_skills/` must exist (clone the repo if not)
- Must be run from inside a git repository (`git init` first)

## Aliases

- `/setup-project`
- `/wire-project`
