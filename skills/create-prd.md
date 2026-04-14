---
name: create-prd
description: Create a PRD through user interview, codebase exploration, and module design. Use when user wants to write a PRD, create a product requirements document, or plan a new feature.
---

# create-prd

Create a Product Requirements Document (PRD) through user interview, codebase exploration, and module design.

## Process

### Step 1: Gather Requirements

Ask the user for a long, detailed description of:
- The problem they want to solve
- Any potential ideas for solutions
- Who the target users are
- What the expected outcomes are

### Step 2: Explore Codebase

Explore the repository to:
- Verify their assertions about current functionality
- Understand the current state of the codebase
- Find related modules or features
- Check for existing patterns to follow

### Step 3: Interview User

Use the grill-me skill to interview the user relentlessly about every aspect of the plan until shared understanding is reached. Ask questions one at a time, resolving dependencies between decisions.

### Step 4: Design Modules

Sketch out the major modules needed:
- Which modules will be built or modified
- Which modules can be tested in isolation
- Look for deep modules (encapsulate functionality in simple, testable interfaces)

Check with the user that these modules match their expectations. Ask which modules need tests written.

### Step 5: Write PRD

Once complete understanding is reached, write the PRD using the template below.

## PRD Template

```markdown
## Problem Statement

The problem that the user is facing, from the user's perspective.

## Solution

The solution to the problem, from the user's perspective.

## User Stories

A numbered list of user stories in the format:

1. As an <actor>, I want a <feature>, so that <benefit>

Example:
1. As a mobile bank customer, I want to see balance on my accounts, so that I can make better informed decisions about my spending

This list should be extensive and cover all aspects of the feature.

## Implementation Decisions

- The modules that will be built/modified
- The interfaces of those modules
- Technical clarifications
- Architectural decisions
- Schema changes
- API contracts
- Specific interactions

Do NOT include specific file paths or code snippets.

## Testing Decisions

- What makes a good test (test external behavior, not implementation details)
- Which modules will be tested
- Prior art for tests (similar types in the codebase)

## Out of Scope

Things that are out of scope for this PRD.

## Further Notes

Any additional notes about the feature.
```

## Optional: Submit as GitHub Issue

After writing the PRD, you can submit it as a GitHub issue:

1. Create a new issue in the repository
2. Use the PRD as the issue body
3. Add relevant labels
4. Assign to appropriate milestone if applicable

## Best Practices

- Be thorough in understanding the problem before designing solution
- Use user stories to capture all scenarios
- Focus on external behavior for testing decisions
- Keep implementation details at module level, not file level
- Review with user before finalizing