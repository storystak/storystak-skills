# Mockup System — Conventions for Building Page Mockups

> **Purpose:** When the user asks for a mockup, prototype, or wireframe, follow these conventions. The mockup is a visual reference that the client's design team will recreate in their actual stack (WordPress, Webflow, Framer, custom React, etc.). It is NOT production code — it's a clear, faithful representation of the intended page.
>
> **Hard rule:** A single self-contained HTML file. No build tools. No external dependencies beyond Google Fonts CDN. The file must open in any browser with zero setup, and a designer must be able to read the source comments to understand what each section is.

---

## File Output Standards

### Single File, Inline Everything

- One `.html` file. All CSS in a `<style>` block in the `<head>`. No external stylesheets, no JS frameworks, no build step.
- All images either base64-embedded OR sourced from a placeholder service (`https://placehold.co/[width]x[height]?text=[label]`) OR from the client's actual asset URLs if provided in client context
- The file should open in Chrome/Safari/Firefox with no console errors and render identically across browsers

### Naming and Location

- Save as `mockup.html` inside the page-specific subfolder per the SKILL.md folder structure
- For re-mockups: `mockup-v2.html`, `mockup-v3.html`

### File Header

Open every mockup with a comment block like:

```html
<!--
  CLIENT: [Client Name]
  PAGE: [Page Name — e.g., Cold Traffic Landing Page (T1)]
  TEMPLATE USED: [e.g., references/landing-page-templates.md → Template 1]
  CREATED: [Date]

  HANDOFF NOTES FOR DESIGN TEAM:
  - This is a visual reference, not production code
  - Brand colors: [list]
  - Brand fonts: [list]
  - Mobile breakpoint: 768px
  - Notable interactions: [any hover states, animations, sticky behaviors]
-->
```

---

## Pulling Brand Specs from Client Context

The client context's "Brand Visual System" section drives the mockup's colors, fonts, and visual style.

### Colors

Use the hex values from client context for:
- `--primary` / `--brand-color` — main brand color, used for headlines, key UI elements
- `--secondary` — supporting brand color
- `--accent` / `--cta` — CTA button color (often distinct from primary)
- `--bg` / `--background` — page background
- `--bg-alt` — section alternate background
- `--text` — body text color
- `--text-muted` — secondary text color

If the client context is missing colors, use these defaults (and note in the file header that defaults are being used):

```css
:root {
  --primary: #1A2B6C;       /* Deep navy — universally professional */
  --secondary: #6B7280;     /* Cool gray */
  --accent: #F76C00;        /* Bright orange — high-contrast CTA */
  --bg: #FFFFFF;
  --bg-alt: #F8F9FB;
  --text: #1A1A1A;
  --text-muted: #6B7280;
  --border: #E5E7EB;
  --success: #10B981;
}
```

### Fonts

Use Google Fonts via CDN:

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=[Headline+Font]:wght@400;600;700&family=[Body+Font]:wght@400;500;600&display=swap" rel="stylesheet">
```

If the client context is missing fonts, use sensible defaults (note in the file header):

- **Headline default:** `Inter` (modern), `Playfair Display` (editorial), `Libre Baskerville` (classic), or `Manrope` (premium SaaS)
- **Body default:** `Inter`, `Manrope`, or `Lato`

For most B2B and DTC contexts, `Inter` for both headline and body is a strong, neutral default that works across most brand voices.

### Logo

If the client context provides a logo URL or file path, use it directly. If not, use a text-based logo placeholder:

```html
<div class="logo">
  <span class="logo-text">[CLIENT NAME]</span>
</div>
```

### Iconography

If the client uses a specific icon library (Phosphor, Heroicons, Lucide, Tabler), reference it. If not, use inline SVG icons or emoji as visual placeholders with clear comments noting they're placeholders.

---

## Mobile-First Responsive Layout

Use CSS media queries (not Tailwind, not framework classes — keep it portable). Default approach:

```css
/* Mobile first — base styles target mobile */
.section {
  padding: 2rem 1rem;
}

/* Tablet and up */
@media (min-width: 768px) {
  .section {
    padding: 4rem 2rem;
  }
}

/* Desktop */
@media (min-width: 1024px) {
  .section {
    padding: 6rem 4rem;
  }
}
```

### Mobile Requirements

- All tap targets minimum 44px height
- Single-column layouts on mobile (no side-by-side fields, no horizontal scrolling)
- 16px minimum font size for inputs (prevents iOS zoom)
- Visible labels on form fields (not placeholder-only)
- Hero form should fit without excessive scrolling
- CTAs reachable with thumb (avoid extreme top/bottom edges)

---

## Section Comment Convention

Every major section should have a comment that maps to the template structure. This lets the designer understand "this section corresponds to [section X] in [template Y]" without reading the SKILL.md.

```html
<!-- ============================================ -->
<!-- SECTION: Hero (T1, Section 2)               -->
<!-- Purpose: Cold-traffic message-match hook     -->
<!-- Headline pulls dominant emotional lever      -->
<!-- Form: 2 fields (name + email)                -->
<!-- ============================================ -->
<section class="hero">
  ...
</section>
```

Use these section labels (vary by template):

For **single-purpose pages** (T1–T5):
- `Hero`
- `Selectivity Bar`
- `Trust Bar`
- `Pain Agitation`
- `Specificity / Math Block`
- `Founder Origin`
- `Process / Mechanism`
- `Testimonials`
- `Risk Reversal`
- `CTA Repeat`
- `Footer Disclaimer`

For **website pages** (W1–W5):
- `Header / Nav`
- `Hero`
- `Who We Help`
- `Process Brief`
- `Trust & Proof Stack`
- `Differentiators`
- `Testimonials`
- `FAQ Preview`
- `CTA Section`
- `Footer`

---

## Section Order by Page Type

### Single-Purpose Page (T1 — Cold Traffic Landing)

1. Selectivity Bar (optional, sticky top)
2. Hero (headline + sub + form + trust stat line)
3. Trust Bar (stats / badges / logos)
4. Pain Agitation (3-point structure)
5. Specificity / Math Block
6. Founder Origin (if applicable per client context)
7. Process / Named Mechanism (3-step)
8. Testimonials (2–3)
9. Risk Reversal (if applicable)
10. CTA Repeat
11. Footer Disclaimer

### Website Homepage (W1)

1. Header / Nav
2. Hero (headline + sub + primary CTA + secondary CTA + trust stat line)
3. Who We Help / Problem Recognition
4. Process / How It Works (brief)
5. Trust & Proof Stack
6. Differentiators
7. Testimonials (3–5, with diversity)
8. FAQ Preview
9. CTA Section (bottom)
10. Footer (full)

### Other website page types (W2–W5)

Follow the section order specified in `references/website-page-framework.md` for the matching template.

---

## Copy Standards Within the Mockup

- Use the actual rewritten copy from Section 3 of the audit — not lorem ipsum, not placeholder text
- All copy must pass the client's compliance Red List (per client context)
- All copy must match the client's brand voice (per client context)
- Stats and proof points must come from the client context's approved-stats list — never fabricated
- Testimonials must come from the client's actual reviews (per `references/review-selector.md`) — never placeholder

If you don't have copy for a section, either:
- Pull from the audit's Section 3 if it exists
- Mark with `[NEEDS COPY: brief description of what should go here]`
- Don't fabricate — flag it for the user

---

## Designer Handoff: What the File Communicates

The mockup serves three audiences:

### 1. The Client (Marketing / Decision-Maker)
- Visual approval: does this look like the brand? Does the structure feel right?
- Copy approval: does this match the voice? Is anything off-brand or non-compliant?
- Strategic approval: does this address the conversion goal?

### 2. The Designer (Recreating in Production Stack)
- Section comments map to template references
- CSS variables make brand colors editable in one place
- Inline styles are simple enough to translate to any CSS framework
- Comments call out interactions (hover states, sticky behaviors, animations)

### 3. The Developer (If Implementing Directly)
- Single file = portable; can be opened in any environment
- Standard HTML5 + CSS3 = no framework lock-in
- Real semantic markup (h1, section, article, nav) for accessibility and SEO

---

## Mockup Quality Checklist

Before delivering a mockup, verify:

- [ ] File header lists client, page, template used, brand specs
- [ ] All sections labeled with HTML comments mapping to template sections
- [ ] Brand colors pulled from client context (or defaults documented)
- [ ] Brand fonts pulled from client context (or defaults documented)
- [ ] Real copy from the audit's Section 3 — no lorem ipsum
- [ ] Real testimonials from the client's review source — no placeholders
- [ ] Real stats from the client context — no fabricated numbers
- [ ] Mobile-first responsive layout with 768px and 1024px breakpoints
- [ ] All tap targets ≥ 44px on mobile
- [ ] All form fields have visible labels (not placeholder-only)
- [ ] Form input font size ≥ 16px
- [ ] No console errors when opened in browser
- [ ] CTAs are visually distinct (high contrast)
- [ ] At least one trust signal appears before any form (especially mobile)
- [ ] Compliance: zero Red List violations from client context

---

## When the Client Has a Specific Stack

If the client context lists a specific stack (e.g., WordPress + Divi, Webflow, Framer, custom React + Tailwind), add a stack-specific note in the handoff comments:

### WordPress / Divi

```html
<!--
  HANDOFF: WordPress + Divi 4
  - Each major section here = one Divi Section module
  - Hero text + form = Hero Builder layout
  - Trust bar = Image module with logos in a horizontal flex
  - Testimonial cards = Blurb modules in a 3-column row
-->
```

### Webflow

```html
<!--
  HANDOFF: Webflow
  - Each major section = one Section component
  - Brand colors should map to Webflow Style Guide variables
  - Forms: use Webflow native Form Block, hook to Zapier/Webflow Logic for submissions
-->
```

### Framer

```html
<!--
  HANDOFF: Framer
  - Each major section = one Frame
  - Use Framer's component variants for responsive states
  - Animations should use Framer Motion conventions
-->
```

### Custom Code

```html
<!--
  HANDOFF: Custom React + Tailwind
  - This HTML/CSS is intentionally portable — translate inline styles to Tailwind utility classes
  - CSS variables can map directly to your tailwind.config.js theme
  - Forms should integrate with your existing form library (React Hook Form, Formik, etc.)
-->
```

---

## What NOT to Do

- ❌ Don't use external CSS frameworks (Tailwind via CDN, Bootstrap, etc.) — keep it portable
- ❌ Don't use JavaScript frameworks (React, Vue) in the mockup — pure HTML + CSS
- ❌ Don't fabricate copy, stats, or testimonials — pull from client context
- ❌ Don't add complex animations or interactions that the designer will need to recreate from scratch — keep interactions simple
- ❌ Don't omit the section comments — they're how the designer maps the mockup to the strategy
- ❌ Don't deliver a mockup that doesn't open cleanly in a browser — always test the file
- ❌ Don't use placeholder colors when the client context has real ones
