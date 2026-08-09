# Discovery from URL — Deriving Client Context When No Context File Exists

> **Purpose:** When the user pastes a URL and there's no `client-context.md` to load, follow this protocol. You'll fetch the right pages, extract what you need, and produce a *provisional* client-context that the user can confirm or correct before any audit work begins.
>
> **Hard rule:** Never silently audit a page based on URL-only context. Always present the derived context for confirmation first. Audits built on guessed context produce bad recommendations.

---

## When to Use This Protocol

- User drops a URL with no client folder mounted
- User says "audit [domain]" with no setup
- User says "build a landing page for this client" and points at their site

If the user has already mounted a client folder with `client-context.md`, do NOT run this protocol — use the file.

---

## The Discovery Sequence

### Step 1: Fetch the Provided URL

Use WebFetch on the URL the user provided. Extract:
- The page's headline, sub-headline, and primary CTA
- The page's purpose (homepage, pricing, demo request, advertorial, etc.)
- The brand name and any visible tagline
- The primary domain (you'll need it for the next steps)

If WebFetch fails or returns thin content, ask the user for a screenshot of the page or pasted copy before proceeding.

### Step 2: Map the Site Structure

From the navigation visible on the provided URL, identify which discovery pages exist. Look for these common page types and queue the ones present:

| Page Type | URL Pattern Examples | What You'll Extract |
|---|---|---|
| Homepage | `/`, `/home` | Brand voice, primary positioning, primary CTA |
| About | `/about`, `/our-story`, `/who-we-are` | Founder story, company history, mission, scale |
| Process / How It Works | `/how-it-works`, `/process`, `/our-process` | The named mechanism, expected timeline, what the customer does |
| Pricing | `/pricing`, `/plans` | Price model, tiers, friction reducers |
| Reviews / Testimonials | `/reviews`, `/testimonials`, `/customers`, `/case-studies` | Social proof volume, common emotional moments, named customer outcomes |
| FAQ | `/faq`, `/questions`, `/help` | Common objections, compliance language patterns |
| Contact / Demo | `/contact`, `/demo`, `/get-started` | Form structure, conversion path |
| Footer | (every page) | Legal entity, disclaimers, compliance footnotes, social profiles |

### Step 3: Fetch Discovery Pages (Prioritized)

Fetch in this order, stopping when you have enough to fill the context. Each WebFetch costs time and tokens — don't fetch all of them if the first 3 give you what you need.

1. **Homepage** — anchor for voice and positioning
2. **About / Our Story** — founder story, company scale, mission
3. **Pricing** — offer mechanics, price model, friction reducers
4. **Reviews / Customers** — proof volume, audience segments, common outcomes
5. **FAQ** — objection patterns, compliance phrasing
6. **Footer (any page)** — legal name, disclaimers

If the site has a Process / How It Works page, add it after About — it tells you the named mechanism and expected timeline.

### Step 4: Skim Public Sources for the Rest

Some context fields can't be derived from the marketing site. If they're load-bearing for the audit you've been asked to do, ask the user. Don't guess.

| Context Field | Can You Derive It from the Site? | If Not, Ask |
|---|---|---|
| Identity, brand name, domain | ✅ Yes | — |
| Industry, what they sell | ✅ Yes | — |
| Stage / size | ⚠️ Sometimes (footer, About, "trusted by") | Ask if it matters for the audit |
| Audience demographics | ⚠️ Inferable from positioning | Confirm with user |
| Audience reading level | ⚠️ Inferable from current copy complexity | Confirm with user |
| Brand voice pillars | ✅ Yes (read 2–3 pages) | — |
| Visual system (colors, fonts) | ✅ Yes (inspect rendered page) | — |
| Approved stats | ✅ Pull what's currently on the site | Flag as "current site claims" — confirm before reusing |
| Compliance / Red List | ❌ Usually NOT derivable | **Always ask** — this is the highest-risk field to guess |
| Emotional levers | ⚠️ Hypothesize from current copy | Flag as untested hypothesis |
| Founder story | ✅ From About page if present | — |
| Funnel mechanics | ⚠️ Partially (form + thank-you path) | Ask about post-conversion |
| Competitors | ⚠️ Sometimes (comparison pages, "vs." pages) | Ask user to confirm/expand |
| Active campaigns | ❌ Usually NOT visible | Ask if relevant |

### Step 5: Produce the Provisional Context

Output the derived context using the structure from `references/client-context-template.md`. For each field:

- **Filled with high confidence:** state it plainly
- **Filled with inference:** prefix with "INFERRED — please confirm:"
- **Could not derive:** prefix with "MISSING — needs user input:" and list the question to ask
- **Required for audit but missing:** flag explicitly as a blocker

### Step 6: Present and Confirm

Show the user the provisional context as a single message. Format:

```
I've pulled what I could from [domain]. Here's the provisional context — please confirm or correct before I audit:

[Identity section]
[Audience section]
[Voice section — with example sentences from their current site]
[Visual system]
[Stats — flagged as "currently on the site, please confirm these are still approved"]
[Compliance — flagged: "I couldn't derive your Red List from the site. Are there words, claims, competitor names, or guarantee language you can't use? Industry regulators? Internal brand rules?"]
[Emotional levers — flagged as hypotheses based on current copy]
[Anything else missing]

Confirm or correct, and I'll proceed with the audit. If you want to save this as a permanent client-context.md, say "save context" and I'll write it to the working folder.
```

### Step 7: Save (When Confirmed)

If the user confirms and asks to save the context, write `client-context.md` to the working folder root (or `.cro/client-context.md` if a `.cro/` folder convention is preferred). Replace all "INFERRED" prefixes with the confirmed values; remove all "MISSING" placeholders that have been answered.

---

## Inference Heuristics (Use These When Deriving)

### Brand Voice
Read 2–3 pages and look for these signals:

| If you see... | Voice pillar candidate |
|---|---|
| Contractions, sentence fragments, conversational openers | Genuine, approachable |
| Specific numbers, named outcomes, no fluff | Direct, honest |
| "We understand," empathy framing, "you're not alone" | Heartfelt, empathetic |
| Confident superlatives, bold claims, big-vision language | Confident, ambitious |
| Technical terms, precise language, specs over outcomes | Technical, no-nonsense |
| Wordplay, jokes, unexpected metaphors | Playful, irreverent |
| Long sentences, multi-clause structure, formal vocabulary | Authoritative, expert |
| Industry jargon used as shorthand | Insider, peer-to-peer |

Pick 2–3 that match. Always show the user 1–2 example sentences from their site that triggered each pick — proves you're reading their actual voice, not assuming.

### Reading Level
Run the page text through a Flesch-Kincaid mental estimate:
- Short sentences (under 15 words), 1–2 syllable words → 6th–8th grade
- Mixed sentence length, some 3+ syllable words → 9th–11th grade
- Long sentences, technical vocabulary → 12th+ grade

Match the audience to the current copy unless the audience is clearly mismatched (e.g., 7th-grade audience reading 12th-grade copy = the page already has a problem).

### Visual System
Inspect the rendered page or fetched HTML for:
- Most-used hex values (primary, secondary, background)
- `<link>` tags for Google Fonts → headline + body fonts
- Image style (photography vs. illustration vs. iconography)
- CTA button color (often distinct from primary brand color)

If the site uses CSS variables (`--brand-primary: #...`) those are the highest-confidence source.

### Emotional Levers (Hypothesize, Don't Conclude)
Read the homepage hero + 2–3 marketing pages. Note:
- What pain is being agitated?
- What outcome is being promised?
- What objections are being pre-addressed?
- What's the implied villain (the status quo, the legacy alternative, the competitor approach)?

Output 2–3 hypothesized levers based on what the current copy emphasizes. Always flag as **hypothesis** — the lever the site uses today is not necessarily the one that converts best. Real emotional-lever validation requires audience research, ad performance data, or testing.

### Compliance Restrictions (Almost Always Ask)
Compliance restrictions almost never appear on the marketing site itself — they appear in legal docs, internal brand guides, and "things our lawyer caught us doing." Only derive these if:
- Footer disclaimers reveal a regulator (FDA, FTC, FINRA, state bar, NMLS)
- The site has an obvious "Important Disclosures" page
- The industry has well-known restrictions you're confident about (e.g., supplements can't claim "cure," law firms have state bar rules, financial advisors have SEC marketing rules)

Even when you can derive a likely restriction, **always ask the user to confirm** before producing copy that depends on it.

---

## Vertical Quick-Diagnose

If the URL's vertical is obvious, cross-reference `references/industry-pattern-library.md` for vertical-specific patterns (typical awareness levels, dominant levers, common compliance traps). Use that as additional input to your hypotheses, not as a replacement for actual reading of the site.

---

## What NOT to Do

- ❌ **Don't fabricate stats.** If the site doesn't show "12,500 customers," don't write "trusted by thousands."
- ❌ **Don't invent founder stories.** If About is generic, leave the founder section blank and ask.
- ❌ **Don't guess compliance restrictions.** Ask.
- ❌ **Don't proceed to audit before confirmation.** Always show the provisional context first.
- ❌ **Don't fetch every page on the site.** 3–5 well-chosen pages is enough.
- ❌ **Don't claim the derived context is authoritative.** It's a starting hypothesis, surfaced for the user's confirmation.

---

## Example Output

> I've pulled what I could from `acme-fintech.com`. Here's the provisional context — please confirm or correct before I audit:
>
> **Identity**
> - Client: Acme Fintech
> - Industry: B2B SaaS — accounts payable automation
> - What they sell: Software that automates invoice processing for finance teams at mid-market companies
> - Stage / size: INFERRED from "trusted by 500+ finance teams" — appears mid-stage, post-Series A. Confirm?
>
> **Audience** (INFERRED — please confirm)
> - Buyer: Controllers and CFOs at companies with 100–1,000 employees
> - Reading level: 9th–10th grade (current site copy reads at this level)
> - Awareness when hitting cold paid: Problem Aware (they know AP is painful, comparing solutions)
>
> **Voice** (read from /home, /pricing, /how-it-works)
> - Pillar 1: **Confident, no-nonsense** — "Stop chasing approvals" (homepage hero) is direct, action-led
> - Pillar 2: **Outcome-led** — "Cut invoice processing time 80%" (specific number, immediate benefit)
> - Pillar 3: **Peer-to-peer** — uses "your AP team" language, not "users" or "customers"
>
> **Visual System** (extracted from rendered page)
> - Primary: `#1A2B6C` (deep navy)
> - Accent / CTA: `#F76C00` (bright orange)
> - Headline font: Inter
> - Body font: Inter
>
> **Stats currently on the site** (please confirm these are still approved)
> - 500+ finance teams
> - 80% time savings
> - 4.7/5 G2 rating
> - $2B in invoices processed
>
> **Compliance — MISSING:** I couldn't derive a Red List from your marketing site. A few questions:
> 1. Can you name competitors directly in copy? (Bill.com, Tipalti, etc.)
> 2. Are there guarantee or ROI claims your legal team has restricted?
> 3. Industry-specific rules I should know about (SOC 2 claims, security certifications, etc.)?
>
> **Emotional Levers** (hypothesis — flag as untested)
> 1. Time waste / inefficiency (current site leads here)
> 2. Risk reduction / compliance (G2 and SOC 2 mentions throughout)
> 3. Team morale / "your AP team will thank you" (mentioned in 2 places)
>
> **Founder Story:** Not present on `/about`. Skip or ask?
>
> Confirm or correct, and I'll move to the audit. Want me to save this as `client-context.md` in the current folder?
