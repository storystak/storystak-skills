---
name: copy-check
description: Pre-ship verification gate for anything client-facing. Checks a draft against the Vault so every number traces to a canonical source, the voice matches the brand guide, quotes are real and approved, and no claim rests on a model's memory. Use BEFORE any deliverable goes out — landing page copy, ad creative, email, social post, one-pager, deck, proposal, press copy, web page. Also use when the user says "check this," "is this ready to send," "does this match our brand," "verify this copy," "fact-check this," "can we say this," "review before publish," or "sanity check this draft." Returns findings and a PASS or FAIL verdict — never rewritten copy. Requires a Vault connector; degrades to a structural review without one.
metadata:
  version: 1.0.0
---

# Copy Check

The gate between a draft and a client seeing it. Its only job is to find things that would be embarrassing, wrong, or off-brand once published.

**This skill returns findings and a verdict. It does not rewrite the copy.** That separation is the point: a reviewer that silently fixes what it finds teaches nobody, hides the error rate, and produces a draft nobody has actually verified. Report what's wrong and let the author decide.

Read `vault-conventions` first if you haven't — this skill assumes you know how to find the Vault's tools and whether you're in a corporate or agency Vault.

---

## What gets checked

### 1. Numbers

Every figure in the draft — review counts, project counts, years in business, ratings, prices, percentages, response times, team size, performance claims.

For each one: does it resolve through `get_canonical_stat`?

- **Matches the canonical value** → pass.
- **No canonical stat exists for it** → FAIL. An unsourced number is the single most common way a deliverable becomes a liability. It doesn't matter that it's probably right.
- **Contradicts the canonical value** → FAIL, and quote both numbers in the finding.
- **Canonical stat returns `stale: true`** → flag it. Not an automatic fail, but the author needs to know they're about to publish a number past its refresh window, and it usually warrants an update request.

Round numbers deserve extra suspicion. "Over 500 projects" and "thousands of happy customers" are still claims.

### 2. Voice

Call `get_brand_guide` and read the voice system, not just the palette.

Check the draft against: voice characteristics, the messaging pillars, owned phrases that should appear verbatim, and — most usefully — the explicit "what to avoid" list. Most brand guides carry one, and violations of it are the highest-signal findings you'll get.

Flag hedging, corporate throat-clearing, and generic superlatives that could describe any company in the category. If a competitor could paste their logo onto the draft and it would still read correctly, that's a finding.

### 3. Quotes and testimonials

Every customer quote must come from `select_reviews` / `select_testimonials` where those tools exist.

- **Quote traces to the review tool, verbatim** → pass.
- **Quote is real but lightly edited for flow** → FAIL. Verbatim means verbatim.
- **Quote can't be traced at all** → FAIL. Fabricated social proof is the worst failure mode in this list.
- **Attribution stronger than the source supports** (a full name where the source has initials, a title the source doesn't carry) → FAIL.

### 4. Claims

Anything asserted as fact that isn't a number: guarantees, credentials, certifications, awards, service coverage, timelines, comparisons to competitors, "the only," "the first," "the largest."

Each one needs a Vault source or an explicit note that the client confirmed it. Comparative and superlative claims are the ones that draw complaints.

### 5. Compliance, where it applies

If `check_copy_compliance` exists on this Vault, run it — its presence means this client operates somewhere with rules, and your general judgment is not a substitute.

Absent that tool, if the Vault carries compliance or advertising-claim content, read it and check against it. Regulated categories — finance, medical, legal, debt, insurance — have restricted vocabularies where the specific words matter.

### 6. Cross-client contamination (agency Vaults only)

Confirm every fact, stat, quote, and voice choice traces to **the client this deliverable is for**. Content borrowed from a sibling client on the same roster is a serious finding regardless of how well it reads.

---

## Output

```
VERDICT: PASS | FAIL

FINDINGS (most severe first)
1. [FAIL] Unsourced number — "over 2,000 projects completed"
   No canonical stat covers project count. Closest is
   `total_reviews_indexed` (1,847), which is a different measure.
   → Source it or cut it.

2. [FAIL] Quote not verbatim — paragraph 3
   Draft: "They finished early and under budget."
   Source: "They actually finished two days early and came in under
   what they quoted."
   → Use the source text.

3. [FLAG] Stale stat — "4.9 star average"
   Canonical value matches, last updated 214 days ago, past the
   quarterly window.
   → Verify before publish; file an update request either way.

4. [FLAG] Voice — "we're passionate about delivering excellence"
   Brand guide's avoid-list names exactly this construction.
   → Rewrite in the author's own register.

CHECKED AND CLEAN
- 3 of 4 numbers traced to canonical stats
- Both testimonials verbatim from select_reviews
- No competitor comparisons or superlatives
```

**FAIL if any number is unsourced or contradicted, any quote is unverifiable or altered, any claim lacks backing, or any content crosses client boundaries.** Everything else is a flag.

A PASS with flags is a normal, good outcome. A PASS with nothing listed under "checked and clean" means you didn't actually check — say so instead.

---

## Without a Vault

Say once that no Vault is attached and that sourcing cannot be verified. Then do the part you can: list every number and factual claim in the draft as **unverified**, and review voice and structure on their own merits. A list of things the author needs to confirm is genuinely useful. A PASS is not available.

## Related skills

- **vault-conventions** — tool discovery, corporate vs agency, the sourcing rules this skill enforces
- **vault-update-request** — for the stale stats and errors this check surfaces
- **storystak-cro** — produces the copy this skill gates
