---
name: prd-to-plan
description: Turn a PRD into a multi-phase implementation plan using tracer-bullet vertical slices, saved as a local Markdown file in ./plans/. Use when user wants to break down a PRD, create an implementation plan, or mentions "tracer bullets".
---

# prd-to-plan

Turn a PRD into a phased implementation plan using vertical slices (tracer bullets). Output as a Markdown file in `./plans/`.

## Process

### Step 1: Confirm the PRD

Ensure the PRD is in conversation context. If it isn't, ask user to paste it or point to the file.

### Step 2: Explore Codebase

Explore the repository to understand:
- Current architecture
- Existing patterns
- Integration layers
- Similar implementations to follow

### Step 3: Identify Durable Architectural Decisions

Before slicing, identify high-level decisions unlikely to change:

- Route structures / URL patterns
- Database schema shape
- Key data models
- Authentication / authorization approach
- Third-party service boundaries

These go in the plan header so every phase can reference them.

### Step 4: Draft Vertical Slices

Break the PRD into tracer bullet phases. Each phase is a thin vertical slice that cuts through ALL integration layers end-to-end.

**Vertical Slice Rules:**
- Each slice delivers a narrow but COMPLETE path through every layer (schema, API, UI, tests)
- A completed slice is demoable or verifiable on its own
- Prefer many thin slices over few thick ones
- Do NOT include specific file names, function names, or implementation details
- DO include durable decisions: route paths, schema shapes, data model names

### Step 5: Quiz the User

Present the proposed breakdown as a numbered list. For each phase show:
- **Title**: short descriptive name
- **User stories covered**: which user stories from the PRD this addresses

Ask the user:
- Does the granularity feel right? (too coarse / too fine)
- Should any phases be merged or split further?

Iterate until user approves.

### Step 6: Write the Plan File

Create `./plans/` if it doesn't exist. Write the plan as a Markdown file named after the feature (e.g. `./plans/user-onboarding.md`).

## Plan Template

```markdown
# Plan: <Feature Name>

> Source PRD: <brief identifier or link>

## Architectural decisions

Durable decisions that apply across all phases:

- **Routes**: ...
- **Schema**: ...
- **Key models**: ...
- (add/remove sections as appropriate)

---

## Phase 1: <Title>

**User stories**: <list from PRD>

### What to build

A concise description of this vertical slice. Describe the end-to-end behavior, not layer-by-layer implementation.

### Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

---

## Phase 2: <Title>

**User stories**: <list from PRD>

### What to build

...

### Acceptance criteria

- [ ] ...

<!-- Repeat for each phase -->
```

## Best Practices

- Start with durable architectural decisions
- Create thin, demoable slices rather than thick phases
- Keep implementation details out of the plan (they change often)
- Focus on user stories for acceptance criteria
- Quiz user on granularity before finalizing
- Save plan to ./plans/ for future reference