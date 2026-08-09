---
name: vault-update-request
description: File a correction to a Vault that a reviewer can act on without asking follow-up questions. Use when you find a stat that's wrong or outdated, a fact that has changed, a gap where the Vault should have an answer and doesn't, or a worthwhile insight the Vault should carry. Also use when the user says "the Vault is wrong," "that number changed," "we don't do that anymore," "this is out of date," "the Vault should know this," "file an update," "log this," "we have a new price/service/stat," or when a canonical stat comes back marked stale. Covers the edit vs new-file decision and what a reviewer needs to approve without a follow-up conversation. Requires a Vault connector.
metadata:
  version: 1.0.0
---

# Vault Update Request

The Vault is read-only through MCP. No tool edits its content and you must not attempt to. When something is wrong, you file a request; a human approves or denies it, and only an approval reaches the Vault.

This is not bureaucracy for its own sake. The Vault's value is that its contents are trusted, and that only holds if changes pass through review.

Read `vault-conventions` first if you haven't.

---

## Before you file

**Search first.** Call `search_vault` and `list_vault_files`. Two things go wrong when you skip this: you propose a new file for something the Vault already covers, and you file against the wrong file because you guessed the path.

**Then decide which kind of request it is:**

**`request_type="edit"`** — the content corrects, updates, or extends something in a file that already exists. This is the default and it's right most of the time.

**`request_type="new_file"`** — the content is a distinct, substantial topic that no existing file covers. Requires a `why_new_file` justification.

**When in doubt, file an edit.** A correction folded into the right existing file is easy to review and easy to find later. A new file for something that belonged in a section creates a second place to look for the same answer, and the two drift.

**On an agency Vault, scope the request to the client it belongs to.** Same client argument as every other call.

---

## What a good request contains

| Field | What it needs |
|---|---|
| `file_path` | The vault-relative path, exactly as `list_vault_files` returns it. For a new file: a kebab-case `.md` path with the frontmatter the Vault's other files use. |
| `current_text` | **Edit only.** The exact text to be replaced — copied, not paraphrased. A reviewer has to find it in the file. |
| `suggested_text` | The replacement. For a new file, the complete contents including frontmatter. |
| `reason` | Why this change is needed, **and where the new information came from**. This is the field that decides whether it gets approved. |
| `why_new_file` | New file only. Why this earns its own file rather than a section in an existing one. |
| `severity` | `high` if the current content is actively producing wrong deliverables. `medium` for stale or incomplete. `low` for polish. |

Leave `submitted_by` unset. The server identifies the submitter from the login.

### The `reason` field is the whole thing

A reviewer approving a change needs to know where the new value came from. Compare:

**Weak:** "The review count is out of date."

**Strong:** "Google Business Profile showed 2,104 reviews as of 2026-08-09; the Vault has 1,847, last updated 2026-01-14. The stat is past its quarterly refresh window and appears in the homepage hero and three landing pages."

The second gets approved in one pass. The first generates a reply asking where the number came from, which is the failure mode this field exists to prevent.

Cite a source with a date. "The client told me on a call" is a legitimate source — say that, and say when.

---

## Duplicates

If an open request already targets the same file, the tool returns `possible_duplicate` with the open requests rather than opening a second one.

Read them with `get_vault_update_request`. If yours is genuinely a different change to the same file, re-file with `allow_duplicate=True`. If it's the same change, don't — say it's already queued and move on.

---

## What not to file

- **Strategy or opinion.** The Vault holds facts and approved content, not proposals about positioning.
- **One-off deliverable content.** A headline written for one campaign belongs in the campaign, not the Vault.
- **A guess.** If you can't name a source, you have a question for the client, not a request.
- **A fix you can't state precisely.** "This section is confusing" isn't actionable. Either propose the replacement text or raise it with the user.

---

## After filing

The tool returns an issue URL and number. Give the user the link and say plainly that it needs a human to approve it and that nothing has changed in the Vault yet.

If the correction matters for work in progress, keep going with the corrected value **and say explicitly that you're using an unapproved number**. Don't silently substitute your value for the canonical one — the whole point of the Vault is knowing which is which.

## Related skills

- **vault-conventions** — tool discovery and the read-only rule this skill implements
- **copy-check** — surfaces most of the stale stats and errors worth filing
