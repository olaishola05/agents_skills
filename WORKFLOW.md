# AI Development Workflow Cheat Sheet

This is the end-to-end workflow for building software using your AI toolkit. You do not need to memorize the tools; just follow the phases from top to bottom.

---

## 🧠 Phase 1: Inception & Design (The "What")
*Figure out exactly what you are building before you write code.*

| Command | When to use it | What it does |
| :--- | :--- | :--- |
| `/init-[stack] --prd` | Starting a brand new project | Scaffolds the codebase and immediately kicks off the PRD process. |
| `/grill-me` | You have a rough idea | The AI stress-tests your idea, asking edge-case questions one by one. |
| `/create-prd` | After answering questions | Converts your answers into a formal Product Requirements Document. |
| `/api-contract` | Designing backend features | Helps you design the API endpoints (OpenAPI/Swagger) before coding. |
| `/frontend-design` | Designing UI features | Helps you pick a premium design system (e.g., Stripe, Apple) for the UI. |

---

## 🗺 Phase 2: Planning (The "How")
*Break the massive PRD down into bite-sized, testable pieces.*

| Command | When to use it | What it does |
| :--- | :--- | :--- |
| `/prd-to-plan` | You have a completed PRD | Slices the PRD into end-to-end "Phases" (saved to `./plans/`). |
| `/agent-plan` | Ready to start coding | Takes a single Phase and breaks it down into atomic, step-by-step tasks. |

---

## 🏗 Phase 3: Execution (The "Building")
*The AI writes the code, enforcing Test-Driven Development.*

| Command | When to use it | What it does |
| :--- | :--- | :--- |
| `/agent-code [task]` | Ready to implement a task | **1. Auto-calls `agent-tdd`**: Writes failing tests first (Red).<br>**2. Implements**: Writes the code to make tests pass (Green).<br>**3. Validates**: Runs `hooks/pre-commit` to prove it compiles and tests pass. |

---

## 🛡 Phase 4: Quality & Security (The "Checking")
*Ensure the code is production-ready, safe, and documented.*

| Command | When to use it | What it does |
| :--- | :--- | :--- |
| `/agent-review` | Before opening a PR | The AI does a full "senior engineer" manual code review. |
| `/security-audit` | Before a major release | Runs an adversarial red-team scan for injection flaws or logic bugs. |
| `/optimize` | If performance is a concern | Scans code for memory leaks, O(n²) loops, or caching opportunities. |
| `/docs` | Before merging | Generates JSDoc/docstrings for all new functions. |

---

## 🚀 Phase 5: Git & Release (The "Shipping")
*Merge the code and tell the world about it.*

| Command | When to use it | What it does |
| :--- | :--- | :--- |
| `/clean` | Ready to commit | Strips out left-over `console.log` or debug comments. |
| `/commit` | Code is clean | Auto-generates a clean Conventional Commit message. |
| `/push` | Ready to push | Triggers `hooks/security` to prevent pushing `.env` keys or large files. |
| `/pr-summary` | Opening a Pull Request | Writes your GitHub PR description based on the code changes. |
| `/changelog` | Releasing a new version | Updates your `CHANGELOG.md` based on recent commits. |
| `/standup` | End of the day | Generates a team standup update based on your git history. |

---

## 🛠 Daily Maintenance (The Side Quests)
*Tools to help you when you get stuck.*

| Command | When to use it | What it does |
| :--- | :--- | :--- |
| `/fix` | You hit an error | Reads the stack trace, explains the error, and suggests/applies a fix. |
| `/explain` | Looking at confusing code | Explains the logic of a file or function in plain English. |
| `/deps` | Monthly maintenance | Audits for outdated or vulnerable NPM/Pip/Go packages. |
