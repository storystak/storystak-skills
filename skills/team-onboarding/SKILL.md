---
name: team-onboarding
description: Walk a new team member — hire or contractor — through their company's onboarding using the Vault's own onboarding playbook and SOP library, phase by phase, tailored to their role. Use when someone says "I'm new here", "it's my first day", "walk me through onboarding", "get me up to speed", when a manager asks to onboard, train, or set up a new team member or contractor, or when a session's user clearly hasn't been through the company's setup (no tool access, doesn't know the workflow, asks where things live). Also use to generate a personalized onboarding checklist for a specific role. Requires a Vault that carries onboarding process content; if the Vault has none, this skill says so rather than inventing a process.
metadata:
  version: 1.0.0
---

# Team Onboarding

Walk a new person from "I just got access" to "I know how this team works" using the company's own documented process — never a generic one.

The company's onboarding phases, role expectations, SOPs, and training material live in the Vault. Your job is to find them, sequence them for this person's role, and walk them through interactively. **You are the guide, not the source**: every step you give traces to a Vault file. If the Vault has no onboarding content, say exactly that and suggest the team document their process — do not improvise one.

---

## Step 1 — Orient (before saying anything about process)

1. Follow `vault-conventions` to discover the Vault and its shape.
   - **Agency Vault** (a `list_clients` tool exists): onboarding content lives in the agency's own scope — pass the agency scope on every call. You are onboarding someone into the *agency*, not into a client.
   - **Corporate Vault**: one company, no scope argument to worry about.
2. Find the onboarding material: `search_vault` for "onboarding", "new team member", "SOP", and list the Vault's files for a playbooks or process area. Read what exists before the first word of guidance.
3. Find the supporting cast if present: a team roster file (who holds which role), an SOP library or playbook set, a training-video index.

**If no onboarding playbook exists**, stop here: tell the user their Vault doesn't carry an onboarding process yet, offer to help them draft one (which their reviewer can approve via `vault-update-request`), and go no further with invented steps.

## Step 2 — Establish who you're onboarding

Three questions, then tailor everything after:

1. **Role** — which seat is this person filling? Their role decides which SOPs are their first reads and which phases apply.
2. **Employee or contractor** — onboarding paperwork and access typically differ; the playbook will say how.
3. **Where are they in the process** — day one, mid-onboarding, or a manager preparing before the start date?

## Step 3 — Walk the phases, one at a time

Present the company's onboarding phases exactly as the Vault documents them — same order, same owners. For each phase:

- Say **whose step it is**. Onboarding playbooks assign phases to owners (leadership, operations, a department lead). Never hand the new person a step that belongs to someone else — tell them who does it and what they should expect to receive.
- Confirm completion before moving on ("has this happened yet?") — the answer decides whether you're guiding or flagging a gap.
- Where a phase references tools, name them as the Vault names them; where it references people, use the roster file, not names embedded in SOP prose (SOPs go stale on names faster than a roster file does).

## Step 4 — The role's reading list

From the SOP library, assemble the first reads for their role — typically the role charter, the core workflow SOP, and whatever their team's quality bar is documented in. For each: one honest sentence on what it governs, then the pointer (`read_vault_file` path). If a training-video index exists, pull the videos for their role's tools.

Offer to produce the whole thing as a **personalized onboarding checklist** — phases with owners, their own to-dos, the reading list, the video list — as a document they keep.

## Step 5 — What you never do

- **Never resolve an open flag.** If an SOP carries a `Confirm:` or an unresolved decision (who reviews what, which account to use), present it as "pending a leadership decision — ask" rather than picking an answer.
- **Never handle credentials.** Where onboarding involves account creation or password sharing, the step belongs to whoever the playbook names, through whatever secure channel the company uses. You point; you don't transmit.
- **Never substitute general knowledge for the documented process.** A generic "best-practice onboarding" answer given where the Vault documents a real one is a wrong answer.
- **HR content stays with leadership.** Check-in forms, performance processes, compensation: acknowledge they exist where documented, point at the owner, and don't editorialize.

## Related skills

- `vault-conventions` — the operating manual for any Vault session; Step 1 leans on it.
- `vault-onboarding` — for the person who is new to the *Vault itself*; run it alongside this when the new team member has never used the connector.
- `vault-update-request` — the fix path when onboarding reveals stale or missing process content.
