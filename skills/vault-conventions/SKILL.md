---
name: vault-conventions
description: How to work with a Vault — a read-only MCP connector that serves a company's canonical brand, copy, stats, and reference content. Read this FIRST in any session where a Vault connector is attached and the task touches brand, voice, copy, stats, services, positioning, reviews, or anything a client would publish. Also use when the user mentions "the Vault," "our brand guide," "canonical stats," "what does the Vault say," "check the Vault," when Vault tools seem to exist but aren't being called, when a Vault call fails or asks for approval, or when you are unsure which Vault tool answers a question. Covers tool discovery, corporate vs agency vault shapes, the non-negotiable sourcing rules, and the connector-permission trap that silently disables the whole system. Every other Vault skill defers to this one.
metadata:
  version: 1.0.0
---

# Vault Conventions

A Vault is a read-only MCP connector serving one company's canonical content: brand and voice, approved copy, verified stats, services, reviews, and reference material. It exists so that a number in a deliverable traces to a source instead of to a model's memory.

This skill is the operating manual. Read it before the first Vault call in a session.

---

## Step 1 — Find out what you actually have

**Never assume tool names.** They differ across Vaults. Some are unprefixed (`search_vault`), some are namespaced per brand (`acme_search_vault`). Match on the **suffix**, never the full string.

Scan the available tools for these suffixes:

| Suffix | What it does | Present on |
|---|---|---|
| `list_vault_files` | The index. Titles, summaries, tags | Always |
| `read_vault_file` | One file, optionally one section | Always |
| `search_vault` | Full-text search across the Vault | Always |
| `get_canonical_stat` / `list_canonical_stats` | Verified numbers with source and date | Always |
| `log_vault_update_request` | File a correction for human review | Always |
| `get_brand_guide` | Visual system + voice system | Most |
| `list_brand_assets` / `get_brand_asset` | Logos, files, downloads | Most |
| `select_reviews` / `select_testimonials` | Display-safe, pre-vetted quotes | Some |
| `check_copy_compliance` | Regulated-industry copy gate | Some |
| `get_landing_page_system_guide` | Locked page/form architecture | Some |
| `get_data_interpretation_guide` | How to read this company's analytics | Some |
| `list_clients` | The roster — **signals an agency Vault** | Agency only |

**If none of these exist, no Vault is attached.** Say so plainly, once, and continue with whatever the user gave you directly. Do not invent Vault content, do not pretend to have checked, and do not keep mentioning it.

## Step 2 — Work out which shape of Vault it is

**Agency Vault** — a `list_clients` tool exists, or content tools require a `client` argument. One connector serves several separate clients plus the agency's own brand.

- Call `list_clients` first. It's the orientation call.
- **Name the client on every single content call.** The argument is not optional and there is no sensible default.
- **Never blend.** One client's stats, voice, reviews, or brand must never inform another client's deliverable. Not as inspiration, not as an example, not "for reference."
- Scoped results are usually stamped with a banner naming whose context they carry. Keep that attribution attached as the content moves downstream.

**Corporate Vault** — no `list_clients`, no `client` argument. One connector, one company. Simpler: everything in it belongs to the same brand.

Work out which one you're in before the first content call, not after.

## Step 3 — The rules that don't bend

These hold whether or not anything else in the session restates them.

**Numbers come from the stat tool.** Any review count, project count, price, rating, years-in-business, or performance figure goes through `get_canonical_stat`. Not from prose you read in a Vault file, not from the company's website, not from memory. If the tool returns `stale: true`, say so before the number gets published — and file an update request if you can establish the current value.

**Branded work starts with the brand guide.** Before producing anything carrying the company's name — a page, ad, email, deck, one-pager, social graphic — call `get_brand_guide`. It carries the visual system and the voice system together, and skipping it is how off-brand work gets made confidently.

**Quotes come from the review tool where one exists.** Call `select_reviews` / `select_testimonials` rather than reading raw review files. Those tools apply the exclusion rules — approval status, verification, sensitivity — that raw files do not. Quotes are verbatim: use the returned text, never a tidied-up paraphrase.

**The Vault is read-only.** No tool edits Vault content, and you must not try. Corrections go through `log_vault_update_request`, which opens a request for a human to approve or deny. See `vault-update-request` for how to file one worth approving.

**Specialist guides beat general reasoning.** If `get_data_interpretation_guide` exists, call it before interpreting any analytics number — these guides typically exist precisely because the raw numbers mislead. If `get_landing_page_system_guide` exists, call it before touching a landing page; the form and scheduler handoffs are usually locked, and a page rebuilt around them incorrectly breaks lead capture.

**The server's own instructions win.** If a Vault's governance text contradicts this skill, follow the Vault. It knows its own rules.

---

## When Vault calls aren't happening

Three failure modes, all of which look like "the Vault is broken."

**The connector is attached but tools need approval.** This is the common one and it is nearly invisible: the connector shows as connected, tools appear in the list, and nothing ever gets called. The user must set the Vault's tools to **always allow** in their connector settings. Until then every call waits on a click that never comes, and work silently proceeds on un-sourced content. If Vault tools exist but calls aren't landing, check this first, and check it for each person on a team — the default is per-user.

**A call returns an auth or permission error.** The Vault is gated by an email allowlist. If the user signed in with a personal account rather than their work account, they'll be refused. Have them reconnect with the right account.

**Something suggests adding an OAuth Client ID.** Don't pass that along. These servers support dynamic client registration, so a prompt for a client ID means a server-side problem, not user error. Report it as such rather than walking the user through settings that won't help.

---

## Working sequence

1. Discover the tools. Establish corporate vs agency.
2. `list_vault_files` or `search_vault` to scope. Read summaries, then read the two or three files that matter — not everything.
3. Pull the specific things: `get_canonical_stat` for numbers, `get_brand_guide` for voice and visuals, `select_reviews` for proof.
4. Do the work.
5. Run `copy-check` before it ships.
6. File anything you found wrong via `vault-update-request`.

## Related skills

- **vault-onboarding** — first session with a Vault: what it holds, which tool answers which question
- **copy-check** — the pre-ship gate; every number sourced, voice matched, claims verified
- **vault-update-request** — filing a correction a reviewer can act on without a follow-up conversation
- **storystak-cro** — conversion work; pulls its brand constraints and proof points from here
