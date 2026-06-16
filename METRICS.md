# METRICS.md — How to Know the Workflow is Working

> If you can't measure it, you can't improve it.
> These are the numbers that tell you whether the workflow is saving time and money.

---

## 1. Token Usage (the most important metric)

### What to track
- Tokens consumed **per task** (one agent-code call)
- Tokens consumed **per phase** (one full feature)
- Tokens consumed **per session** (one working session)

### Baseline (before this workflow — typical numbers)
| Scenario | Token cost |
|----------|-----------|
| AI runs full test suite once | ~50,000–200,000 tokens |
| AI reads entire PRD | ~30,000–80,000 tokens |
| AI runs pre-commit hook (225 tests) | ~300,000–500,000 tokens |
| Full session without workflow | 1–3 million tokens / session |

### Target (with this workflow)
| Scenario | Token cost |
|----------|-----------|
| AI runs targeted test (1 file) | ~5,000–15,000 tokens |
| AI reads task.md only | ~2,000–5,000 tokens |
| AI runs targeted test (after impl) | ~10,000–20,000 tokens |
| Full session with workflow | 100,000–300,000 tokens / session |

### How to measure
Most AI tools show token usage per session. Check your provider dashboard:
- **Anthropic Console**: claude.ai/settings/usage
- **OpenAI**: platform.openai.com/usage
- **Groq**: console.groq.com/usage

Track weekly totals in a simple spreadsheet:
```
Week | Sessions | Total tokens | Avg per session | Cost
-----|----------|-------------|-----------------|------
W1   | 5        | 8,000,000   | 1,600,000       | $X
W2   | 5        | 1,200,000   |   240,000       | $Y  ← after workflow
```

---

## 2. Test Coverage

### What to track
- Total test count over time
- Coverage percentage (lines/branches/functions)
- Tests added per feature

### How to measure
```bash
# Vitest coverage report
pnpm exec vitest run --coverage

# Key numbers to watch:
# - Lines: aim for >80%
# - Branches: aim for >70%
# - Functions: aim for >90%
```

### What good looks like
Every feature shipped adds at least:
- 1 unit test per function
- 1 integration test per route/page (if routing is involved)
- 0 regressions in existing tests

Track the test count in your `task.md` notes:
```
Task 4 validation: ./hooks/pre-commit passed (225 tests; was 221 before this task)
```

---

## 3. Time per Feature (cycle time)

### What to track
- Time from "task starts" to "PR merged" for each atomic task
- Time from "phase starts" to "phase merged" for each phase

### How to measure
```bash
# Time between commits (rough proxy for task cycle time)
git log --format="%h %ai %s" | head -20

# PR cycle time (time from PR open to merge)
# Available in GitHub Insights → Pull Requests
```

### What good looks like
| Metric | Before workflow | With workflow (target) |
|--------|----------------|----------------------|
| Atomic task (1 file) | 45–90 min | 15–30 min |
| Medium task (3–5 files) | 2–4 hours | 45–90 min |
| Phase (8 tasks) | 2–3 days | 1 day |
| PR cycle time | 3–5 days | Same day |

The workflow speeds up cycle time by eliminating:
- Re-explaining context at the start of every session
- Debugging regressions caused by missing tests
- Hunting for secrets in git history
- Rebuilding broken branches

---

## 4. Regression Rate

### What to track
- How many times does a new feature break an existing test?
- How many times does a push fail the CI build?

### How to measure
```bash
# Check CI failure rate on GitHub Actions
# GitHub → Your repo → Actions → filter by "failure"

# Or locally: count how often pre-commit fails before passing
```

### What good looks like
With TDD enforced:
- **0 regressions** per phase is achievable (the targeted test catches feature bugs, the full hook catches regressions)
- CI failure rate should drop to <5% of PRs

---

## 5. Security Events

### What to track
- How many times did the security hook block a commit?
- Were any of those real secrets vs false positives?

### How to measure
Add logging to the security hook (optional):
```bash
# In hooks/security, add near the bottom:
echo "[$(date)] Security scan: $REAL_SECRETS real secrets blocked, $FALSE_POSITIVES false positives" >> ~/.config/agents_skills/logs/security.log
```

### What good looks like
- **0 real secrets** reaching git history (the primary goal)
- False positive rate below 5% (too many false positives causes developers to bypass the hook)

---

## 6. Phase Completion Rate

### What to track
- Are phases completing in the number of tasks estimated?
- Are tasks requiring more than one agent-code call to complete?

### How to measure
Count in `task.md`:
- Estimated tasks vs actual tasks when the phase completed
- How many tasks needed to be re-opened (a re-open = the initial implementation was wrong)

### What good looks like
- Task estimate accuracy >80% (estimated 8 tasks, actually took 8–10 tasks)
- Re-open rate <10% (most tasks pass first time)

---

## 7. The "Did It Ship?" Check

The ultimate metric. All the process in the world is worthless if nothing ships.

Track per week:
- Features shipped to production
- Bugs found in production (per feature shipped)
- Time to fix a production bug

### What good looks like
| Metric | Target |
|--------|--------|
| Features per week | 2–5 atomic features |
| Production bugs per feature | <0.5 (most features ship clean) |
| Time to fix production bug | <2 hours (because tests make root cause obvious) |

---

## Simple weekly review (10 minutes)

At the end of each week, answer these 5 questions:

```
1. Token cost this week vs last week: up or down?
2. Test count this week vs last week: growing?
3. Did any secrets reach git history? (should always be: no)
4. Did CI fail on any PR? Why?
5. How many features shipped to production?
```

If tokens are down, tests are up, no secrets leaked, CI is mostly green, and features are shipping — the workflow is working.

If tokens are up, run `/standup` and look at what commands the AI ran this week. The token spike will trace back to a specific session where something went wrong (full test suite, large file read, or a very long session without compacting).

---

## Benchmark: before vs after (30-day comparison)

Run this experiment: track your numbers for the first 2 weeks without reading this document, then track them for 2 weeks after fully adopting the workflow.

| Metric | Before | After | Change |
|--------|--------|-------|--------|
| Monthly token cost | $__ | $__ | _% |
| Tests in the project | __ | __ | +__ |
| Features shipped | __ | __ | +__ |
| Production bugs | __ | __ | -__ |
| Avg task cycle time | __ min | __ min | -__ |
| Secrets blocked at commit | N/A | __ | new |

Share your results. These numbers are the best advertisement for the workflow.
