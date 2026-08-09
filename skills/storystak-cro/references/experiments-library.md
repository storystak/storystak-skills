# Experiments Library — A/B Test Patterns

> **Purpose:** When recommending tests for a client's pages, draw from this library and adapt to the client context. Every test pattern here is grounded in CRO best practice and works across most verticals — but the *specific hypothesis* for any given test needs to be matched to the client's audience, traffic source, and current conversion bottleneck.
>
> **Hard rule:** Don't recommend a test without also stating the expected mechanism (why you think this will move the needle) and the minimum sample size needed to call it. "Run an A/B test" without that grounding is a waste of the client's traffic.

---

## How to Use This Library

1. **Identify the conversion bottleneck.** Look at the audit scorecard: what's the lowest-scoring criterion? That's where to test.
2. **Find the matching test patterns below.**
3. **Adapt the hypothesis to the client.** Pull specific copy candidates from the client context.
4. **Estimate sample size.** Most tests need 100+ conversions per variant for meaningful results.
5. **Define what you're measuring.** Primary metric (the conversion event) + secondary metrics (proxy signals).

---

## Tier 1: High-Impact Tests (Run These First)

These typically produce the largest lifts — focus here when you're starting from scratch or stuck.

### Hero Section Tests

| Test | Hypothesis Pattern | When to Run |
|---|---|---|
| **Pain-point headline vs. outcome headline** | Pain-driven hooks ("Stop X") vs. outcome hooks ("Get Y") test which lever resonates more for this audience | When the current headline is generic or you have no validation data on lever choice |
| **Specific number vs. vague claim** | "$1,480 a year" vs. "rising fees" — specific numbers outperform vague claims in nearly every test | When the current copy uses qualifiers like "many," "high," "rising," "expensive" |
| **Headline length: long descriptive vs. short punchy** | Short = fast comprehension; long = more pre-qualification | When traffic is high and you can split-test fast; default to short for cold |
| **Sub-headline: pain vs. proof** | Sub agitates pain vs. sub stacks proof — depends on whether trust or motivation is the bottleneck | When the headline is locked but you want to test the supporting line |
| **Hero image: founder vs. customer vs. product** | Each signals a different trust source | When the hero has an image at all — and the current image isn't tested |

### Form Tests

| Test | Hypothesis Pattern | When to Run |
|---|---|---|
| **Field count: 2 vs. 3 vs. 5** | Each additional field reduces completion 10–25% — but the right field can improve lead quality | When sales is asking for more fields; settle the debate with data |
| **Single-step vs. multi-step (quiz)** | Multi-step uses progressive commitment; single-step removes intermediary steps | When the current form has 3+ fields and completion rate is low |
| **CTA copy variations** | "Get My Free Audit" vs. "Start My Trial" vs. "See If I Qualify" — test which value frame resonates | When the CTA is generic ("Submit," "Continue," "Get Started") |
| **Friction reducer copy** | With reducers ("Free. No credit card. 30 seconds.") vs. without — and which specific reducers matter most | When the form has no friction-reducer copy below the CTA |
| **Phone field: required vs. optional vs. removed** | Lead volume vs. lead quality tradeoff | When sales insists on phone number — settle the debate |

### Trust & Social Proof Tests

| Test | Hypothesis Pattern | When to Run |
|---|---|---|
| **Trust signals above fold vs. below fold** | Cold-traffic, zero-trust visitors abandon before scrolling — moving signals up may stop the bleed | When the page has trust signals but they're below the fold |
| **Selectivity bar at top vs. no bar** | Cialdini scarcity / qualification reframe | When the offer is genuinely selective and the current page doesn't show it |
| **Customer logo bar vs. stat line vs. both** | Logos build category-trust; stats build scale-trust | When the page has neither, or is using the wrong type for its audience |
| **Aggregate review widget (Trustpilot / G2) vs. curated testimonials** | Aggregated = volume signal; curated = matched-emotional-lever signal | When the client has both but is only using one |
| **Press/media mentions: prominent vs. subtle vs. absent** | Authority transfer from third-party media | When mentions exist but aren't prominently displayed |

### Content Tests

| Test | Hypothesis Pattern | When to Run |
|---|---|---|
| **Pain agitation section vs. no section** | More pain = more motivation, but adds friction for hot traffic | When the page is short and you suspect you need more buildup |
| **Founder origin story: above vs. below fold** | Top placement = trust-from-the-start; below = trust-after-pain | When the founder story exists but placement isn't tested |
| **3-step process vs. 5-step process** | Fewer steps = more achievable; more steps = more legitimate | When the process feels too simple to believe OR too complex to engage |
| **Objection handler section vs. without** | Pre-handling reduces last-minute drop-off | When the page doesn't have one and exit-intent surveys mention specific objections |

---

## Tier 2: Medium-Impact Tests

These produce moderate lifts and are worth running once Tier 1 is settled.

### Page Structure

| Test | Hypothesis |
|---|---|
| Long-form (full template) vs. short above-fold-only | Long for cold traffic that needs convincing; short for warm/hot that converts faster |
| Navigation: full nav vs. stripped vs. partial | Stripped = single-focus landing; full = website page; partial = compromise |
| Video embed (testimonial or explainer) vs. no video | Video typically lifts conversion 10–80% but adds page weight |
| Sticky CTA on scroll vs. no sticky | Reduces friction of returning to form on long pages |
| Hero form right vs. below headline | Side-by-side requires desktop; below is mobile-friendly |

### CTA & Form (Secondary)

| Test | Hypothesis |
|---|---|
| Multiple CTAs at different scroll depths vs. single CTA | More opportunities to convert vs. less choice paralysis |
| CTA color: brand-primary vs. distinct accent | High-contrast accent often outperforms brand-color match |
| CTA size: large vs. standard | Larger button = higher visual weight = higher click rate (usually) |
| Auto-advance multi-step quiz vs. manual advance | Auto = momentum; manual = control |
| Inline form validation vs. submit-then-error | Inline reduces frustration; submit-error reduces field-by-field friction |

### Mobile Experience

| Test | Hypothesis |
|---|---|
| Form position on mobile: above vs. below first trust signal | Trust before form = higher completion (especially cold) |
| Chat widget: shown vs. hidden on landing pages | Widget can interfere with CTA on mobile |
| Page weight: image-light vs. standard | Faster load = higher engagement (especially older / slower-connection audiences) |
| Sticky bottom CTA bar vs. no bar | Persistent CTA reduces bounce on long mobile pages |

---

## Tier 3: Incremental Tests

Smaller potential lifts, but useful once the bigger questions are settled.

### Design & Layout

| Test | Hypothesis |
|---|---|
| Dark vs. light hero background | Dark feels premium for high-ticket; light feels approachable for consumer |
| CTA color variations | Match brand vs. high-contrast |
| Trust bar format: stats vs. logos vs. both | Different audiences respond to different trust formats |
| Testimonial format: cards vs. carousel vs. wall-of-love | Cards = curated; carousel = interactive; wall = volume |

### Post-Conversion

| Test | Hypothesis |
|---|---|
| Thank-you page with calendar embed vs. without | Calendar embeds often increase booked calls 30%+ over "we'll be in touch" |
| Bridge content on TY page (digital download / video) vs. confirmation only | Bridge content reduces remorse and builds engagement during fulfillment delay |
| Thank-you page testimonial vs. none | Reinforces the decision, reduces buyer's remorse |
| Follow-up form on TY for additional info vs. none | Foot-in-the-door for fields you didn't ask upfront |

### Retargeting / Re-Engagement

| Test | Hypothesis |
|---|---|
| Cost-transparent retargeting vs. standard | Address the #1 stated objection upfront for lost prospects |
| "We noticed you didn't finish" vs. fresh-start framing | Acknowledging vs. ignoring prior friction |
| Text/email follow-up offer vs. phone-only | Reduces friction for prospects who avoid sales calls |

---

## Test Execution Notes

### What to Measure for Every Test

- **Primary:** The conversion event (form completion, demo request, purchase, trial signup)
- **Secondary (proxies):** Form start rate, time on page, scroll depth, click rate on CTA
- **Segmented:** Mobile vs. desktop, traffic source, audience segment (if available)

### Minimum Sample Size

Use this as a rough heuristic — for actual statistical rigor, plug numbers into a sample size calculator before launching.

| Baseline conversion rate | Minimum conversions per variant for ~10% MDE |
|---|---|
| 1% | ~3,000 |
| 3% | ~1,000 |
| 5% | ~600 |
| 10% | ~300 |
| 20% | ~150 |

(MDE = Minimum Detectable Effect — the smallest lift the test can reliably detect.)

For most landing-page tests with 5–15% baseline conversion rates, **300–1,000 conversions per variant** is the practical minimum.

### Test Duration

- Run for at least **7 days** to capture weekly patterns (weekday vs. weekend traffic differs)
- Don't end a test based on direction alone — wait for statistical significance
- Don't run a test for more than 4–6 weeks without checking for confounding variables (algorithm shifts, seasonality, traffic source changes)

### What NOT to Test Simultaneously

- Don't change headline AND form AND CTA in the same test — isolate one variable
- **Exception:** If doing a full page redesign (Template T1 vs. current page), test the whole page as one variant. The interaction effects matter more than individual elements. This is sometimes called a "champion vs. challenger" test.

### Test Stacking

Once a winner is declared and rolled out, immediately set up the next test on the next-highest priority element. Compounding lifts is how you get to 2x conversion rates over a quarter.

---

## Quick Reference: Test Priority by Page Score

If your audit shows a low score in:

- **Clarity** → Test hero headline + sub-headline + image
- **Trust** → Test trust signal placement + format + selectivity bar
- **Offer Strength** → Test CTA copy + friction reducers + risk reversal
- **Emotional Resonance** → Test pain agitation section + emotional lever
- **Form Friction** → Test field count + multi-step format + CTA copy
- **Mobile Experience** → Test mobile-specific layout + sticky CTA + widget interference
- **Content Depth** (website pages) → Test additional sections + FAQ preview + objection handler
- **Internal Linking** (website pages) → Test secondary CTA copy + navigation structure
