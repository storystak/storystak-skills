---
name: stak-conventions
description: How to work with a Stak — a read-only MCP connector that serves a company's canonical brand, copy, stats, and reference content. Read this FIRST in any session where a Stak connector is attached and the task touches brand, voice, copy, stats, services, positioning, reviews, or anything a client would publish. Also use when the user mentions "the Stak," "our brand guide," "canonical stats," "what does the Stak say," "check the Stak," when Stak tools seem to exist but aren't being called, when a Stak call fails or asks for approval, or when you are unsure which Stak tool answers a question. Covers tool discovery, corporate vs agency stak shapes, the non-negotiable sourcing rules, and the connector-permission trap that silently disables the whole system. Every other Stak skill defers to this one.
metadata:
  version: 1.1.0
---

# Stak Conventions

A Stak is a read-only MCP connector serving one company's canonical content: brand and voice, approved copy, verified stats, services, reviews, and reference material. It exists so that a number in a deliverable traces to a source instead of to a model's memory.

This skill is the operating manual. Read it before the first Stak call in a session.

---

## Step 1 — Find out what you actually have

**Never assume tool names.** They differ across Staks. Some are unprefixed (`search_stak`), some are namespaced per brand (`acme_search_stak`), and connectors deployed before the 2026-08-25 Vault → Stak rename still expose `vault_`-suffixed names (`search_vault`, `list_vault_files`) — same tools, older deploy; everything in this skill applies to them identically. Match on the **suffix**, never the full string.

Scan the available tools for these suffixes:

| Suffix | What it does | Present on |
|---|---|---|
| `list_stak_files` | The index. Titles, summaries, tags | Always |
| `read_stak_file` | One file, optionally one section | Always |
| `search_stak` | Full-text search across the Stak | Always |
| `get_canonical_stat` / `list_canonical_stats` | Verified numbers with source and date | Always |
| `log_stak_update_request` | File a correction for human review | Always |
| `get_brand_guide` | Visual system + voice system | Most |
| `list_brand_assets` / `get_brand_asset` | Logos, files, downloads | Most |
| `select_reviews` / `select_testimonials` | Display-safe, pre-vetted quotes | Some |
| `check_copy_compliance` | Regulated-industry copy gate | Some |
| `get_landing_page_system_guide` | Locked page/form architecture | Some |
| `get_data_interpretation_guide` | How to read this company's analytics | Some |
| `list_clients` | The roster — **signals an agency Stak** | Agency only |

**If none of these exist, no Stak is attached.** Say so plainly, once, and continue with whatever the user gave you directly. Do not invent Stak content, do not pretend to have checked, and do not keep mentioning it.

## Step 2 — Work out which shape of Stak it is

**Agency Stak** — a `list_clients` tool exists, or content tools require a `client` argument. One connector serves several separate clients plus the agency's own brand.

- Call `list_clients` first. It's the orientation call.
- **Name the client on every single content call.** The argument is not optional and there is no sensible default.
- **Never blend.** One client's stats, voice, reviews, or brand must never inform another client's deliverable. Not as inspiration, not as an example, not "for reference."
- Scoped results are usually stamped with a banner naming whose context they carry. Keep that attribution attached as the content moves downstream.
- **The roster reflects the caller, not the Stak.** Some scopes are restricted to specific people, so a client the user expects may simply not be in *their* roster. That is access control working, not a missing client — say so rather than treating it as a bug or hunting for the content another way.

**Corporate Stak** — no `list_clients`, no `client` argument. One connector, one company. Simpler: everything in it belongs to the same brand.

Work out which one you're in before the first content call, not after.

## Step 3 — The rules that don't bend

These hold whether or not anything else in the session restates them.

**Numbers come from the stat tool.** Any review count, project count, price, rating, years-in-business, or performance figure goes through `get_canonical_stat`. Not from prose you read in a Stak file, not from the company's website, not from memory. If the tool returns `stale: true`, say so before the number gets published — and file an update request if you can establish the current value.

**Branded work starts with the brand guide.** Before producing anything carrying the company's name — a page, ad, email, deck, one-pager, social graphic — call `get_brand_guide`. It carries the visual system and the voice system together, and skipping it is how off-brand work gets made confidently.

**Quotes come from the review tool where one exists.** Call `select_reviews` / `select_testimonials` rather than reading raw review files. Those tools apply the exclusion rules — approval status, verification, sensitivity — that raw files do not. Quotes are verbatim: use the returned text, never a tidied-up paraphrase.

**The Stak is read-only.** No tool edits Stak content, and you must not try. Corrections go through `log_stak_update_request`, which opens a request for a human to approve or deny. See `stak-update-request` for how to file one worth approving.

**Specialist guides beat general reasoning.** If `get_data_interpretation_guide` exists, call it before interpreting any analytics number — these guides typically exist precisely because the raw numbers mislead. If `get_landing_page_system_guide` exists, call it before touching a landing page; the form and scheduler handoffs are usually locked, and a page rebuilt around them incorrectly breaks lead capture.

**The server's own instructions win.** If a Stak's governance text contradicts this skill, follow the Stak. It knows its own rules.

---

## When Stak calls aren't happening

Three failure modes, all of which look like "the Stak is broken."

**The connector is attached but tools need approval.** This is the common one and it is nearly invisible: the connector shows as connected, tools appear in the list, and nothing ever gets called. The user must set the Stak's tools to **always allow** in their connector settings. Until then every call waits on a click that never comes, and work silently proceeds on un-sourced content. If Stak tools exist but calls aren't landing, check this first, and check it for each person on a team — the default is per-user.

**A call returns an auth or permission error.** The Stak is gated by an email allowlist. If the user signed in with a personal account rather than their work account, they'll be refused. Have them reconnect with the right account.

**Something suggests adding an OAuth Client ID.** Don't pass that along. These servers support dynamic client registration, so a prompt for a client ID means a server-side problem, not user error. Report it as such rather than walking the user through settings that won't help.

---

## Working sequence

1. Discover the tools. Establish corporate vs agency.
2. `list_stak_files` or `search_stak` to scope. Read summaries, then read the two or three files that matter — not everything.
3. Pull the specific things: `get_canonical_stat` for numbers, `get_brand_guide` for voice and visuals, `select_reviews` for proof.
4. Do the work.
5. Run `copy-check` before it ships.
6. File anything you found wrong via `stak-update-request`.

## Related skills

- **stak-onboarding** — first session with a Stak: what it holds, which tool answers which question
- **copy-check** — the pre-ship gate; every number sourced, voice matched, claims verified
- **stak-update-request** — filing a correction a reviewer can act on without a follow-up conversation
- **storystak-cro** — conversion work; pulls its brand constraints and proof points from here
