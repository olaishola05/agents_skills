---
name: Fix
description: Analyze errors and suggest fixes by rerunning last command
tags: fix, error, debug, stack trace, runtime error
---

# Fix

Analyze stack traces or runtime errors and provide instant fixes.

## Workflow

1. Get last command from shell history
2. Re-execute the command (30s timeout)
3. Capture stdout/stderr output
4. Parse error type, message, location
5. Explain the error
6. Suggest a fix
7. Wait for confirmation before applying
8. **If confirmed**: Apply the fix
9. **Run tests** to verify
10. **If tests pass**: Report success
11. **If tests fail**: Roll back → Go back to step 5 (explain new fix)
12. Repeat until tests pass

## Usage

```
/fix                    # Rerun last command, explain error, suggest fix
/fix --explain-only    # Just explain, no fix suggested
/fix --dry-run         # Show what fix would do without applying
/fix [error paste]     # Manually paste error if rerun doesn't work
```

## Options

- `--explain-only`: Explain the error without suggesting a fix
- `--dry-run`: Show the proposed fix without applying it
- `--timeout`: Set timeout (default 30s)

## Error Detection

Detect common errors by language:

| Language | Error Types |
|----------|------------|
| JavaScript/TypeScript | ReferenceError, TypeError, SyntaxError, RangeError, EvalError |
| Python | ImportError, TypeError, ValueError, KeyError, AttributeError, SyntaxError |
| Ruby | NameError, TypeError, NoMethodError, ArgumentError |
| Go | index out of range, nil pointer, type assertion |
| Java | NullPointerException, ArrayIndexOutOfBoundsException |

## Output Format

```
## Error Detected

### Type: [ErrorType]
### Message: [error message]
### Location: [file:line]
### Command: [the command that failed]

## Explanation
[What the error means and root cause]

## Suggested Fix
```[language]
// Code diff or fix
```

Apply? [Y]es / [N]o / [S]how full code
```

## Fallback

If rerunning the command fails or doesn't reproduce the error:
1. Try to get error from log files in `./logs/` or `./error.log`
2. If no logs found, prompt user to paste error manually

## Timeout

Default: 30 seconds
Use `--timeout 60` for longer running commands

## Confirmation

Always wait for user confirmation before applying any fixes:
- `[Y]es` - Apply the fix
- `[N]o` - Skip, no changes
- `[S]how code` - Show full file with proposed changes

## Multiple Fixes

If there are multiple fixes needed:
- Apply **one at a time**
- Confirm each fix before applying
- Run tests after each fix
- If tests fail, rollback and suggest a different fix
- Repeat until all fixes are applied and tests pass

## Applying the Fix

After user confirms `[Y]es`:
1. Create backup of files to be modified
2. Apply the fix to files
3. Run the failed command again to verify fix worked
4. Run full test suite (see Test Detection below)

## Test Detection

Auto-detect test command based on project:

| Project Type | Test Command |
|--------------|--------------|
| Node.js (npm) | `npm test` or `npm run test` |
| Node.js (yarn) | `yarn test` |
| Node.js (pnpm) | `pnpm test` |
| Python (pytest) | `pytest` or `python -m pytest` |
| Python (unittest) | `python -m unittest` |
| Ruby (rspec) | `rspec` |
| Go | `go test ./...` |
| Rust | `cargo test` |

If no test command found, ask user to specify.

## Test Failure Handling

If tests fail after applying fix:
1. **Roll back** all changes made
2. Report test failure with details
3. Go back to explaining the error
4. Suggest a different fix
5. Repeat until tests pass

## Loop Until Success

```
[Apply fix] → [Run tests] → [Pass?] → Yes → Success
                                      ↓ No
                              [Roll back] → [Suggest new fix] → [Confirm] → [Apply fix] → ...
```

## Best Practices

- Analyze error root cause, not just symptoms
- Explain in simple terms what went wrong
- Provide minimal fix, don't refactor unrelated code
- If multiple fixes, apply one at a time
- Always run tests after each fix
- Roll back if tests fail and try a different approach

## Aliases

- `/debug`
- `/error`
- `/fix-error`