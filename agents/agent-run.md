---
name: Agent Run (Orchestrator)
description: Fully automates the execution of a project phase. Reads a plan file, extracts the atomic tasks, and sequentially executes them using the agent-code loop. Does not require user copy-pasting.
tags: agent, run, execute, automate, loop
---

# Agent Run

Act as the Orchestrator Agent. Your job is to completely automate the implementation of a project phase without requiring the user to copy-paste tasks manually.

## Usage

`/agent-run ./plans/[phase-file].md`

## Process

### Step 1: Read and Extract Tasks
1. Read the provided plan file.
2. Look for an existing "Tasks (ordered)" section. 
3. If no atomic tasks exist in the file, first use the `/agent-plan` logic to decompose the phase into atomic tasks, then proceed to Step 2.
4. Extract the full list of tasks into your memory.

### Step 2: Present the Execution Queue
Show the user the queue of tasks you are about to execute:
```
🚀 Auto-Run Initiated for: [Phase Name]
Queue:
1. [Task 1 Name]
2. [Task 2 Name]
...

Type "Go" to begin autonomous execution.
```

### Step 3: The Autonomous Loop
Once the user says "Go", begin the execution loop. For EACH task in the queue:

1. **Announce**: "Executing Task [N]: [Task Name]..."
2. **Execute**: Trigger the exact logic of `/agent-code` for this specific task.
   - Write tests first (TDD)
   - Implement the code
   - Verify tests pass
   - Commit the code via Git
3. **Verify**: Ensure the Git commit was successful and tests are green.
4. **Advance**: Move immediately to Task [N+1] without asking for permission.

### Step 4: Exception Handling (When to Stop)
You must STOP the autonomous loop and ask the user for help ONLY IF:
- A test fails more than 3 times in a row.
- You encounter a terminal error (e.g., missing API key, port in use) that you cannot fix automatically.
- A git conflict occurs.

### Step 5: Completion
When all tasks are finished, print a success summary:
```
✅ Phase Complete!
- Tasks executed: [Total]
- Commits made: [Total]
- Status: Ready for review.
```

## Best Practices
- Never execute tasks out of order. Task 2 assumes Task 1 is committed.
- Keep output concise during the loop so the chat window doesn't get flooded. Focus on test passing and git commit hashes.
- If the user interrupts you (e.g., typing "stop" or "pause"), pause the loop immediately and save the current state.
