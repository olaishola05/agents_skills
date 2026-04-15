# Skills

Specialized workflows for AI-assisted development tasks.

## Available Skills

| Skill | Description |
|-------|-------------|
| `grill-me` | Interview user relentlessly about features until shared understanding |
| `write-a-skill` | Create new skills with proper structure |
| `create-prd` | Create PRD through interview and codebase exploration |
| `prd-to-plan` | Turn PRD into phased implementation plan |
| `frontend-design` | Build frontend with company design systems |

## Usage

```bash
# Trigger a skill
/skill-name

# Example
/grill-me
/create-prd
```

---

## Skills Details

### grill-me

Interview user about features with questions. Ask one at a time, provide recommendations, explore codebase when possible.

```
/grill-me
```

### write-a-skill

Create new skills with proper structure (SKILL.md, REFERENCE.md, scripts/).

```
/write-a-skill
```

### create-prd

Create product requirements document:
1. Gather requirements
2. Explore codebase
3. Interview user
4. Design modules
5. Write PRD

```
/create-prd
```

### prd-to-plan

Break PRD into vertical slices:
1. Confirm PRD in context
2. Explore codebase
3. Identify architectural decisions
4. Draft vertical slices
5. Quiz user
6. Write plan to `./plans/`

```
/prd-to-plan
```

### frontend-design

Build frontend with company design systems:
- Ask which design system (Apple, Stripe, Figma, etc.)
- Offer auto-detect from PRD
- Fetch DESIGN.md from design system repo
- Copy to `./resources/design/`
- Build using design system

```
/frontend-design
```

---

## Integration

Skills work together:

- `create-prd` → `prd-to-plan` → `init-api --prd`
- `grill-me` can be used before any planning
- `frontend-design` can usePRD context

---

## Tech Stack

Skills support all frameworks:
- **Backend**: NestJS, Express, Fastify, Go, FastAPI, Django
- **Frontend**: React, Vue, Svelte
- **ORM**: Prisma, SQLAlchemy, GORM