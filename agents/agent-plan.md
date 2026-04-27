---
name: Agent Plan
description: Break a plan phase from prd-to-plan into specific, ordered implementation tasks before agent-code runs. Use when you have a ./plans/ file and need to decompose a phase into concrete tasks for implementation. Bridges prd-to-plan output and agent-code execution.
tags: agent, plan, tasks, decompose, implementation, breakdown
---

# Agent Plan

Break a plan phase into concrete, ordered implementation tasks before coding begins.

## Usage

```
/agent-plan [phase title or path to plan file]
```

Examples:

```
/agent-plan "Phase 1: User Authentication"
/agent-plan ./plans/user-onboarding.md --phase 2
```

## Process

### Step 1: Load the Phase

- Read the plan file from `./plans/` if a path is provided
- If no path, ask user to paste the phase content or specify which phase
- Confirm the acceptance criteria for this phase with the user

### Step 2: Explore Codebase

Explore the repository to:
- Identify existing files, patterns, and conventions relevant to this phase
- Find similar implementations to follow
- Check for existing utilities, helpers, or modules to reuse
- Identify interfaces and contracts that must be respected

### Step 3: Decompose into Tasks

Break the phase into ordered, atomic implementation tasks.

**Task Rules:**
- Each task should be completable in a single `agent-code` call
- Tasks must be ordered by dependency (schema → API → UI, backend → frontend)
- Each task must map to at least one acceptance criterion
- Tasks should be narrow and independently testable
- If a task would touch more than 3–4 files, split it further

### Step 4: Present Task Breakdown

Show the user a numbered task list:

```
## Implementation Plan: [Phase Title]

Source: ./plans/[feature].md — Phase N

### Tasks (ordered)

1. [Task Name]
   - What: [what to build]
   - Tests: [what agent-tdd will write]
   - Covers: [acceptance criteria reference]

2. [Task Name]
   - What: ...
   - Tests: ...
   - Covers: ...

...

### Complexity: [Low / Medium / High]
### External dependencies: [any setup needed before starting]
```

Ask the user:
- Does the task order make sense?
- Should any tasks be merged or split?
- Any tasks to skip or defer?

Iterate until approved.

### Step 5: Hand Off

After user approves, output the ready-to-run sequence:

```
✅ Task breakdown approved. Run in order:

/agent-code [Task 1 description]
/agent-code [Task 2 description]
...
```

## Validation

Before presenting the task breakdown, verify:
1. All acceptance criteria from the phase are covered by at least one task
2. No task is too large (split if touching more than 3–4 files)
3. Tasks are ordered correctly (no circular dependencies)
4. Schema/DB tasks precede API tasks; API tasks precede UI tasks

## Integration with Full Workflow

```
/grill-me
  → Stress-tests the plan with Q&A

/create-prd
  → Produces a full PRD (internally calls grill-me again)

/prd-to-plan
  → Breaks PRD into phases → saves to ./plans/*.md

/agent-plan ./plans/feature.md --phase 1      ← THIS AGENT
  → Breaks Phase 1 into ordered tasks

/agent-code [Task 1]
  → TDD loop: tests first → implement → validate → commit

/agent-code [Task 2]
  → Repeat for each task

/agent-review
  → Final review checklist before PR

/pr-summary
  → Generates PR description using ./plans/ output
```

## Options

- `--phase N`: Target a specific phase number from the plan file
- `--dry-run`: Show task breakdown without committing to it
- `--all-phases`: Generate a high-level task overview for all phases

## Best Practices

- Always read the plan file before decomposing — never guess
- Prefer more, smaller tasks over fewer, larger ones
- Ensure every acceptance criterion maps to a task
- Check codebase before inventing new patterns to follow
- Never start implementation — hand off to agent-code

## Aliases

- `/plan`
- `/breakdown`
- `/decompose`
