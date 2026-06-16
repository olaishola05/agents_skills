# TEAM.md — Using This Workflow on a Team

> How to share this system with 2, 5, or 20 developers without losing consistency.

---

## The core challenge

This workflow is built around a single developer's machine. When you bring a team in,
two things break immediately:

1. **Hook enforcement** — Global git hooks only exist on the machine of the developer who set them up. Every new teammate starts with zero hooks.
2. **Agent context** — AGENTS.md and CONTEXT.md live in the repo, but each developer's AI tool is configured differently. One developer uses Claude Code, another uses Cursor. They will not behave identically.

This guide solves both.

---

## Setup for each new team member (5 minutes)

Every developer on the team runs this once on their machine:

```bash
# 1. Clone the shared agents_skills repo
git clone https://github.com/<your-org>/agents_skills.git ~/.config/agents_skills

# 2. Add the init-project alias
echo "alias init-project='~/.config/agents_skills/scripts/init-project.sh'" >> ~/.zshrc
source ~/.zshrc

# 3. That's it — hooks are now active globally on their machine
```

When they clone a project repo:
```bash
git clone https://github.com/<your-org>/<project>.git
cd <project>
init-project   # creates symlinks + confirms hooks are active
```

---

## Forking the workflow for your team

You should **fork** `agents_skills` into your organisation's GitHub, not use the personal repo directly. This lets you:
- Add team-specific commands without affecting personal repos
- Review changes via PR before they affect everyone
- Track who changed what in the workflow

```bash
# Fork on GitHub: olaishola05/agents_skills → your-org/agents_skills
# Each team member clones the org fork, not the personal one

git clone https://github.com/<your-org>/agents_skills.git ~/.config/agents_skills
```

---

## What goes in the shared agents_skills repo vs the project repo

| Item | Where it lives | Who owns it |
|------|---------------|-------------|
| Slash commands (fix, commit, push…) | `agents_skills` (org fork) | Team / DevOps |
| Agent definitions (agent-code, agent-tdd…) | `agents_skills` (org fork) | Team / DevOps |
| Global hooks (pre-commit, pre-push, security) | `agents_skills` (org fork) | Team / DevOps |
| Token safety rules (AGENTS.md in workflow repo) | `agents_skills` (org fork) | Team / DevOps |
| Project-specific rules (AGENTS.md in project) | Project repo | Project team |
| Project context (CONTEXT.md) | Project repo | Project team |
| Phase plans (`./plans/*.md`) | Project repo | Project team |
| Task tracker (`task.md`) | Project repo | Project team |

---

## Keeping hooks consistent across the team

The global hook path points at a cloned copy of `agents_skills`. When you update the hooks:

```bash
# Team lead makes a change to hooks/pre-commit
# Opens a PR on the org's agents_skills repo
# Team reviews and merges

# Each developer then pulls the update on their machine:
cd ~/.config/agents_skills && git pull origin main
```

The update is live immediately for all their repos — no reinstallation needed.

---

## The AGENTS.md hierarchy

Projects can override or extend the global agent rules. The AI reads both:

1. **Global rules** — from the `AGENTS.md` symlinked via `agents_skills` (your token safety and TDD rules)
2. **Project rules** — from the `AGENTS.md` in the project root (project-specific conventions)

Project rules take precedence. This means a project can tighten the rules
(e.g. "always use the Result pattern for error handling in this project")
without affecting other projects.

```
~/.config/agents_skills/AGENTS.md   ← global baseline (applies everywhere)
project-root/AGENTS.md              ← project-specific overrides (applies here only)
```

---

## Shared CONTEXT.md template

Create a standard `CONTEXT.md` template in your org fork's `templates/` directory
that pre-fills your org's conventions:

```markdown
# Project Context: {{Project Name}}

## 🚀 Tech Stack
- **Backend**: Next.js 15 (App Router)
- **Database**: PostgreSQL via Neon + Prisma ORM
- **Auth**: Better Auth
- **Package Manager**: pnpm

## 🛠 Org Conventions
- **Language**: TypeScript (strict mode)
- **Style Guide**: ESLint + Prettier (see .eslintrc)
- **Testing**: Vitest (targeted — see AGENTS.md)
- **Git**: Conventional Commits (feat/fix/docs/refactor/test/chore)
- **Error Handling**: Result<T, E> union type (never throw in actions)

## 🏛 Architecture
- **Pattern**: Feature-based (src/lib/actions/, src/components/, src/app/)
- **API**: Next.js Route Handlers + Server Actions
- **State**: React Server Components + URL state (no client state management)

## 📝 Key Decisions
- [Date]: [Decision] — [Rationale]
```

Update `scripts/init-project.sh` to use the org template:
```bash
cp "$AGENTS_SKILLS_DIR/templates/CONTEXT.md" "$CONTEXT_MD"
```

---

## Team workflow — who does what

```
┌─────────────────────────────────────────────────────────────┐
│  Developer A (feature branch)                               │
│                                                             │
│  /agent-plan → /agent-tdd → /agent-code                     │
│       ↓                                                     │
│  npx vitest run path/to/file.test.ts    (AI runs this)      │
│       ↓ GREEN                                               │
│  ./hooks/pre-commit                     (local machine)     │
│       ↓ PASS                                                │
│  /commit → /push → /pr-summary                              │
│       ↓                                                     │
│  Pull Request → code review by Dev B                        │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│  Developer B (reviewer)                                     │
│                                                             │
│  /agent-review  (AI-assisted code review)                   │
│  Manual review  (business logic, architecture)              │
│       ↓                                                     │
│  Approve → Merge to development branch                      │
└─────────────────────────────────────────────────────────────┘
```

---

## Enforcing the workflow in CI

For teams that want the quality gates enforced in CI (not just locally):

### GitHub Actions — pre-merge check
```yaml
# .github/workflows/ci.yml
name: CI Quality Gate

on:
  pull_request:
    branches: [main, development]

jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install dependencies
        run: pnpm install

      - name: Lint
        run: pnpm run lint

      - name: Type check
        run: pnpm run typecheck

      - name: Tests (full suite — CI is not an AI terminal)
        run: pnpm run test

      - name: Build
        run: pnpm run build:ci
```

Note: CI runs the **full test suite** — that is correct. CI is not an AI context. The token rule applies only to AI agents in conversational sessions. CI has no token budget.

---

## Onboarding checklist for new teammates

```
[ ] Clone agents_skills to ~/.config/agents_skills
[ ] Add init-project alias to ~/.zshrc and source it
[ ] Clone the project repo
[ ] Run init-project from the project root
[ ] Verify hooks are active: git config --global core.hooksPath
[ ] Install AI tool of choice (Claude Code / OpenCode / Cursor)
[ ] Read AGENTS.md (token safety rules — mandatory)
[ ] Read CONTEXT.md (project context — mandatory)
[ ] Read WORKFLOW.md (end-to-end cheat sheet)
[ ] Run first task using /agent-plan
```

---

## Common team pitfalls

| Pitfall | Why it happens | Fix |
|---------|---------------|-----|
| Developer bypasses hooks with `--no-verify` habitually | Hook was blocking something and they found the bypass | Investigate why the hook blocked — fix the root cause, don't bypass |
| AI context diverges across team members | Each developer's tool is configured differently | Ensure AGENTS.md and CONTEXT.md are committed to the repo and up to date |
| task.md conflicts in git | Two developers updated task.md on the same branch | Keep task.md per-branch; merge carefully or use a ticketing system as the source of truth |
| One developer's hooks differ from another's | They cloned different versions of agents_skills | All team members should pull from the same org fork and `git pull` regularly |
| Team lead changes the workflow but no one knows | No PR process for agents_skills changes | Treat agents_skills changes as production changes — PR, review, merge |
