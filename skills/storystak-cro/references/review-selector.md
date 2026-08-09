# Review Selector — Testimonial & Social Proof Matching

> **Purpose:** Whenever ANY content needs social proof — landing pages, video scripts, ad copy, email sequences, sales scripts, social posts, presentations — use this protocol to select congruent reviews. Read this file before inserting any testimonial, quote, or social proof element into client content of any kind.
>
> **Hard rule:** Never use placeholder testimonials. Always pull from real reviews. If the client has no reviews available for the angle you need, say so and flag it — don't fabricate.

---

## Where Reviews Come From (Per Client)

The client context's "Reference Materials Available" section should list the source of testimonials. Common patterns:

| Source | Example | How to Use |
|---|---|---|
| **Tagged review database** | A JSON or spreadsheet with reviews tagged by emotional lever, audience segment, format, etc. | Best case. Query the database with the selection rules below. |
| **Public review sites** | Trustpilot, Google Reviews, G2, Capterra, BBB | Read directly from the source. Identify the strongest matches manually. |
| **Client website testimonials** | The reviews already published on the marketing site | Read from the live site or fetched HTML. Verify these are still approved before reusing. |
| **Sales call recordings or interview transcripts** | Customer quotes from research calls | Pull verbatim quotes; cite as "[Customer Name], [Role / Company]" with permission. |
| **None available** | New client, early-stage product, or pre-launch | Flag this explicitly. Recommend the client gather reviews before scaling pages that depend on social proof. |

If the client context doesn't tell you where reviews live, ask before pulling testimonials.

---

## Selection Rules (Universal)

### Rule 1: Only Use Positive Reviews
Filter out negative reviews, mixed reviews, and competitor-failure reviews from any customer-facing content. Negative reviews may be useful for objection-handling research or product-team feedback, but they don't go on conversion pages.

### Rule 2: Match Emotional Lever to Page Angle
The review's emotional lever should match the page's primary lever. If the page is about "deception," pull deception-focused reviews. If the page is about "time waste," pull time-saving testimonials.

If the client has a tagged database with `emotional_lever` fields, filter on those. If not, identify the emotional lever of each review by reading the language:

| Page Angle | Look for Reviews Where the Customer… |
|---|---|
| Deception / "you were lied to" | Talks about being misled, frustrated, or vindicated |
| Hidden cost / financial pain | Mentions specific dollar savings or cost recovery |
| Trapped / no way out | Talks about being stuck for years before finding the solution |
| Time waste | Mentions specific time savings or "got my time back" |
| Inheritance / family burden | Mentions family, kids, legacy, or future generations |
| Selectivity / qualification | Talks about being approved, accepted, or qualifying |
| Done-for-you / ease | Talks about how little they had to do |
| Health / vitality | Mentions energy, sleep, mood, or physical change |
| Status / identity | Mentions becoming a different version of themselves |

If exact match yields fewer than 3 results, expand to related levers:
- Deception → also try Trapped, Hidden Cost
- Hidden Cost → also try Trapped, Time Waste
- Inheritance → also try Trapped, Hidden Cost

### Rule 3: Match Funnel Stage to Traffic Temperature
Cold-traffic visitors need different testimonials than hot-traffic visitors. Cold visitors need to see "I was skeptical and it worked." Hot visitors need to see "this delivered the specific outcome I wanted."

| Traffic Temperature | Best Review Types |
|---|---|
| Cold (paid social, display) | Skepticism overcome, transformation, surprised-by-results |
| Warm (email, retargeting) | Specific outcome, vindication, comparison-validation |
| Hot (direct, brand search) | Detailed outcome, specific named-staff stories, ongoing-relationship reviews |

### Rule 4: Match Format to Placement
Different page placements need different review formats.

| Where on the Page | Preferred Format |
|---|---|
| Hero section / inline with CTA | **Short punchy** — 1 sentence, high impact |
| Trust bar | **Star rating + count** — visual proof, not a quote |
| Dedicated testimonial section | **Medium narrative** — 2–4 sentences with arc |
| Full case study block | **Long story** — 4+ sentences with named outcomes |
| Social proof bar / scrolling marquee | **Short punchy** with attribution |
| Video module | **Video testimonial** if available, otherwise medium narrative |

### Rule 5: Audience Segment Matching (When Known)
If the page targets a specific audience segment (e.g., enterprise B2B, first-time buyers, a specific industry vertical), prefer reviews from customers in that segment.

But: **never expose customer details that violate the client's compliance rules** (e.g., naming a competitor that the client can't legally name in their own copy). Filter for relevance, then strip per the client's Red List.

### Rule 6: Diversity in Selection
When selecting 3+ reviews for a page, aim for diversity across:

- Different reviewer names (no duplicates)
- Mix of emotional moments / types
- Mix of attribution levels (named customer, role only, anonymous initial)
- Mix of review sources where possible (Google + G2 + direct customer interview)
- Mix of formats (one short, two medium, or one short + one long)

### Rule 7: Specificity Beats Polish
A real, slightly-rough customer quote with specific numbers or named outcomes will outperform a polished, generic testimonial every time.

**Strong:** "I was spending six hours every Friday reconciling invoices by hand. Now it's twenty minutes on Monday and I haven't thought about it since."

**Weak:** "The team provided excellent service and I would highly recommend them to anyone."

When choosing between two reviews, pick the more specific one — even if the language is less polished.

---

## How to Query (Step by Step)

### When the Client Has a Tagged Database

1. **Read the database file** (path from client context)
2. **Determine your filters from the page context:**
   - Primary emotional lever
   - Traffic temperature
   - Content type (landing page, ad, email, etc.)
   - Audience segment (if known)
   - How many reviews + what formats
3. **Filter in priority order:**
   - Positive reviews only (mandatory)
   - Emotional lever matches page angle (strong preference)
   - Funnel stage matches traffic temperature (preference)
   - Best output type includes your content format (preference)
   - Format fit matches placement (preference)
   - Audience segment matches target (nice to have)
4. **From the filtered set, select for diversity** (Rule 6)
5. **Use the database's excerpt field as the displayed quote.** Use the tagged hook as a section label or headline. Use reviewer name + source for attribution.

### When the Client Has Public Reviews (Trustpilot, G2, Google)

1. **Fetch the reviews** (via WebFetch or by asking the user to paste them)
2. **Read 30–50 reviews** to get a feel for the customer voice and common themes
3. **Identify 5–10 candidate reviews** that match the page angle
4. **Select 2–3 final reviews** applying the diversity rule
5. **Write attribution as:** [First Name + Last Initial], verified [source] review

### When the Client Has Customer Interview Transcripts

1. **Read transcripts**
2. **Pull verbatim quotes** that match the page angle
3. **Confirm with the client that the customer has given permission** to use the quote with attribution
4. **Format as:** [Customer Name], [Role / Company]

### When the Client Has No Reviews

1. **Don't fabricate.** Period.
2. **Tell the user the page can't have testimonials yet.**
3. **Suggest alternatives:**
   - Founder credibility statement instead of customer testimonial
   - Customer logo bar (if any logos exist)
   - Press / media mentions
   - Aggregate stats from internal data (if approved)
   - Industry data / third-party research
4. **Recommend the client gather reviews before scaling pages that depend on social proof.**

---

## Output Format by Content Type

### Landing Page / Mockup HTML

```html
<!-- TESTIMONIAL: [section label] -->
<blockquote class="testimonial">
  <p class="testimonial-quote">"[excerpt]"</p>
  <cite class="testimonial-attribution">— [reviewer name], verified [source] review</cite>
</blockquote>
```

### Audit Report Copy

> **[Section label / hook]**
> "[excerpt]"
> — [Reviewer name], [source]

### Video Script

```
[SUPER]: "[excerpt]"
         — [reviewer name]
```

Or as a voiceover beat:
```
VO: One customer told us... "[excerpt]"
```

For longer customer story segments, use medium-narrative or long-story format reviews.

### Ad Copy (Meta, Google, LinkedIn)

Short format — use excerpt directly:
```
"[excerpt]"
— [Reviewer name], verified review
```

For headlines, the section-label / hook of a review can inspire ad-headline language (rewrite into ad-appropriate copy).

### Email Sequence

Use as a proof block within the email body:
```
---
"[excerpt]"
— [reviewer name], [source]
---
```

For email subject lines, the review's most striking phrase can inspire curiosity-driven openers.

### Sales Script / Talk Track

Frame as a story the rep can tell:
```
REP: "One of our customers, [reviewer name], said it best — '[excerpt]'"
```

For objection handling, find reviews where a customer had the same concern and still moved forward. Filter for objection-handling tags if the database has them; otherwise, read manually.

### Social Media (Organic)

Use short-format reviews with the excerpt as the post body. Add a section label as a bold opener.

```
[Hook line — rewritten as attention-grabbing opener]

"[excerpt]"
— [reviewer name]

[CTA]
```

### Presentations / Decks

Use the section label as the slide headline. Excerpt as the pull quote. Reviewer name + source as attribution. For a case study slide, use the full review text with a long-story format review.

---

## Compliance Checklist (Before Inserting Any Review)

Before inserting any testimonial into customer-facing content, run through this list per the client's Red List:

1. **Strip restricted competitor names** (replace with generic noun: "the alternative," "the legacy approach," "the previous solution")
2. **Strip restricted regulatory language** (e.g., "lawsuit," "guaranteed," whatever the client context flags)
3. **Strip restricted superlatives** if the client's compliance restricts them
4. **Verify any specific claims in the review are still accurate** (a 2019 review claiming "$5M saved" may need updating if the current claim is "$10M saved")
5. **Do NOT alter the reviewer's words beyond compliance redactions** — the excerpt must remain as close to verbatim as possible
6. **If the excerpt requires heavy redaction that changes its meaning, select a different review**

---

## Quick Selection Shortcuts

- **Hero section, short and punchy:** Filter for short-format + hot-decision funnel stage + positive
- **Skepticism-overcome testimonial (for vetting visitors):** Filter for "I was skeptical, but..." or "didn't believe it would work" language
- **Specific-outcome testimonial (for trust-pages):** Filter for named-staff attribution + specific quantified outcome
- **Long case study (for dedicated testimonial pages):** Filter for long-format + named customer + specific outcome
- **Objection-handler testimonial (for objection sections):** Find reviews where the customer mentions the specific objection ("I thought it would take too long, but...") and still converted

---

## Universal Integration — All Skills & Tasks

This protocol isn't CRO-specific. Any task that produces customer-facing content with social proof should use this selector:

| Task Type | When to Use |
|---|---|
| **Landing page audit / mockup** | Populating testimonials in mockups and rewrites |
| **Ad creative** | Adding proof quotes to Meta, Google, LinkedIn ads |
| **Video scripts** | Selecting customer stories for on-screen supers, voiceover beats, full segments |
| **Email sequences** | Inserting proof blocks, subject line inspiration, case study content |
| **Sales scripts / talk tracks** | Arming reps with real customer quotes matched to specific objections |
| **Social media posts** | Pulling short, punchy quotes for organic content |
| **Presentations / decks** | Building case study slides or proof-stack slides |
| **Blog posts / articles** | Embedding real testimonials as supporting evidence |
| **Copywriting (any page)** | Anytime a section calls for social proof |

### Proactive Review Suggestion

When reviewing or writing ANY content that contains a social proof section (or should contain one), proactively:

1. Read the surrounding copy to identify the emotional lever and audience
2. Query the available review source for matching reviews
3. Suggest 2–3 options with the section label, excerpt, and reviewer name
4. Let the user choose or ask you to insert the best fit

This applies even when the user doesn't explicitly ask for reviews — if the content calls for social proof, offer it.
