---
name: frontend-design
description: Create distinctive, production-grade frontend interfaces with high design quality. Use this skill when the user asks to build web components, pages, or applications. Generates creative, polished code that avoids generic AI aesthetics. Optionally uses company design systems from user's design repo.
license: Complete terms in LICENSE.txt
---

# frontend-design

Create distinctive, production-grade frontend interfaces with high design quality. Use established company design systems when specified.

## Option 1: Use Company Design System (From User's Repo)

If user specifies a design system, use the custom workflow:

### Step 1: Ask User

Ask: "Which design system?"

Show available options:
- Apple (Premium white space, SF Pro)
- Stripe (Signature purple)
- Figma (Vibrant multi-color)
- Linear (Ultra-minimal, purple accent)
- Vercel (Black and white, Geist font)
- Notion (Warm minimalism, serif headings)
- Spotify (Green on dark)
- Or say "auto-detect" for PRD-based recommendation

### Step 2: Offer Auto-Detect

If user says "auto-detect" or is unsure:

```
Offer: Check PRD and recommend best design system?

[Y]es - Analyze PRD / [N]o - I choose manually
```

When analyzing PRD:
- Enterprise apps → IBM, Stripe
- Consumer apps → Apple, Airbnb
- Developer tools → Vercel, Linear, Cursor
- Creative/design → Figma, Framer
- Fintech → Stripe, Coinbase

### Step 3: Fetch DESIGN.md

Design System Repo: https://github.com/olaishola05/awesome-design-md

Fetch from: `https://raw.githubusercontent.com/olaishola05/awesome-design-md/main/design-md/[company-name]/DESIGN.md`

Example for Apple:
```
https://raw.githubusercontent.com/olaishola05/awesome-design-md/main/design-md/apple/DESIGN.md
```

### Step 4: Copy to Project

Create directory and copy DESIGN.md:

```bash
mkdir -p resources/design
# Copy DESIGN.md content to resources/design/[company-name].md
```

### Step 5: Build Frontend

Using the design system, build with:
- Specified colors from DESIGN.md
- Typography rules from the design system
- Component patterns defined
- Motion/animation guidelines
- Spacing and layout principles

---

## Option 2: Create Original Design (No Design System Specified)

If no design system is specified, create distinctive designs using original principles:

### Design Thinking

Before coding, understand the context and commit to a BOLD aesthetic direction:
- **Purpose**: What problem does this interface solve? Who uses it?
- **Tone**: Pick an extreme: brutally minimal, maximalist chaos, retro-futuristic, organic/natural, luxury/refined, playful/toy-like, editorial/magazine, brutalist/raw, art deco/geometric, soft/pastel, industrial/utilitarian, etc. There are so many flavors to choose from. Use these for inspiration but design one that is true to the aesthetic direction.
- **Constraints**: Technical requirements (framework, performance, accessibility).
- **Differentiation**: What makes this UNFORGETTABLE? What's the one thing someone will remember?

**CRITICAL**: Choose a clear conceptual direction and execute it with precision. Bold maximalism and refined minimalism both work - the key is intentionality, not intensity.

Then implement working code (HTML/CSS/JS, React, Vue, etc.) that is:
- Production-grade and functional
- Visually striking and memorable
- Cohesive with a clear aesthetic point-of-view
- Meticulously refined in every detail

---

## Frontend Aesthetics Guidelines

Focus on:
- **Typography**: Choose fonts that are beautiful, unique, and interesting. Avoid generic fonts like Arial and Inter; opt instead for distinctive choices that elevate the frontend's aesthetics; unexpected, characterful font choices. Pair a distinctive display font with a refined body font.
- **Color & Theme**: Commit to a cohesive aesthetic. Use CSS variables for consistency. Dominant colors with sharp accents outperform timid, evenly-distributed palettes.
- **Motion**: Use animations for effects and micro-interactions. Prioritize CSS-only solutions for HTML. Use Motion library for React when available. Focus on high-impact moments: one well-orchestrated page load with staggered reveals (animation-delay) creates more delight than scattered micro-interactions. Use scroll-triggering and hover states that surprise.
- **Spatial Composition**: Unexpected layouts. Asymmetry. Overlap. Diagonal flow. Grid-breaking elements. Generous negative space OR controlled density.
- **Backgrounds & Visual Details**: Create atmosphere and depth rather than defaulting to solid colors. Add contextual effects and textures that match the overall aesthetic. Apply creative forms like gradient meshes, noise textures, geometric patterns, layered transparencies, dramatic shadows, decorative borders, custom cursors, and grain overlays.

NEVER use generic AI-generated aesthetics like overused font families (Inter, Roboto, Arial, system fonts), cliched color schemes (particularly purple gradients on white backgrounds), predictable layouts and component patterns, and cookie-cutter design that lacks context-specific character.

Interpret creatively and make unexpected choices that feel genuinely designed for the context. No design should be the same. Vary between light and dark themes, different fonts, different aesthetics. NEVER converge on common choices (Space Grotesk, for example) across generations.

**IMPORTANT**: Match implementation complexity to the aesthetic vision. Maximalist designs need elaborate code with extensive animations and effects. Minimalist or refined designs need restraint, precision, and careful attention to spacing, typography, and subtle details. Elegance comes from executing the vision well.

Remember: Claude is capable of extraordinary creative work. Don't hold back, show what can truly be created when thinking outside the box and committing fully to a distinctive vision.

---

## Usage Examples

### With Design System
```
User: Build a login page
Skill: Which design system? Apple, Stripe, Figma, Linear, Auto-detect?
User: Apple
Skill: *Downloads Apple DESIGN.md → Copies to ./resources/design/apple.md*
Building login page with Apple Human Interface Guidelines...
```

### Original Design
```
User: Build a login page
Skill: What aesthetic direction? Minimal, Retro-futuristic, Playful?
User: Minimal
Skill: *Creates distinctive minimal design*
Building login page with refined minimal aesthetic...
```

---

## Design System Categories

| Category | Design Systems |
|----------|----------------|
| **Premium/Enterprise** | Apple, IBM, BMW, Stripe |
| **Developer Tools** | Vercel, Linear, Cursor, Raycast, Warp |
| **Creative** | Figma, Framer, Notion |
| **Consumer** | Airbnb, Spotify, Pinterest, Uber |
| **Fintech** | Stripe, Coinbase, Wise, Revolut |
| **AI** | Claude, OpenCode, Cohere |

## File Placement

When using design system, copied DESIGN.md goes to:
```
resources/design/[company-name].md
```

Example:
```
resources/design/apple.md
resources/design/stripe.md
resources/design/figma.md
```

## Integration

This skill works with:
- `/init-frontend` - Use after initializing
- `/load-context` - Can load the copied DESIGN.md
- `create-prd` - Can reference in PRD