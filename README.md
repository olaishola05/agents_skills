# Agent Skills

Personal development system with reusable slash commands, agents, and automated hooks for quality gates.

> ⚠️ **TOKEN SAFETY:** AI agents must **never** run `./hooks/pre-commit` or `pnpm run test` inside their terminal.
> Always run only the targeted test file: `npx vitest run path/to/file.test.ts`
> The full quality sweep runs on **your machine** automatically via the git hooks.

---

## Getting Started on a New Machine

```bash
# 1. Clone this repo
git clone https://github.com/olaishola05/agents_skills.git ~/.config/agents_skills

# 2. Add the init-project alias to your shell
echo "alias init-project='~/.config/agents_skills/scripts/init-project.sh'" >> ~/.zshrc
source ~/.zshrc

# 3. In any new project (after git init):
cd /path/to/my-new-project
init-project
```

That's it. All symlinks, workflow files, and global git hooks are set up automatically.

---

## Getting Started on a New Project

Inside any existing or new git repo:

```bash
init-project
```

This single command:
- Creates `agents`, `hooks`, `skills`, `slash-commands` symlinks → global repo
- Drops `AGENTS.md` (token-optimised TDD workflow rules)
- Drops `CONTEXT.md` (fill in your stack and conventions)
- Copies `WORKFLOW.md` (end-to-end phase cheat sheet)
- Sets `git config --global core.hooksPath` (active on every repo)
- Adds symlink entries to `.gitignore`

---

## Directory Structure

```
agents_skills/
├── scripts/            # Project scaffolding scripts
│   └── init-project.sh     ← Run in any new project
├── slash-commands/     # Reusable slash commands (21 files)
│   ├── init-project.md     ← Wire new project into workflow
│   ├── init-api.md
│   ├── init-frontend.md
│   ├── init-python.md
│   ├── init-rails.md
│   └── ...
├── skills/             # Specialized AI workflows (5 files)
├── agents/             # AI agents for TDD + code + review (6 files)
├── hooks/              # Local quality gates (run on your machine)
│   ├── pre-commit          ← lint → typecheck → all tests
│   ├── pre-push            ← security → pre-commit
│   └── security            ← secrets + large file detection
├── templates/
│   └── CONTEXT.md          ← Project context template
├── AGENTS.md               ← Global agent rules (token safety)
├── WORKFLOW.md             ← End-to-end workflow cheat sheet
└── README.md
```

---

## How Hooks Work

All hooks run **on your local machine** — never inside an AI conversation.

| Hook | Where | What it does |
|------|-------|-------------|
| `pre-commit` | Your machine 🖥 | lint → typecheck → all tests → (optional build) |
| `pre-push` | Your machine 🖥 | secrets scan → pre-commit |
| `security` | Your machine 🖥 | secrets + large file detection |

The global hook path is set once:
```bash
git config --global core.hooksPath ~/.config/agents_skills/hooks
# Applies to ALL your git repos automatically
```

---

## AI Workflow — How Tokens Are Preserved

```
AI writes test file  →  npx vitest run path/to/file.test.ts  (targeted, ~50 lines output)
                                    ↓
                         GREEN → tells user to run:
                         ./hooks/pre-commit   (on your machine, not in AI context)
                                    ↓
                         Full sweep: lint → typecheck → 225 tests → build
```

Running the full suite inside the AI terminal burns **millions of tokens** per task.
The targeted approach keeps each task under ~50 lines of output.

---

## Slash Commands

### Scaffold Commands

| Command | Description |
|---------|-------------|
| `/init-project` | **Wire any project into this workflow** (symlinks + workflow files + hooks) |
| `/init-api` | Scaffold backend API with repository pattern |
| `/init-frontend` | Scaffold frontend app (Next.js / React / Vue) |
| `/init-python` | Scaffold Python API (FastAPI / Flask / Django) |
| `/init-rails` | Scaffold Ruby on Rails app |

All init commands end with `~/.config/agents_skills/scripts/init-project.sh`
to wire the workflow automatically.

**All support `--prd` flag:**
```
/init-api --prd    # PRD → Plan → Scaffold
```

### Development Commands

| Command | Description |
|---------|-------------|
| `/fix` | Analyse error, explain, auto-apply fix, rollback on failure |
| `/clean` | Remove `console.log`, print statements, debug comments |
| `/optimize` | Memory leaks, O(n²) loops, caching opportunities |
| `/docs` | Generate JSDoc/docstrings for new functions |
| `/deps` | Audit outdated or vulnerable packages |
| `/load-context` | Load PRD/docs into AI context |

### Git Commands

| Command | Description |
|---------|-------------|
| `/commit` | Conventional commit message (feat/fix/docs/refactor…) |
| `/push` | Triggers `hooks/security` before pushing |
| `/pr-summary` | Write PR description from `./plans/` |
| `/changelog` | Generate `CHANGELOG.md` from recent commits |
| `/standup` | Daily standup from git log |

### DevOps Commands

| Command | Description |
|---------|-------------|
| `/docker` | Docker + docker-compose setup |
| `/ci` | CI/CD pipeline configuration |
| `/deploy` | Deployment scripts |

---

## Skills

| Skill | Description |
|-------|-------------|
| `grill-me` | Stress-test your idea with one Q at a time |
| `create-prd` | Full PRD via interview + exploration |
| `prd-to-plan` | Slice PRD into vertical phases → `./plans/` |
| `frontend-design` | Pick a design system (Apple, Stripe, Figma…) |
| `write-a-skill` | Create new skills with proper structure |

### Frontend Design Skill

Uses 47 company design systems from [awesome-design-md](https://github.com/olaishola05/awesome-design-md):

```
User: Build a login page
Skill: Which design system? Apple, Stripe, Figma, Auto-detect?
User: Stripe
Skill: *Fetches Stripe DESIGN.md → Copies to ./resources/design/stripe.md*
Building with Stripe design system...
```

---

## Agents

| Agent | Description |
|-------|-------------|
| `agent-plan` | Break a phase into atomic tasks before coding |
| `agent-code` | Implement with TDD → targeted test → tell user to run hook |
| `agent-tdd` | Write failing tests first (Red → Green) |
| `agent-review` | Senior engineer code review checklist |
| `agent-smell` | Clean Code + GoF pattern analysis |
| `agent-run` | Execute commands with validation |

---

## Supported Stacks

| Category | Frameworks |
|----------|-----------|
| **Backend** | NestJS, Express, Fastify, Go, FastAPI, Django, Flask |
| **Frontend** | Next.js, React, Vue, Svelte |
| **ORM** | Prisma, SQLAlchemy, GORM, Drizzle |
| **Testing** | Vitest, Jest, Pytest, RSpec, Go test |
| **Package manager** | pnpm, npm, yarn, bun, pip, poetry, uv |

---

## License

MIT