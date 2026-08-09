# Form Optimization Guide

> **Purpose:** Universal form best practices for landing pages, multi-step funnels, and lead capture. Forms are where most conversion is lost — every additional field, every misplaced trust signal, every mobile UX failure compounds. The rules below apply across nearly every client and vertical, with adjustments noted for high-trust-threshold audiences.

---

## The Three Audience Characteristics That Drive Form Strategy

Before designing or auditing a form, assess three things about the audience:

1. **Prior trust level** — How well do they know the client? (cold = zero trust, branded search = high trust)
2. **Tech comfort and demographic** — Older audiences need bigger taps, simpler layouts. B2B technical buyers tolerate complexity better than consumers.
3. **Stakes / sensitivity** — Is this a $5 newsletter signup or a $50k enterprise demo request? Higher stakes can justify (sometimes require) more friction.

The client context should describe all three. If it doesn't, ask before optimizing.

---

## The Universal Rules

### Rule 1: Field Count Inversely Correlates with Completion
Every additional field reduces completion by 10–25%. Going from 2 to 5 fields commonly cuts conversions in half. The math is brutal and consistent across nearly every test ever published.

**Default:** Capture only what's needed to either (a) follow up effectively or (b) qualify before sales engages. Anything else can be collected post-conversion.

**Hero forms on cold-traffic landing pages:** 2 fields max. Name + Email is the safest default.

**Mid-funnel forms (warm/retargeting):** 3–5 fields acceptable. The visitor is more invested.

**Demo / sales-qualified forms (B2B):** 5–8 fields acceptable. Sales needs qualifying info, and the visitor expects a sales process.

**Exception:** If sales pushback insists on more fields ("we need phone for our SDR team"), run it as an A/B test. Don't assume more fields = better leads. Often the 2-field form generates more total qualified leads even with lower per-lead quality, because volume wins.

### Rule 2: Trust Must Precede the Form (Mobile Especially)
On desktop, the form often sits beside the hero copy and trust signals — both visible at once.

On mobile, the form stacks below the hero. If it stacks above any trust signals (stat line, review count, badge), zero-trust visitors will abandon.

**Rule for mobile:** At least one trust signal must appear before the form. Stat line, badge bar, or review count — pick one and place it above the form on mobile.

### Rule 3: CTA Button Copy Must Communicate Value
Never use "Submit," "Send," "Continue," or "Contact Us." These describe the action, not the value.

**Replace with copy that communicates what the visitor gets:**
- "Get My Free Audit"
- "Start My Trial"
- "See If I Qualify"
- "Send Me the Guide"
- "Book My Strategy Call"
- "Get Instant Access"

Use first-person framing ("Get *My* Free…") where it fits the brand voice — it tests well in many contexts.

### Rule 4: Stack Friction Reducers Below the CTA
Immediately below the button, include 2–4 friction reducers. Pick from:

- "Free."
- "No credit card required."
- "Takes 30 seconds."
- "Cancel anytime."
- "Setup in under 5 minutes."
- "We cover [shipping / setup / migration]."
- "Your info stays private — never shared."
- "No spam, ever."
- "100% money-back" (if compliance allows)

These reduce perceived risk and effort. In Hormozi's Value Equation, they lower the Effort & Sacrifice term — the same offer becomes more valuable when the cost of getting it drops.

### Rule 5: Match the CTA to the Audience's Commitment Level
A cold-traffic visitor is not ready to "Schedule a Strategy Call." They're ready to "Get the Free Guide."

Match the CTA's commitment level to the visitor's investment level. The wrong CTA at the wrong stage kills conversions.

| Visitor Stage | Appropriate CTA Commitment |
|---|---|
| Cold (paid social) | Lowest — "Get the free [thing]" |
| Warm (email, retargeting) | Medium — "See if you qualify" / "Take the assessment" |
| Hot (branded search, direct) | Higher — "Book a call" / "Start your trial" |
| Active customer | Highest — "Upgrade now" / "Add to your plan" |

---

## Form Types by Page

### Landing Page Hero Form (Cold Traffic)

```
[Name field — single field, no first/last split]
[Email field]
[CTA Button: Action + Value]
Friction reducer 1. Friction reducer 2. Friction reducer 3.
```

**Fields:** 2
**Position:** Right side of hero (desktop), below headline + 1 trust signal (mobile)
**Labels:** Visible above field (not placeholder-only — placeholders disappear on focus and older users forget the field)

### Multi-Step Quiz / Typeform-Style Funnel

```
Screen 1: [Identifying Yes/No question — easy click]
Screen 2: [Severity question — multiple choice]
Screen 3: [Context question — multiple choice]
Screen 4: [Personalization question — multiple choice]
Screen 5: [Name] [Email] [Optional: phone] → "See My Results"
```

**Why this works:**
- Progressive commitment (Cialdini Consistency) — small "yes" answers build toward the form
- Each question is easy (button tap, not typing)
- Contact info comes last, after they're invested
- Question categories validate the visitor's experience
- Progress bar shows advancement — Hormozi's Effort & Sacrifice perception drops as they see they're "almost done"

### Thank-You Page Follow-Up Form

```
"One more thing — to help us prepare your [thing]:"
[Field needed for personalization]
[Phone — with reason: "So we can reach you about your [thing]"]
[CTA: "Complete My [Thing] Request"]
```

**Why here and not in the hero:** Trust has been established by the initial conversion. They've already committed. This is the foot-in-the-door — asking for more after they've said yes is much easier than asking upfront.

### Re-Engagement Form (Lost Prospects)

```
"It's been a while. [Relevant context update]."
[Email — pre-filled if possible from URL params]
[CTA: "Send Me an Updated [Thing]"]
"We'll also text you a link. No calls unless you want them."
```

**Key:** If lost-prospect research (per client context) shows specific friction reasons, address them in the form. Common pattern: lost prospects often disengage due to outreach overload — offer text/email as the primary contact method.

### B2B Demo Request Form

```
[Work Email — single field, blocks personal email domains]
[Company Name]
[Company Size — dropdown, used for routing]
[Your Role — dropdown, used for personalization]
[What's prompting your interest? — optional textarea]
[CTA: "Request My Demo"]
"You'll hear from us within 1 business day."
```

**Fields:** 4–5 (acceptable for B2B demo CTA)
**Email validation:** block personal domains (gmail, yahoo, hotmail) for enterprise demo flows where work-email signal matters
**Routing:** company size determines whether the lead goes to SMB sales, mid-market, or enterprise — set this expectation in the field label

---

## Field-by-Field Guidance

### Name
- **Single field** — "Name" not "First Name" + "Last Name"
- Single field reduces friction by one field and one decision
- Only split if personalization in follow-up emails requires it (and it usually doesn't — most ESPs can split a single name field)

### Email
- Standard email field with inline validation
- Typo detection where possible: "Did you mean @gmail.com?"
- Proper mobile keyboard: `type="email"` triggers the email keyboard
- **No confirmation field** — these reduce completion 10%+ for negligible benefit
- For B2B demo flows: consider blocking personal domains with inline messaging ("Please use your work email")

### Phone
- **Optional in initial form** — make it a follow-up ask where possible
- If included: explain why — "So our team can reach you about your [thing]"
- Auto-format as they type
- Mobile: trigger numeric keyboard with `type="tel"`
- Privacy assurance nearby: "We'll never share your number"

### Company / Job Title (B2B)
- **Required** for B2B demo flows where routing matters
- Dropdowns where the values matter for routing (company size, industry)
- Free-text where the values are too varied to enumerate (job title)

### Multi-Choice Qualifying Questions
- Use buttons or visual cards over dropdowns where possible — easier on mobile
- Limit options to 4–6 per question — more becomes paralysis
- Include an "Other" option for honesty

### "How did you hear about us?"
- **Don't include this in the conversion form.** Track it via UTM parameters and analytics, not user input.
- If marketing insists on it, make it post-conversion, not pre-conversion.

---

## Mobile-Specific Form Rules

For audiences that skew older or less tech-comfortable, mobile usability is the highest-leverage form fix.

| Rule | Why |
|---|---|
| 44px minimum height for all tap targets | Older users have less precise taps; small buttons = missed taps = abandonment |
| Single column only — no side-by-side fields on mobile | Side-by-side fields force horizontal scrolling or cramped tapping |
| Visible labels above fields (not placeholder-only) | Placeholders disappear on focus; users forget the field |
| 16px minimum font size for inputs | Prevents iOS zoom on focus (which disrupts layout) |
| Sticky CTA button on scroll | Once user scrolls past the form, a persistent CTA bar follows them |
| Autofill enabled (`name`, `email`, `tel` autocomplete attributes) | Reduces typing burden |
| No widget overlap with CTA | Test at 375px width — chat widgets, popups, cookie banners often cover the CTA |
| Keyboard-appropriate input types | `email` → email keyboard, `tel` → numeric keyboard, `number` → number pad |

---

## Measuring Form Performance

### Metrics to Track

| Metric | What It Tells You |
|---|---|
| Form view rate | How many page visitors actually see the form (scroll depth issue if low) |
| Form start rate | How many people focus the first field (trust/motivation issue if low) |
| Field-by-field drop-off | Which specific field loses people (too many fields, or one specific field is the problem) |
| Completion rate | Started form → submitted (the core metric) |
| Mobile vs. desktop completion | Mobile is typically lower — if the gap is large, there's a mobile UX issue |
| Time to complete | If it's over 60 seconds for a 2-field form, something is wrong |

### Benchmarks (Approximate — Vary by Vertical and Offer Quality)

| Form Type | Healthy Completion Rate |
|---|---|
| 2-field landing page hero form | 30–50% of form views |
| Multi-step quiz (5 screens) | 40–60% of quiz starters |
| B2B demo request (5 fields) | 15–30% of form views |
| Thank-you page follow-up | 50–70% (they've already converted) |

If completion rates are significantly below these ranges, the issue is usually field count, trust placement, or mobile UX — not the offer itself.

---

## Common Form Mistakes (Audit For These)

| Mistake | Fix |
|---|---|
| 5+ fields in a cold-traffic hero form | Reduce to 2 (Name + Email). Move other fields post-conversion. |
| Form before any trust signals on mobile | Place at least one trust stat above the form on mobile |
| "Submit" or "Contact Us" button | Replace with action + value copy ("Get My Free Audit") |
| No friction reducers below CTA | Stack 2–4 friction reducers below the button |
| No privacy assurance | Add "Your info stays private" near the form |
| Phone field required on cold-traffic form | Make optional or move to thank-you page follow-up |
| Small tap targets on mobile (<44px) | Increase tap target size; generous padding |
| Chat widget / popup overlapping CTA on mobile | Reposition or hide widget on conversion-critical pages |
| Placeholder-only labels (no visible label) | Always show a visible label above the field |
| Side-by-side fields on mobile | Stack to single column |
| No inline validation | Add real-time validation with helpful error messages |
| Confirmation email field | Remove — pure friction with no benefit |
| Required "How did you hear about us?" field | Remove — track via analytics |
| Generic CTA color matching site background | Make CTA visually distinct — color contrast matters |
| Form below the fold on desktop without a CTA scroll cue | Add a visible "↓ Get Started" cue to direct attention to the form |
