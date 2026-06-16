# WHY.md — The Philosophy Behind This Workflow

> This document explains the *reasoning* behind every rule and design decision.
> Rules you understand, you follow. Rules you don't understand, you skip.

---

## Why this workflow exists

Most developers using AI coding tools in 2024–2025 discovered the same thing independently:

> **AI agents are incredibly fast at writing code. They are also incredibly fast at writing the wrong code, in the wrong place, with no tests, that burns your entire token budget in 48 hours.**

This workflow is the answer to that problem. It treats an AI agent the same way you would treat a very fast, very confident junior developer who sometimes hallucinates — talented, but needing guardrails.

---

## Why we plan before we code (PRD → Plan → Tasks)

**The problem it solves:** AI agents, when given a vague instruction, will make assumptions and start building immediately. Half of those assumptions are wrong. You spend tokens fixing the wrong thing instead of building the right thing.

**The solution:** `/grill-me` → `/create-prd` → `/prd-to-plan` → `/agent-plan`

Each step narrows the problem space before a single line of code is written:
- `/grill-me` forces *you* to think through edge cases before the AI does
- `/create-prd` locks down the spec so the AI cannot deviate from it
- `/prd-to-plan` breaks the spec into vertical slices (each slice delivers real user value)
- `/agent-plan` breaks each slice into atomic tasks (each task is one AI call)

**The rule:** Never ask an AI to implement something you haven't specified. "Build me a dashboard" is not a specification. "Build the analytics widget that shows daily active users for the last 30 days, pulled from the `/api/analytics` endpoint" is.

---

## Why TDD (tests before code)

**The problem it solves:** AI agents default to writing implementation code first because that's what they've seen most often in training data. Without a failing test as a constraint, the AI writes *plausible* code — code that looks right but handles edge cases incorrectly, has no error handling, and cannot be safely refactored.

**The solution:** Write the failing test first (Red), then implement (Green).

When the AI writes a test first, it is forced to define:
- What inputs the function accepts
- What outputs it should return
- What error states it should handle
- What the contract of the module is

That specification becomes the implementation target. The AI cannot drift from it because the test will fail if it does.

**The rule:** No feature file without a test file. Every `feature.ts` has a `feature.test.ts` that was written first.

---

## Why targeted testing (not the full suite)

**The problem it solves:** Running `pnpm run test` inside an AI terminal dumps every test log — pass/fail output, console warnings, timing information — for every test in your entire project into the conversation context. In a project with 225 tests, that is thousands of lines of output per task. Across a 6-phase project with 8 tasks per phase, that is millions of tokens consumed by test noise.

**The solution:** The AI runs only the test file it just wrote.

```bash
# AI does this (targeted — ~15 lines of output)
npx vitest run src/lib/actions/__tests__/my-feature.test.ts

# NOT this (full suite — thousands of lines of output)
pnpm run test
```

The full sweep runs on your machine via the git hook — automatically, on every commit, with zero token cost.

**The rule:** The AI's job is to make *its own test* go green. Your machine's job is to make *all tests* stay green.

---

## Why security runs at commit time, not push time

**The problem it solves:** A secret (API key, database password, private key) that is blocked at `git push` has already been written into your git history. Even if the push is blocked, the secret exists in:
- `git log` output
- `git reflog`
- Any local clone of the repo
- CI/CD pipelines that clone before running hooks

If you ever run `git push --no-verify` (which you will, in a hurry), the secret reaches the remote.

**The solution:** Security scan runs as Step 1 of `pre-commit`, before lint, before tests, before anything. If a secret is staged, the commit is blocked. The secret never enters history.

```
pre-commit:  🔒 SECURITY (Step 1) → lint → typecheck → tests
pre-push:    🔒 security (again)   → phase4 gate → pre-commit
```

**The rule:** Security is the first gate, not the last. The second scan at push is a belt-and-suspenders check, not the primary defence.

---

## Why git hooks are global (not per-project)

**The problem it solves:** Per-project hooks (stored in `.git/hooks/`) require every developer on the team to manually install them. They get forgotten when cloning a new repo. One developer without hooks can push code that breaks the entire quality contract.

**The solution:** One global hook path:
```bash
git config --global core.hooksPath ~/.config/agents_skills/hooks
```

This applies the same quality gates to every git repo on your machine automatically. When you clone a new project, the hooks are already active — no setup required.

**The rule:** Quality gates are machine-wide, not project-wide. The project repo stores a symlink to the global hooks so the AI can reference them, but the enforcement happens at the OS level.

---

## Why the AI stops after the targeted test passes

**The problem it solves:** AI agents, if not told to stop, will continue to "improve" the code — refactoring things that didn't need refactoring, adding features that weren't requested, running more commands, reading more files. Each extra step burns tokens and increases the risk of introducing a regression.

**The solution:** The AI has a clear exit condition — the targeted test is GREEN. After that, it stops and hands control back to you.

```
AI: ✅ Tests passed: src/lib/actions/__tests__/my-feature.test.ts
    Please run ./hooks/pre-commit locally before committing.
```

You run the hook. It passes. You commit. The AI never knew your 225-test suite existed.

**The rule:** Green targeted test = AI's job is done. Everything else is your machine's responsibility.

---

## Why CONTEXT.md (per project)

**The problem it solves:** AI agents start every session with no memory of the project. Without context, the first 3–5 messages of every session are spent re-explaining the stack, the conventions, the architecture, and the naming patterns. That is wasted tokens and wasted time.

**The solution:** `CONTEXT.md` at the project root. The AI reads it at the start of every session and immediately knows:
- What the project does
- What the tech stack is
- What the conventions are
- What the key architectural decisions were and why

**The rule:** Every project has a `CONTEXT.md`. It is the single source of truth for project-level context. It is kept up to date as the project evolves.

---

## Why conventional commits

**The problem it solves:** `git log` in most projects looks like this:
```
fixed stuff
WIP
ok now it works
changed the thing
```

This makes it impossible to generate a changelog, understand what changed between versions, or debug a regression by reading the history.

**The solution:** Conventional commits enforce a structured format:
```
feat(auth): add Google OAuth login
fix(api): handle null user in session check
docs(readme): add setup instructions
```

This makes `git log` readable, makes changelogs auto-generatable with `/changelog`, and makes code review faster because reviewers can understand the intent of each commit before reading the diff.

**The rule:** Every commit follows the `type(scope): description` format. The AI generates these automatically with `/commit`.

---

## Why the phase4 gate before pushing

**The problem it solves:** Code that passes tests can still be bad code — duplicated logic, missing JSDoc, security vulnerabilities, performance issues. Tests verify behaviour; they don't verify quality.

**The solution:** Before any push to remote, the AI runs a structured quality review:
- Code smells (Clean Code principles + GoF patterns)
- Senior engineer perspective (would this code survive a PR review?)
- JSDoc for all new functions
- Security considerations

The `.phase4-signoff` file records which commit was reviewed. The `pre-push` hook verifies the signoff is current before allowing the push.

**The rule:** Passing tests is the bar for committing. Passing the phase4 review is the bar for pushing.

---

## The core principle

Every rule in this workflow comes back to one idea:

> **AI agents are tools, not teammates. Tools need constraints. Constraints need to be enforced automatically, not by willpower.**

The git hooks enforce quality automatically.
The AGENTS.md enforces agent behaviour automatically.
The task.md enforces planning discipline automatically.
The targeted test rule enforces token conservation automatically.

You don't rely on remembering the rules. The system enforces them.
