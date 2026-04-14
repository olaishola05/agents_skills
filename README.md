# Agent Skills

Personal development system with reusable slash commands, agents, and automated hooks for quality gates.

## Overview

This is a comprehensive system for AI-assisted development with:
- **Slash commands** - Reusable commands for common tasks
- **Skills** - Specialized workflows for specific tasks
- **Agents** - AI agents for code generation, review, and TDD
- **Hooks** - Automated quality gates (pre-commit, pre-push)

## Directory Structure

```
agents_skills/
├── slash-commands/     # Reusable slash commands (14 files)
├── skills/            # Specialized skills (5 files)
├── agents/            # AI agents (3 files)
├── hooks/            # Automated hooks (3 files)
└── README.md
```

---

## Slash Commands

### Init Commands

| Command | Description |
|---------|-------------|
| `/init-api` | Scaffold backend API with repository pattern |
| `/init-frontend` | Scaffold frontend app |
| `/init-python` | Scaffold Python API (FastAPI/Flask/Django) |
| `/init-rails` | Scaffold Ruby on Rails app |

**All support `--prd` flag:**
```
/init-api --prd    # Creates PRD → Plan → Then scaffolds
```

### Development Commands

| Command | Description |
|---------|-------------|
| `/fix` | Analyze errors, suggest fixes, auto-apply |
| `/clean` | Remove console.log, print statements, comments |
| `/load-context` | Load PRD/docs into AI context |
| `/optimize` | Performance optimization suggestions |

### Git Commands

| Command | Description |
|---------|-------------|
| `/commit` | Conventional commit with validation |
| `/push` | Pre-push validation (security first) |
| `/pr-summary` | Generate PR description |

### DevOps Commands

| Command | Description |
|---------|-------------|
| `/docker` | Docker setup |
| `/ci` | CI/CD configuration |
| `/deploy` | Deployment scripts |

---

## Skills

| Skill | Description |
|-------|-------------|
| `grill-me` | Interview user about features (stress-test plans) |
| `write-a-skill` | Create new skills with proper structure |
| `create-prd` | Create PRD through interview + exploration |
| `prd-to-plan` | Turn PRD into phased implementation plan |
| `frontend-design` | Build with company design systems |

### Frontend Design Skill

Uses 47 company design systems from [awesome-design-md](https://github.com/olaishola05/awesome-design-md):

```
User: Build a login page
Skill: Which design system? Apple, Stripe, Figma, Auto-detect?
User: Apple
Skill: *Fetches Apple DESIGN.md → Copies to ./resources/design/apple.md*
Building with Apple Human Interface Guidelines...
```

---

## Agents

| Agent | Description |
|-------|-------------|
| `agent-code` | Generate code with validation |
| `agent-tdd` | Test-driven development |
| `agent-review` | Code review with checklist |

---

## Hooks

### Pre-commit
```
lint → typecheck → test → build
```

### Pre-push
```
security → pre-commit
```

### Security Hook
- Secrets detection
- Large files check
- .env validation

---

## Usage

### With OpenCode/Claude Code

These slash commands and skills work with OpenCode, Claude Code, or Cursor.

### Triggering Skills

```
/grill-me              # Interview about features
/write-a-skill         # Create new skill
/create-prd            # Create product requirements
/prd-to-plan           # Plan from PRD
```

---

## Tech Stack

Supported frameworks:

| Category | Frameworks |
|----------|-----------|
| **Backend** | NestJS, Express, Fastify, Go, FastAPI, Django |
| **Frontend** | React, Vue, Svelte, Next.js |
| **ORM** | Prisma, SQLAlchemy, GORM, Drizzle |
| **Testing** | Vitest, Pytest, RSpec, Go test |

---

## License

MIT