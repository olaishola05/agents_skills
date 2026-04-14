---
name: grill-me
description: Interview the user relentlessly about any feature until reaching shared understanding. Ask questions one at a time, provide recommendations, explore codebase when relevant.
---

# grill-me

Interview me relentlessly about every aspect of a feature or plan until we reach shared understanding.

## Workflow

1. Ask one question at a time
2. Wait for user's answer
3. Provide recommendation based on answer
4. Ask next question (depends on previous answer)
5. Explore codebase if question can be answered by code
6. Repeat until all questions answered

## Questions to Ask

For each feature/plan, ask:

1. **What problem does this solve?**
2. **Who is the target user?**
3. **What are the edge cases?**
4. **How does it integrate with existing features?**
5. **What happens if it fails?**
6. **What are the alternatives considered?**
7. **How will you measure success?**

## Output Format

After each question:
```
## Question N: [Question]

Recommended: [Option] - Why

[Y]our answer / [S]how alternatives / [E]xplore codebase first
```

## Example

```
## Question 1: What problem does this feature solve?

Recommended: [B] - Simpler implementation with clear boundaries

[A] Auth flow optimization
[B] Reduced API calls
[C] Better user feedback

Your answer?
```

## Best Practices

- Ask one question at a time
- Provide clear options with recommendations
- Explain why you recommend each option
- Explore code before asking if it can be answered there
- Build on previous answers - each question depends on the last
- Don't move to next question until current is answered
- Keep asking until full understanding is reached