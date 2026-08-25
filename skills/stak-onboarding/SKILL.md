---
name: stak-onboarding
description: Orientation for someone using a Stak for the first time — what it holds, which tool answers which question, how to set it up so it actually gets used, and prompts worth starting with. Use when the user is new to the Stak, asks "what can the Stak do," "how do I use this," "what's in the Stak," "where do I start," "how do I get my team on this," "what should I ask it," or seems to be working without the Stak when it would help. Also use when onboarding a teammate, setting up a shared workspace, or when someone reports the Stak "isn't working" or "doesn't do anything." Covers the setup checklist including the tool-permission default that silently disables everything.
metadata:
  version: 1.0.0
---

# Stak Onboarding

For someone's first real session with a Stak. Assume no technical background and no interest in how MCP works.

---

## What it is, in one paragraph

The Stak is your company's source of truth, connected directly to Claude. Instead of Claude guessing what your brand sounds like or how many reviews you have, it reads the real answer from a maintained set of files. Anything it tells you from the Stak can be traced back to a specific file with a date on it. It's read-only — Claude can read from it but never change it, so nothing you do in a conversation can damage it.

---

## Setup — three things, once

**1. Connect it.** Add the custom connector using the link your team gave you, and sign in with your **work** account. A personal account will be refused: access is limited to your company's email domain.

**2. Set the tools to "always allow."** This is the step everyone misses, and it's the one that matters. If the Stak's tools are left on "needs approval," every lookup silently waits for a click you never see, and Claude carries on answering from memory instead. It looks like the Stak is working. It isn't. Check this for every person on the team — the setting is per-person.

**3. Make a Project for it.** One Claude Project per brand or client, with the Stak connected, means every conversation in that Project starts with the right context. On Team and Enterprise plans a Project can be shared, so everyone works from the same setup.

**How to tell it's actually working:** ask it something only the Stak would know — a specific stat, or what your brand guide says to avoid. If the answer cites a Stak file, you're set. If it's vague or generic, revisit step 2.

---

## Which tool answers which question

| You want to... | Ask for | Tool it uses |
|---|---|---|
| See what's in the Stak | "What's in the Stak?" | `list_stak_files` |
| Find where something is covered | "What does the Stak say about warranties?" | `search_stak` |
| Read a specific document | "Read the company overview" | `read_stak_file` |
| Get a verified number | "How many reviews do we have?" | `get_canonical_stat` |
| See every number available | "What stats do we track?" | `list_canonical_stats` |
| Write anything on-brand | "Write this in our brand voice" | `get_brand_guide` |
| Get logos and brand files | "Where's our logo?" | `list_brand_assets` |
| Pull customer quotes | "Find testimonials about our service" | `select_reviews` |
| Fix something wrong | "The Stak has the wrong price" | `log_stak_update_request` |

Not every Stak has every tool. Ask "what Stak tools do you have?" to see yours.

**If yours has a `list_clients` tool**, it serves several clients from one connector. Always name the client you're working on — "write a landing page for Acme," never just "write a landing page." Content never crosses between clients.

---

## Prompts worth starting with

**Orientation**
> What's in the Stak? Give me the categories and what each one covers.

> What canonical stats do we track, and when was each last updated?

**Real work**
> Write three ad headlines for our interior service. Use the brand voice from the Stak and pull a testimonial that fits.

> Here's a draft email to customers. Check it against the Stak — are the numbers right and does it sound like us?

> I'm building a landing page for [service]. What does the Stak have that I should use?

**Maintenance**
> Which canonical stats are past their refresh window?

> Our pricing changed. Walk me through filing a Stak update request.

---

## Habits that make it work

**Ask it to check.** "Is this right?" is the highest-value thing you can type. The Stak exists to answer it.

**Trust the numbers it cites, not the ones it doesn't.** If a figure comes back with a source file and a date, it's canonical. If it arrives without one, it's a guess — ask where it came from.

**Report what's wrong.** A stat that's out of date will keep producing wrong work until someone files it. Saying "that number changed" is enough; Claude will handle the request.

**Don't paste in what the Stak already holds.** Ask for it. Pasted content goes stale the moment the Stak updates; a lookup doesn't.

---

## When it seems broken

**Vague, generic answers that ignore the Stak** — nearly always the "always allow" setting from step 2.

**"Not authorized" or a sign-in loop** — wrong account. Reconnect with your work email.

**A prompt asking for an OAuth Client ID** — don't try to fill it in. That's a server-side problem; report it to whoever maintains the Stak.

**A stat that's obviously wrong** — the Stak is only as current as its last update. File a correction; see `stak-update-request`.

## Related skills

- **stak-conventions** — the full operating rules
- **copy-check** — run before anything goes out the door
- **stak-update-request** — filing corrections
