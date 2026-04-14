---
name: Clean
description: Remove console.log, print statements, and unnecessary comments
tags: clean, debug, logs, comments, remove
---

# Clean

Remove debug statements and unnecessary comments from code.

## Workflow

1. Scan project for log statements and comments
2. Explain what will be removed (show each item)
3. Wait for confirmation before applying
4. **If confirmed**: Apply removals (one at a time if multiple)
5. Report success

## Usage

```
/clean                          # Clean all supported files
/clean --logs                   # Remove only log statements
/clean --comments              # Remove only comments
/clean src/app.ts              # Clean specific file
/clean --dry-run               # Show what would be removed
```

## Options

- `--logs`: Remove only log statements
- `--comments`: Remove only unnecessary comments
- `--dry-run`: Show what would be removed without deleting
- `--files`: Specific files to clean (default: all supported)

## Log Statements by Language

| Language | Patterns |
|----------|----------|
| JavaScript/TypeScript | console.log, console.error, console.warn, console.debug, console.info, console.trace |
| Python | print(), logging.info(), logging.debug(), logger.info(), logger.debug() |
| Go | fmt.Println, fmt.Printf, fmt.Print, log.Print, log.Printf |
| Ruby | puts, p, print, logger.info, logger.debug |
| Java | System.out.println, System.err.println, logger.info(), logger.debug() |
| Rust | println!, print!, eprintln!, eprint! |

## Comment Patterns to Remove

### Remove:
- Empty comment lines `//` or `#`
- Trailing comments on code (same line as code)
- Commented-out code blocks
- TODO/FIXME comments (keep important ones)
- Debug comments like `// debug`, `// log`, `// console`

### Keep:
- Docstrings (`/** */`, `///`, `"""`, `'''`)
- Public API documentation
- Complex logic explanation
- Copyright headers

## Supported File Extensions

```
.js, .ts, .jsx, .tsx, .py, .go, .rs, .rb, .java, .cs, .c, .cpp, .h
```

## Confirmation

Wait for user confirmation before applying:
- `[Y]es` - Apply the removals
- `[N]o` - Skip, no changes
- `[S]how details` - Show full details of what will be removed

Output before confirmation:
```
## Cleaning Plan

### Files to modify:
- src/app.ts (3 logs, 2 comments)
- src/utils.ts (5 logs)

### Details:
- src/app.ts:12: console.log('debug') → REMOVE
- src/app.ts:15: // unused → REMOVE
- src/utils.py:8: print('debug') → REMOVE
...

Apply? [Y]es / [N]o / [S]how details
```

## Applying Removals

After user confirms `[Y]es`:

1. **One at a time** if multiple items:
   - Show current item being removed
   - Apply removal to file
   - Move to next item

2. Report success

## Success Output

```
## Clean Complete

### Removed:
- 12 log statements
- 8 unnecessary comments

### Files modified:
- src/app.ts
- src/utils.ts
- src/services/auth.py

### Tests: ✓ Passed

All clean operations completed successfully.
```

## Best Practices

- Always review what will be removed first
- Use `--dry-run` to preview without applying
- Keep documentation comments
- Don't remove TODO/FIXME that reference issues

## Aliases

- `/remove-logs`
- `/strip`
- `/clean-logs`