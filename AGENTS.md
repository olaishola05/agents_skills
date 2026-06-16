# AGENTS.md

High-signal context for working in this repository.

---

## ⚠️ TOKEN SAFETY RULE — Read First

This workflow is optimized to conserve AI conversation tokens. The single biggest source of token waste is running the **full test suite** inside the AI terminal, which dumps thousands of lines of output into the conversation context.

| Action | Where it runs | Why |
|--------|--------------|-----|
| `npx vitest run path/to/file.test.ts` | **AI terminal** ✅ | Targeted — minimal output, safe |
| `pnpm run test` / `./hooks/pre-commit` | **User's machine** 🖥 | Full suite — runs locally only |

**Rule:** After every Green (passing targeted test), the AI **stops** and tells the user:
> "Please run `./hooks/pre-commit` locally before committing."

The git hooks enforce the full quality gate automatically on the user's machine.

---

## What This Repo Is

Personal development system containing reusable slash commands, skills, agents, and automated hooks for AI-assisted development. Works with OpenCode, Claude Code, and Cursor.

## Key Conventions

- **Slash commands**: `.md` files in `slash-commands/` with YAML frontmatter
- **Skills**: `.md` files in `skills/` with YAML frontmatter
- **Agents**: `.md` files in `agents/` with YAML frontmatter
- **Hooks**: Executable `.sh` scripts in `hooks/` (NOT markdown)

## Hooks

| Hook | Runs Where | What it does |
|------|------------|------|
| `pre-commit` | User's machine 🖥 | lint → typecheck → all tests → build |
| `pre-push` | User's machine 🖥 | security scan → pre-commit |
| `security` | User's machine 🖥 | Secrets detection only |

Run manually on your machine: `./hooks/pre-commit`, `./hooks/pre-push`, `./hooks/security`

Skip (not recommended): `git commit --no-verify`, `git push --no-verify`

## Commands with `--prd` Flag

All init commands support `--prd` to create PRD → Plan → Scaffold:
- `/init-api`
- `/init-frontend`
- `/init-python`
- `/init-rails`

## Special Behaviors

- **agent-code**: Automatically calls `agent-tdd` with user notification before proceeding
- **frontend-design skill**: Uses 47 company design systems from `https://github.com/olaishola05/awesome-design-md`
- **fix.md**: Auto-applies fixes, verifies with tests, rollback on failure
- **clean.md**: Removes logs/comments (no test verification)
- **pr-summary.md**: Includes implementation plan from `./plans/`

## Stack Detection

Init commands auto-detect framework from lockfiles:
- NestJS/Express/Fastify: `package.json`
- Go: `go.mod`
- FastAPI/Django: `requirements.txt` or `pyproject.toml`

## Reference

- Main docs: `README.md`
- Hooks: `hooks/README.md`
- Slash commands: `slash-commands/README.md`
- Skills: `skills/README.md`
- Agents: `agents/README.md`