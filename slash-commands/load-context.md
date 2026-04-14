---
name: Load Context
description: Load project context documents (PRD, architecture, specs) for AI context
tags: context, prd, docs, specification, architecture
---

# Load Context

Load project documentation into AI context for better understanding of requirements.

## Detection

Auto-detect common documentation files in the project root:

- `PRD.md` - Product Requirements Document
- `SPEC.md` - Technical Specification
- `ARCHITECTURE.md` - Architecture Documentation
- `README.md` - Project README
- `docs/` - Documentation directory
- `.context/` - Context directory (custom context files)
- `context/` - Context directory

## Supported Formats

- **Markdown** (`.md`)
- **Text** (`.txt`)
- **JSON** (`.json`)
- **YAML** (`.yaml`, `.yml`)

## Usage

Load specific context file:

```
/load-context prd
```

Load specific file path:

```
/load-context docs/architecture.md
```

Load all context files:

```
/load-context all
```

Load multiple files:

```
/load-context prd, architecture, spec
```

## Context File Search Order

If no specific file provided, search in this order:

1. `PRD.md`
2. `SPEC.md`
3. `ARCHITECTURE.md`
4. `.context/` directory
5. `docs/` directory

## Best Practices

- Keep context files updated
- Use descriptive filenames
- Include version/dates in filenames if needed
- Use markdown for rich formatting
- Store in `.context/` to keep organized

## Example Context Structure

```
.context/
├── prd.md
├── architecture.md
├── api-spec.md
├── database-schema.md
└── team-contacts.md
```

## If No PRD Found

If `/load-context prd` is used and no PRD is found, offer to create one:

```
No PRD found in:
- PRD.md
- SPEC.md
- .context/prd.md

Want me to create a PRD first?
[Y]es - Use create-prd skill
[N]o - Load what exists
```

## Aliases

- `/context`
- `/load-docs`
- `/load-prd`
- `/load-spec`