---
name: stak-update-request
description: File a correction to a Stak that a reviewer can act on without asking follow-up questions. Use when you find a stat that's wrong or outdated, a fact that has changed, a gap where the Stak should have an answer and doesn't, or a worthwhile insight the Stak should carry. Also use when the user says "the Stak is wrong," "that number changed," "we don't do that anymore," "this is out of date," "the Stak should know this," "file an update," "log this," "we have a new price/service/stat," or when a canonical stat comes back marked stale. Covers the edit vs new-file decision, what a reviewer needs to approve without a follow-up conversation, and the propagation sweep — finding every other place a changed fact lives and filing the companion edits in the same sitting. Requires a Stak connector.
metadata:
  version: 1.1.0
---

# Stak Update Request

The Stak is read-only through MCP. No tool edits its content and you must not attempt to. When something is wrong, you file a request; a human approves or denies it, and only an approval reaches the Stak.

This is not bureaucracy for its own sake. The Stak's value is that its contents are trusted, and that only holds if changes pass through review.

Read `stak-conventions` first if you haven't.

---

## Before you file

**Search first.** Call `search_stak` and `list_stak_files`. Two things go wrong when you skip this: you propose a new file for something the Stak already covers, and you file against the wrong file because you guessed the path.

**Then decide which kind of request it is:**

**`request_type="edit"`** — the content corrects, updates, or extends something in a file that already exists. This is the default and it's right most of the time.

**`request_type="new_file"`** — the content is a distinct, substantial topic that no existing file covers. Requires a `why_new_file` justification.

**When in doubt, file an edit.** A correction folded into the right existing file is easy to review and easy to find later. A new file for something that belonged in a section creates a second place to look for the same answer, and the two drift.

**On an agency Stak, scope the request to the client it belongs to.** Same client argument as every other call.

---

## What a good request contains

| Field | What it needs |
|---|---|
| `file_path` | The stak-relative path, exactly as `list_stak_files` returns it. For a new file: a kebab-case `.md` path with the frontmatter the Stak's other files use. |
| `current_text` | **Edit only.** The exact text to be replaced — copied, not paraphrased. A reviewer has to find it in the file. |
| `suggested_text` | The replacement. For a new file, the complete contents including frontmatter. |
| `reason` | Why this change is needed, **and where the new information came from**. This is the field that decides whether it gets approved. |
| `why_new_file` | New file only. Why this earns its own file rather than a section in an existing one. |
| `severity` | `high` if the current content is actively producing wrong deliverables. `medium` for stale or incomplete. `low` for polish. |

Leave `submitted_by` unset. The server identifies the submitter from the login.

### The `reason` field is the whole thing

A reviewer approving a change needs to know where the new value came from. Compare:

**Weak:** "The review count is out of date."

**Strong:** "Google Business Profile showed 2,104 reviews as of 2026-08-09; the Stak has 1,847, last updated 2026-01-14. The stat is past its quarterly refresh window and appears in the homepage hero and three landing pages."

The second gets approved in one pass. The first generates a reply asking where the number came from, which is the failure mode this field exists to prevent.

Cite a source with a date. "The client told me on a call" is a legitimate source — say that, and say when.

---

## Duplicates

If an open request already targets the same file, the tool returns `possible_duplicate` with the open requests rather than opening a second one.

Read them with `get_stak_update_request`. If yours is genuinely a different change to the same file, re-file with `allow_duplicate=True`. If it's the same change, don't — say it's already queued and move on.

---

## The propagation sweep — one fact, every home

A fact rarely lives in one file. A price sits in the services file, the stats file, a metrics snapshot, and two frontmatter summaries. A "who runs this" answer closes an intake question, corrects a footprint table, and dates a cadence row. **An approved request edits exactly the one file it names — nothing propagates on its own.** The sweep is how the other homes get fixed, and it happens in the same sitting as the original request, not as a note for later.

The failure this prevents is real: a single confirmed fact once needed edits in four places across three files; the appearances nobody swept immediately left the Stak contradicting itself — one paragraph carrying the answer while the table above it still called the fact unknown.

**When a request changes a fact, run the sweep before you call the work done:**

1. **Search for the old value.** `search_stak` the phrase, number, or claim being corrected — and the fact's subject — across the scope. Every hit is a candidate companion.
2. **Check the standing homes a fact-change touches**, even when search misses them:
   - **The canonical stats file** — if the fact is a number the stat layer carries, that entry governs; correct it or the prose correction fights the canon.
   - **The gaps / open-questions file** — a client's answer closes or trims an intake question. Move the substance to the answered register, and cut the open entry down to whatever genuinely remains open (question guides show open questions only; a guide that re-asks an answered question wastes the client's trust). Keep entry numbering stable — other files cite it.
   - **Metrics and snapshot rows** quoting the old value — label the old observation as the older pattern rather than deleting it; snapshots are records.
   - **Frontmatter summaries** — of the file being corrected and of any other file whose summary repeats the fact. Summaries are what listings and pickers show; a corrected body under a stale summary still misleads.
   - **Across scope boundaries, when the account has them** — a commercial-tier change (a fee, a scope, an account status) sweeps the client-facing scope for copy describing the old arrangement, and a client-scope change sweeps the commercial record. Pages that render live from Stak files (a hub, a commercial dashboard) are current the moment edits merge — the sweep's job is making sure every *file* gets its edit, not updating pages by hand.
3. **File one request per hit.** Same-file companions are fine — say so in each reason and name the originating request, so the reviewer sees one coherent change, and batch approval can land them together.
4. **Report the sweep.** Say what you found and filed. "Searched; the fact appears nowhere else" is a finding — state it, don't skip it.

**For reviewers:** a fact-changing request isn't done when it merges — it's done when its sweep is filed. Approve the companions as one batch where the tooling supports it.

---

## What not to file

- **Strategy or opinion.** The Stak holds facts and approved content, not proposals about positioning.
- **One-off deliverable content.** A headline written for one campaign belongs in the campaign, not the Stak.
- **A guess.** If you can't name a source, you have a question for the client, not a request.
- **A fix you can't state precisely.** "This section is confusing" isn't actionable. Either propose the replacement text or raise it with the user.

---

## After filing

The tool returns an issue URL and number. Give the user the link and say plainly that it needs a human to approve it and that nothing has changed in the Stak yet.

If the correction matters for work in progress, keep going with the corrected value **and say explicitly that you're using an unapproved number**. Don't silently substitute your value for the canonical one — the whole point of the Stak is knowing which is which.

## Related skills

- **stak-conventions** — tool discovery and the read-only rule this skill implements
- **copy-check** — surfaces most of the stale stats and errors worth filing
