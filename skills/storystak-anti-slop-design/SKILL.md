---
name: storystak-anti-slop-design
description: An anti-slop design discipline for any frontend or UI build, ensuring output does not converge on the generic AI-default aesthetic (lavender-purple, Inter, centered hero with badge, colored-left-border cards, glassmorphism, nested cards, decorative motion, etc.). Use this skill for ANY task that produces visual UI, including landing pages, web apps, dashboards, components, tools, calculators, embeds, mockups, or redesigns, whether building from scratch or modifying existing code. Trigger it automatically alongside any build, even when the user does not mention slop or design quality, because the whole point is that this discipline applies by default. Especially trigger before generating UI (to set pre-generation constraints) and before shipping UI (to run the audit).
metadata:
  version: 1.0.0
---

# Anti-Slop Design

A discipline for producing UI that reads as deliberately designed rather than machine-generated. The goal is not to avoid AI tools. It is to avoid the *default* aesthetic those tools reach for when given no opinion.

This matters for a specific reason. An unprompted model interpolates toward the most probable output, and the most probable output is the average of its training data. That average has a recognizable look now, and people have learned to spot it. Slop pages still convert fine. The cost is differentiation: when most new launches look like siblings, blending in is the real price, not low conversion.

The operating rule: ship something with one strong opinion on purpose, never ship the generic median by accident.

**Build mechanics this skill assumes.** Several tells die at the level of build convention rather than aesthetic judgment, and they are worth settling before you reach for anything here: a real icon library instead of emoji (Phosphor, Lucide, Heroicons — one library per surface, never mixed), a deliberately chosen typeface that is not Inter or Roboto, and one source of truth for color tokens rather than hex values scattered through the markup. This skill assumes those are handled and covers what they do not: reference sourcing, pre-generation constraints, and the pre-ship audit. Where a project carries its own build standard, that standard owns the mechanic and this skill owns the "avoid the tell" reasoning — they should agree, not overlap.

Note on em dashes: heavy em-dash use is itself a recognized tell in published copy, so if a project bans them in shipped output — builds, marketing copy, PDFs, emails — that ban applies there and not here. This file is working reference, not shipped output. Don't strip em dashes from documents like this one on the strength of a rule meant for the other kind.

---

## Step 0: Source a reference before generating anything

The highest-leverage move against slop happens before a line of code. A concrete reference gives the model a specific target to move toward instead of the training-data average. Do this first, every time a build has any visual ambition.

The sequence:

1. **Pick a deliberate style, not "a website."** Commit to a point of view up front: editorial, brutalist, retro, luxury, industrial, maximalist, refined-minimal. Browse a gallery filtered to that style rather than a generic feed.
2. **Pull the actual screenshot. Do not trust the metadata.** A listing's tags will say "beige, editorial, serif" and miss that the real page uses an orange CTA and an overlapping-headline technique. The pixels carry information the tags do not. Fetch the image and look at it before deciding anything.
3. **Extract the DNA in one or two sentences.** Name what actually creates the character: the type pairing, the one accent color, the layout primitive, the structural trick. The distinctiveness usually lives in layout and type pairing, not in an exotic body font. (Even award-winning editorial pages often set body copy in Inter; the feel comes from the display face and the column structure.)
4. **Translate, do not copy.** Ask what the reference's structure would mean for *this* brand, then make a deliberate move. The reference informs the bones; the brand drives the skin. Copying produces a different generic. Translating produces something that belongs to the project.
5. **Feed the reference into the build as the explicit target,** then run the audit below on the output.

### Where to source (prefer shipped work over concept work)

Shipped-work galleries have survived real constraints. Concept galleries optimize for looking good in a grid thumbnail, which is part of how the monoculture spreads. Reach for the first group; use the second only for a spark.

**Shipped work (preferred):**
- **One Page Love** (onepagelove.com) — full single-page marketing sites, curated, filterable by deliberate style. Best for landing pages and editorial concepts. Shows whole-page composition.
- **Mobbin** (mobbin.com) — the largest library of real, shipped app and web product screens plus full user flows. Best for actual product UI: dashboards, onboarding, settings, tools. It offers an **MCP server** (launched May 2026) that connects the reference library straight into Claude Code and similar, so sourcing can happen inside the build loop instead of by manual fetch. Worth wiring in. Most content is paywalled; search can be imprecise.
- **Siteinspire** — tightly curated, minimal-leaning marketing and agency sites.
- **Refero** — real-world web references, a close One Page Love cousin.
- **Pageflows** — real product flows as video (signup, checkout, cancellation). The motion-and-sequence layer the static galleries miss.

**Concept work (use sparingly, slop risk):**
- **Awwwards** — award-tier, high craft, but skews maximalist and animation-heavy.
- **Dribbble / Behance** — concept and portfolio work, much of it unbuilt. A known *source* of the slop aesthetic precisely because it optimizes for the grid thumbnail. Good for a spark, risky as a build target.

---

## Pre-generation constraints (set these before building, not after)

Stating what to avoid up front measurably reduces slop, because negation works at inference time. Before generating any UI, lock these three:

1. **Palette with a point of view.** Pick a real brand palette or a deliberate direction (warm earth tones, high-contrast black plus one bright accent, cream-and-pink, ink-and-oxblood). Explicitly not the default lavender-purple. Cream and beige now carry the same risk lavender does, so they have to pass the provenance test in the Color refinements below: the palette must be able to name why it is beige.
2. **Type system that is not Inter or Roboto.** A deliberate display face paired with a clean body face, chosen before you generate rather than swapped in afterward. Two families is the working maximum; a third is almost always a symptom of indecision rather than a design choice.
3. **One layout primitive, repeated.** Choose a single structural idea and let it become the signature, instead of stacking seven different card styles, stat banners, and step sequences on one page. This is the single highest-leverage positive move.

---

## The audit (run before every ship)

Two tiers. **Tier 1 is the instrument.** Sixteen high-signal tells, each one of which reads as machine-generated on its own. Triggering five or more puts a page in "heavy slop" territory. Aim for zero or one. Roughly two-thirds of new launches trigger several, so passing Tier 1 is itself differentiation.

**Tier 2 is refinement.** Seventeen items that separate competent from crafted. They do **not** count toward the Tier 1 threshold, and that separation is deliberate: letting a crushed-letter-spacing hit score the same as a colored-left-border blunts the instrument. Treat six or more Tier 2 hits as a signal that the page needs a real design pass even when Tier 1 is clean.

Tier 2 is derived from Impeccable (impeccable.dev), a 59-rule deterministic detector by Paul Bakaus. Adopted with the three carve-outs documented after the checklist.

### Tier 1: the sixteen core tells

**Typography**
- [ ] Headline is **not** set in Inter, and not a centered Inter hero.
- [ ] No "one fancy accent word" trick (a lone Space Grotesk / Instrument Serif / Geist italic word dropped into an otherwise plain page).

**Color**
- [ ] No "VibeCode Purple" lavender accent unless the brand actually owns purple.
- [ ] Not defaulting to permanent dark mode with medium-grey body text and all-caps section labels.
- [ ] Body text passes WCAG AA contrast. Generated dark themes routinely fail this; check it.
- [ ] Gradients are a deliberate brand choice, not sprayed across hero, buttons, and backgrounds.
- [ ] No large colored glows or colored box-shadows used as default decoration.

**Layout**
- [ ] Hero is not the generic centered-sans-with-badge-above-the-H1 pattern.
- [ ] **No colored left or top borders on cards.** This is the single most reliable tell, the exact thing in the widely-shared "if we see this, we know" screenshot.
- [ ] Feature cards are not all identical with an icon stacked on top.
- [ ] No default "1, 2, 3" numbered step row unless the content genuinely needs sequence.
- [ ] No filler stat-banner row of round numbers.
- [ ] Nav and sidebar use a real icon set (Phosphor per build standard), never emoji.
- [ ] All-caps headings and section labels are a real type-scale decision, not a reflex.

**Underlying CSS**
- [ ] shadcn/ui defaults are customized (color tokens, border radius, shadow depth, non-default variants), not shipped raw. shadcn is built to be copy-pasted by AI agents, so untouched defaults are themselves a tell.
- [ ] Glassmorphism (frosted-glass cards) is a deliberate choice, not the fallback treatment.

### Tier 2: the seventeen refinements

**Typography**
- [ ] Type hierarchy is not flat. Distinct steps between H1, H2, H3, and body with a real ratio between them. Generated pages ship four heading levels within a few pixels of each other, which reads as undesigned even when each individual choice is fine.
- [ ] No crushed letter spacing on display type. Negative tracking is a deliberate move at one specific size, not a global default.
- [ ] Functional text (labels, captions, metadata, table headers, form hints) is not undersized into illegibility. Small is a hierarchy decision; 10px grey is an accident.
- [ ] Hero headline is not absurdly oversized relative to the rest of the page. A 96px H1 above 14px body is a ransom note, not a scale.

**Color**
- [ ] No grey text on a colored or tinted background. Grey is calibrated against white; on a colored surface it goes muddy and usually fails contrast too.
- [ ] Cream and beige pass the **provenance test**. "AI beige" is now its own default, the warm-neutral equivalent of lavender. The rule is not a ban, it is a question of origin: cream that exists in the brand's token set passes (Snow `#FCF7F5` on Powder Petal `#F7E3DA` is a palette decision, not a fallback), cream the model reached for because it needed a background fails. If the palette cannot name why it is beige, it is slop.

**Layout**
- [ ] No nested cards. A bordered box inside a bordered box inside a section is the most common generated-layout failure. One level of containment; whitespace does the rest.
- [ ] Spacing is semantic, not monotonous. Gaps have to encode grouping and separation. If every gap is the same value, nothing groups and nothing separates. (Scoped to spatial hierarchy within a composition. This is *not* a rule against repeating a layout primitive; see the carve-outs.)
- [ ] Line length capped for reading, roughly 60–75 characters. Full-width body copy on a wide viewport is a tell and a legibility failure at once.

**Visual details**
- [ ] No decorative grid-line or graph-paper background as texture. Signals "technical" without meaning anything.
- [ ] Border radius is a considered value, not an extreme. Commit to a radius scale in the tokens.
- [ ] No amateurish hand-drawn SVG or shape-assembled illustration (a "person" from three rounded rectangles and a circle). Real illustration, a considered icon set, or nothing. Nothing beats bad.

**Motion**

Section rule: **motion conveys state, or it does not ship.**

- [ ] No pulsing status dot unless something is genuinely live and the pulse carries that meaning.
- [ ] No decorative blinking cursor. A terminal cursor in a hero is a costume, not an affordance.
- [ ] No auto-scrolling marquee for logos or testimonials. Removes the reader's control, tell on sight.
- [ ] No bounce or elastic easing. Overshoot on a UI transition reads as a toy. Standard ease-out.
- [ ] No animating layout properties (`width`, `height`, `top`, `left`, `margin`). Transform and opacity only, or it janks on the devices clients test on.

---

## Carve-outs: what this skill does not adopt

Three deliberate departures from Impeccable's rule set.

**1. Defect and accessibility rules are delegated, not transcribed.** Roughly 25 of their rules are rendering bugs rather than taste calls: occluded text, overflow clipping, skipped heading levels, justified text, tight line height. Prose in a skill file is the wrong instrument for those. They want a checker that exits non-zero. Run the Impeccable CLI or browser extension for that layer (`npx impeccable install`) — the deterministic rules run with no LLM and no API key, so it is cheap to wire into a build step. One line pointing at the detector beats 25 checkboxes that dilute the audit.

Note: Impeccable's own docs warn that running their *skill* alongside another design skill makes the two vocabularies collide and cancel out. That warning is about the skill layer, not the detector. The division of labor here: their detector owns mechanical defect detection, this skill owns brand-specific methodology and taste. Do not install their skill on top of this one.

**2. Their "identical card grids" rule is suppressed on our work.** A repeated layout primitive is the whole positive thesis of this skill. A detector cannot distinguish a primitive repeated on purpose from sameness that came from nowhere, so it flags the discipline as the defect. The Tier 1 card rule is narrower and stays: what fails is the *icon-stacked-on-top feature card*, not repetition itself.

**3. Their "monotonous spacing" rule is adopted only in its semantic form.** The legitimate version is about spatial hierarchy: gaps must group and separate. The illegitimate version penalizes consistent rhythm, which is the same suppression as above. Judge whether the spacing *encodes structure*, not whether the values repeat.

---

## What the clean third actually do

The pages that read as designed rather than generated share three disciplines. Treat these as the positive version of the audit:

1. **A palette that is not the LLM default.** Anything with a point of view beats lavender (and now beats beige).
2. **A type system that is not Inter.** A deliberate pairing wakes the page up.
3. **One strong layout primitive, repeated** until it becomes the visual signature.

The framing that matters: slop is not bad, just uninspired. A page with one strong opinion beats a generic one with none. When resources are tight, ship something a little rough on purpose rather than something generic by accident.

---

## How to apply this in a build

- **At the start of a build:** run Step 0 (source a reference) and lock the three pre-generation constraints. State them back before writing code.
- **While building:** keep the one-layout-primitive discipline. Resist adding a second card style or a stat banner just to fill space.
- **Before shipping:** run Tier 1. If five or more fire, the build needs a stronger point of view, not more polish. Then run Tier 2; six or more means it needs a craft pass. Tier 2 hits never promote into the Tier 1 count.
- **For defect and a11y coverage:** run the Impeccable detector rather than eyeballing it. Different instrument, different job.
- **When the user pushes for speed:** the audit is fast, and the sourcing step is the part that saves time later, because a clear reference prevents the generic-first-draft-then-rework loop. Do not skip Step 0 to "save time."
