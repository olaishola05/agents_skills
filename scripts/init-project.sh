#!/bin/bash
# ============================================================
# init-project.sh — Wire a new project into the global
# agents_skills workflow in seconds.
#
# Usage:
#   ~/.config/agents_skills/scripts/init-project.sh
#   (run from the root of your new project)
#
# What it does:
#   1. Creates symlinks  agents / hooks / skills / slash-commands
#      pointing at ~/.config/agents_skills/
#   2. Drops a starter AGENTS.md with the token safety rule
#   3. Drops a CONTEXT.md template for project context
#   4. Confirms global git hooks are active
# ============================================================

set -e

AGENTS_SKILLS_DIR="$HOME/.config/agents_skills"
PROJECT_DIR="$(pwd)"

# ── Colours ──────────────────────────────────────────────────
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
RED="\033[0;31m"
RESET="\033[0m"

ok()   { echo -e "${GREEN}✅  $1${RESET}"; }
info() { echo -e "${BLUE}ℹ️   $1${RESET}"; }
warn() { echo -e "${YELLOW}⚠️   $1${RESET}"; }
err()  { echo -e "${RED}❌  $1${RESET}"; }

echo ""
echo -e "${BLUE}================================================${RESET}"
echo -e "${BLUE}   agents_skills — Project Setup${RESET}"
echo -e "${BLUE}================================================${RESET}"
echo ""

# ── 0. Guard: must be run from inside a git repo ─────────────
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  err "Not inside a git repository. Run 'git init' first."
  exit 1
fi

# ── 1. Verify agents_skills exists ───────────────────────────
if [ ! -d "$AGENTS_SKILLS_DIR" ]; then
  err "agents_skills not found at $AGENTS_SKILLS_DIR"
  echo "Clone it first:"
  echo "  git clone https://github.com/olaishola05/agents_skills.git ~/.config/agents_skills"
  exit 1
fi

# ── 2. Create symlinks ────────────────────────────────────────
echo "📎 Creating symlinks..."

LINKS=("agents" "hooks" "skills" "slash-commands")

for link in "${LINKS[@]}"; do
  TARGET="$AGENTS_SKILLS_DIR/$link"
  DEST="$PROJECT_DIR/$link"

  if [ -L "$DEST" ]; then
    warn "$link → already a symlink, skipping"
  elif [ -e "$DEST" ]; then
    warn "$link → already exists as a real file/directory. Remove it manually if you want a symlink."
  else
    ln -s "$TARGET" "$DEST"
    ok "$link → $TARGET"
  fi
done

# ── 3. Add AGENTS.md (if not present) ────────────────────────
echo ""
echo "📄 Setting up AGENTS.md..."

AGENTS_MD="$PROJECT_DIR/AGENTS.md"

if [ -f "$AGENTS_MD" ]; then
  warn "AGENTS.md already exists — skipping (not overwriting your rules)"
else
  cat > "$AGENTS_MD" << 'EOF'
<!-- BEGIN:nextjs-agent-rules -->
# This is NOT the Next.js you know

This version has breaking changes — APIs, conventions, and file structure may all differ from your training data. Read the relevant guide in `node_modules/next/dist/docs/` before writing any code. Heed deprecation notices.
<!-- END:nextjs-agent-rules -->

<!-- BEGIN:workflow-rules -->
# Strict Workflow Enforcement (Token-Optimised Edition)

Any AI agent operating in this repository MUST follow the procedures defined in `WORKFLOW.md` with strict boundaries between code generation (AI) and task execution (User).

1. **No Cowboy Coding:** Never write code directly from a PRD or phase document.
2. **Planning Phase:** You MUST use the process in `agents/agent-plan.md` to break a phase plan into concrete, ordered atomic tasks BEFORE starting implementation.
3. **Execution Phase (TDD - Target-Isolated):**
   - Write the failing test file first (Red).
   - Implement the feature file to pass the test (Green).
   - **DO NOT run global test suites or execute `./hooks/pre-commit` inside the agent environment.**
   - Run ONLY the specific test file: `npx vitest run path/to/file.test.ts`
   - Tell the user to run `./hooks/pre-commit` locally before committing.
4. **Quality Gate (Phase 4 - AI Assist Only):**
   - **DO NOT execute `./hooks/phase4` inside the agent environment.**
   - Perform your single-pass review textually: code smells (Clean Code + GoF), senior engineer review, JSDoc for new functions.
   - Once the textual review passes, declare the task complete and stop.
   - **The user will manually handle local linting, local git commits, and the local `./hooks/phase4 --sign-off` on their machine.**
<!-- END:workflow-rules -->

<!-- BEGIN:integration-test-rules -->
# Strict Integration & Routing Rules

1. **Verify Connections, Not Just Units:** If a task implements middleware, layouts, or custom route-gating, you MUST write an integration test that asserts the page-level navigation/redirect behaviour.
2. **No Dead Ends:** Ensure buttons, links, and forms added in new layouts are actually wired to their respective destination routes.
<!-- END:integration-test-rules -->

<!-- BEGIN:context-curation-rules -->
# Context Curation & Token Optimisation

1. **Active State Tracker:** Use the `task.md` file at the root of the project as the single source of truth for the current phase's tasks and progress. Do not scan git history, PR logs, or large markdown plans unless specifically directed.
2. **Curated Reading:** Do not read entire PRD or plan files at the start of a session. Read files lazily on a task-by-task basis.
3. **Proactive Compacting:** Remind the user to run `/compact` immediately after every successful "Green" task transition.
<!-- END:context-curation-rules -->

<!-- BEGIN:design-system-rules -->
# Design System
- For all frontend styling, component sizing, colours, and layouts, consult: `resources/design/vercel.md`
<!-- END:design-system-rules -->
EOF
  ok "AGENTS.md created"
fi

# ── 4. Add CONTEXT.md (if not present) ───────────────────────
echo ""
echo "📄 Setting up CONTEXT.md..."

CONTEXT_MD="$PROJECT_DIR/CONTEXT.md"

if [ -f "$CONTEXT_MD" ]; then
  warn "CONTEXT.md already exists — skipping"
else
  cp "$AGENTS_SKILLS_DIR/templates/CONTEXT.md" "$CONTEXT_MD"
  # Replace placeholder with real folder name
  PROJECT_NAME=$(basename "$PROJECT_DIR")
  sed -i '' "s/{{Project Name}}/$PROJECT_NAME/" "$CONTEXT_MD" 2>/dev/null || true
  ok "CONTEXT.md created (fill in your stack details)"
fi

# ── 5. Add WORKFLOW.md (if not present) ──────────────────────
echo ""
echo "📄 Setting up WORKFLOW.md..."

WORKFLOW_MD="$PROJECT_DIR/WORKFLOW.md"

if [ -f "$WORKFLOW_MD" ]; then
  warn "WORKFLOW.md already exists — skipping"
else
  cp "$AGENTS_SKILLS_DIR/WORKFLOW.md" "$WORKFLOW_MD"
  ok "WORKFLOW.md copied from global workflow"
fi

# ── 6. Verify global git hooks ───────────────────────────────
echo ""
echo "🔧 Checking global git hooks..."

CURRENT_HOOKS_PATH=$(git config --global core.hooksPath 2>/dev/null || echo "")

if [ "$CURRENT_HOOKS_PATH" = "$AGENTS_SKILLS_DIR/hooks" ]; then
  ok "Global git hooks already pointing to agents_skills/hooks"
else
  info "Configuring global git hooks..."
  git config --global core.hooksPath "$AGENTS_SKILLS_DIR/hooks"
  ok "git config --global core.hooksPath set to $AGENTS_SKILLS_DIR/hooks"
  info "This applies pre-commit and pre-push to ALL your git repos automatically."
fi

# ── 7. Add .gitignore entry if not already there ─────────────
GITIGNORE="$PROJECT_DIR/.gitignore"
if [ -f "$GITIGNORE" ]; then
  if ! grep -q "^agents$" "$GITIGNORE" 2>/dev/null; then
    echo "" >> "$GITIGNORE"
    echo "# agents_skills symlinks (point to ~/.config/agents_skills/)" >> "$GITIGNORE"
    echo "# Remove these lines if you WANT to commit the symlinks" >> "$GITIGNORE"
    ok ".gitignore: symlink entries added (agents, hooks, skills, slash-commands)"
  else
    warn ".gitignore: symlink entries already present"
  fi
fi

# ── Done ──────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}================================================${RESET}"
echo -e "${GREEN}   ✅ Project wired into agents_skills!${RESET}"
echo -e "${GREEN}================================================${RESET}"
echo ""
echo "Next steps:"
echo "  1. Edit CONTEXT.md — fill in your stack, conventions, and architecture"
echo "  2. Edit AGENTS.md  — add any project-specific rules"
echo "  3. Start coding:   /agent-plan <phase>"
echo ""
echo "Your hooks are active. Every commit runs:"
echo "  lint → typecheck → tests"
echo ""
