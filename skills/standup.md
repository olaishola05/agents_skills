---
name: standup
description: Summarize recent git activity into a concise daily standup update.
---

# standup

Generate a daily standup update based on recent git activity.

## Workflow

1. Fetch git commits authored by the current user in the last 24-48 hours using `git log --author="[Your Name/Email]" --since="1 day ago"`.
2. Extract the core accomplishments from commit messages and code changes.
3. Format them into a professional, concise standup format:
   - **What I did yesterday:** (Summarized features/fixes)
   - **What I plan to do today:** (Leave blank for user to fill, or infer from open PRs/branches)
   - **Blockers:** (Ask user if they have any)

## Usage

```
/standup
```
