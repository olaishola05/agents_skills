# TROUBLESHOOTING.md — When Things Go Wrong

> Common problems and their exact fixes. Bookmark this.

---

## 🔒 Security / Hooks

### "My commit is being blocked but I don't know why"

```bash
# Run the security hook manually to see the full output
./hooks/security
```

The output will show exactly which file triggered the block and which pattern matched.

---

### "The security hook is flagging a false positive"

The hook matches patterns like `api_key`, `secret`, `password` — these can fire on variable names in test files or example configs.

**Fix — Option A:** Add a comment on the same line to skip it:
```typescript
const API_KEY_EXAMPLE = "your-api-key-here" // not a real secret
```

**Fix — Option B:** If the pattern fires repeatedly on legitimate code (e.g. a variable named `apiKeyField`), add an exception to the security hook:
```bash
# In hooks/security, find the grep line and add your exception:
grep -v -E "(apiKeyField|your_pattern)" > /dev/null
```

**Fix — Option C (emergency only):** Bypass with `--no-verify`:
```bash
git commit --no-verify -m "your message"
```
⚠️ Only use this when you are 100% certain there are no real secrets. Document why you bypassed.

---

### "Hook is not running at all on git commit"

The global hook path may not be set:
```bash
git config --global core.hooksPath
# Should output: /Users/<you>/.config/agents_skills/hooks
```

If blank, set it:
```bash
git config --global core.hooksPath ~/.config/agents_skills/hooks
```

If set correctly but still not running, check permissions:
```bash
ls -la ~/.config/agents_skills/hooks/
# pre-commit, pre-push, security must show -rwxr-xr-x (executable)

# Fix if not executable:
chmod +x ~/.config/agents_skills/hooks/pre-commit
chmod +x ~/.config/agents_skills/hooks/pre-push
chmod +x ~/.config/agents_skills/hooks/security
```

---

### "pre-push is blocked by phase4 sign-off"

```
❌ Push blocked. Sign-off is for commit abc123
   but that commit is not in this push range.
```

This means you made new commits since the last `phase4` review.

**Fix:**
```bash
./hooks/phase4          # run the quality review
./hooks/phase4 --sign-off   # sign off on the latest commit
git push                    # now succeeds
```

---

## 🤖 AI Agent Issues

### "The AI is still running ./hooks/pre-commit instead of the targeted test"

Your AGENTS.md has the rule, but the AI is ignoring it. This happens when:
1. The AI tool is not loading AGENTS.md from the project root
2. The conversation context is too long and the rule has scrolled out of the active window

**Fix:**
1. Confirm your AI tool loads `AGENTS.md` — check the tool's documentation for context file loading
2. Run `/compact` to clear the conversation and reload the context fresh
3. Explicitly remind the AI at the start of the task:
   > "Remember: only run the targeted test file, not the full suite"

---

### "The AI wrote code without writing a test first"

The agent skipped the TDD phase. This happens when:
- You used `/agent-code` without `/agent-tdd` having run first
- You asked the AI directly to "write the code for X" without invoking the workflow

**Fix:** Stop. Do not try to write tests for code that already exists — the tests will be biased toward the implementation. Delete the implementation, write the test first, then re-implement.

```bash
git checkout -- src/path/to/feature.ts   # restore the file to pre-implementation state
# Now run: /agent-tdd <feature description>
```

---

### "The AI went off-script and started doing things I didn't ask for"

AI agents sometimes interpret a task broadly and start modifying unrelated files.

**Fix:**
1. Check `git diff` to see everything that changed: `git diff --name-only`
2. Restore any files you didn't intend to change: `git checkout -- path/to/file`
3. On your next session, be more explicit in the task description:
   > "Only modify `src/lib/actions/history/list.ts` and its test file. Do not touch any other files."

---

### "The AI is reading huge files and burning tokens"

AGENTS.md has the curated reading rule, but the AI is reading entire PRD files or plan documents.

**Fix:** Explicitly tell the AI:
> "Do not read the full PRD. The only source of truth for the current task is `task.md`."

Keep `task.md` current and concise. It is the single source of truth — if the AI needs to read something else, it should ask you first.

---

### "Tokens ran out mid-session"

Your context window filled up. This happens when:
- The AI ran the full test suite (large output in context)
- The AI read multiple large files
- The session ran very long without compacting

**Fix (immediate):** Run `/compact` to summarise and clear the conversation.

**Fix (preventive):**
- Run `/compact` after every Green task transition (not just when you run out)
- Keep `task.md` updated so the AI can orient itself after compacting without re-reading large files
- Use targeted testing — `npx vitest run path/to/file.test.ts` — never the full suite

---

## 🔧 Symlinks & Project Setup

### "The symlinks (agents, hooks, skills) are broken"

```bash
ls -la agents hooks skills slash-commands
# If showing: broken symbolic link → ...
```

The global repo may have moved or been re-cloned to a different path.

**Fix:**
```bash
# Remove broken symlinks
rm agents hooks skills slash-commands

# Re-run init-project to recreate them
init-project
```

---

### "init-project created AGENTS.md but I already had one"

The script intentionally does **not** overwrite an existing `AGENTS.md`. Your existing rules are preserved.

If you want to merge in the standard token-optimised rules, manually copy the relevant sections from `~/.config/agents_skills/AGENTS.md` into your project's `AGENTS.md`.

---

### "The stack was not detected — validation was skipped"

```
📦 Detected stack: unknown
⚠️  Unknown stack — skipping code validation
```

The hook detects stacks by checking for `package.json`, `pyproject.toml`, `Gemfile`, `go.mod`, `Cargo.toml`. If none are present at the git root, it falls back to "unknown".

**Fix:** Make sure you're running `git commit` from the project root (where `package.json` lives), not from a subdirectory.

---

## 📦 pnpm / Node Issues

### "pnpm run test fails with 'Cannot find module'"

The test runner can't resolve path aliases (e.g. `@/lib/...`).

**Fix:** Ensure `vitest.config.ts` has the alias resolver:
```typescript
import { defineConfig } from 'vitest/config'
import path from 'path'

export default defineConfig({
  test: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
})
```

---

### "pnpm run typecheck passes but the AI says there's a type error"

The AI may have cached stale type information from earlier in the conversation.

**Fix:** Tell the AI:
> "Run `pnpm exec tsc --noEmit 2>&1 | head -30` and show me the actual output."

Always use the actual compiler output, not the AI's memory of a previous run.

---

## 🚀 Vercel / Deployment

### "Preview build fails with P1001: Can't reach database server"

The `DATABASE_URL` environment variable is either not set or is set to a placeholder value (`db_url`) in Vercel.

**Fix:**
1. Go to Vercel → Project → Settings → Environment Variables
2. Confirm `DATABASE_URL` is set for **Preview** environments (not just Production)
3. If using Neon, check that the Neon Vercel integration is connected and has provisioned variables for the Preview environment
4. The build script runs `prisma migrate deploy` — if `DATABASE_URL` is wrong, this is where it fails

**Verify locally:**
```bash
# Check what Vercel will see
vercel env pull .env.vercel.local
cat .env.vercel.local | grep DATABASE_URL
```

---

## 📋 Quick Reference — Most Common Fixes

| Problem | Fix |
|---------|-----|
| Hook not running | `git config --global core.hooksPath ~/.config/agents_skills/hooks` |
| Hook not executable | `chmod +x ~/.config/agents_skills/hooks/*` |
| Security false positive | Add `// not a real secret` comment, or use `--no-verify` with caution |
| phase4 push blocked | `./hooks/phase4 && ./hooks/phase4 --sign-off` |
| AI ignoring AGENTS.md | Run `/compact`, remind AI of the targeted test rule |
| Tokens exhausted | Run `/compact`, switch to targeted testing |
| Broken symlinks | `rm agents hooks skills slash-commands && init-project` |
| Stack not detected | Run `git commit` from the project root |
| Vercel DB error | Set `DATABASE_URL` for Preview env in Vercel dashboard |
