# Storystak Skills

Skills for marketers working with Claude — conversion optimization, design discipline that avoids the generic AI look, and a set for working with a **Vault**: a read-only connector that serves a company's canonical brand, copy, and stats.

Built by [Storystak](https://storystak.com). MIT licensed, free to use and fork.

---

## The skills

| Skill | What it does |
|---|---|
| **storystak-cro** | Audits and rewrites landing pages, sites, funnels, and forms. Loads a per-client context (or derives one from a URL) and applies Miller, Brunson, Hormozi, Kennedy, Schwartz, and Cialdini frameworks. Ships with 13 reference files — an experiments library, industry pattern library, awareness levels, form optimization, page templates. |
| **storystak-anti-slop-design** | Keeps UI from converging on the default AI aesthetic — lavender-purple, Inter, centered hero with a badge, glassmorphism, nested cards. Pre-generation constraints plus a pre-ship audit. |
| **full-output-enforcement** | Forces complete, unabridged output. No placeholders, no `// rest of code here`. |
| **vault-conventions** | How to work with a Vault: tool discovery, corporate vs agency shapes, the sourcing rules, and the connector setting that silently disables everything. The other Vault skills defer to this one. |
| **copy-check** | Pre-ship gate. Every number traced to a canonical source, voice matched to the brand guide, quotes verified. Returns findings and a PASS/FAIL — never rewritten copy. |
| **vault-update-request** | Files a correction a reviewer can act on without a follow-up conversation. Covers the edit vs new-file decision. |
| **vault-onboarding** | Non-technical first session with a Vault: what it holds, which tool answers which question, and the setup checklist. |

The first three work anywhere. The four Vault skills need a Vault connector attached — without one they say so and fall back to what they can do unaided.

---

## Install

### claude.ai — web, desktop, and mobile

This is the one most people want. Works in both Chat and Cowork.

1. **Customize → Plugins → Add → Add from a repository**
2. Enter `storystak/storystak-skills`
3. Leave **Sync automatically** on, and hit **Sync**
4. Open **Personal → storystak-skills** and click **+** on *Storystak skills*

Takes about thirty seconds, once per account. The skills are then available in every conversation.

### Claude Code

```bash
/plugin marketplace add storystak/storystak-skills
```

```bash
/plugin install storystak-skills@storystak
```

For cloud sessions, declare it under `enabledPlugins` in `.claude/settings.json`.

### Updates

On claude.ai, **Sync automatically** is on by default — new versions arrive on their own when this repo changes. In Claude Code, third-party marketplaces do not auto-update; pull them manually:

```bash
/plugin marketplace update storystak
```

---

## What a Vault is

A Vault is a remote MCP server holding one company's canonical content — brand and voice, approved copy, verified stats with sources and dates, services, reviews. It's read-only: Claude reads from it but never writes, and corrections go through a human review queue.

The point is traceability. A number in a deliverable resolves to a specific file with a date on it, rather than to a model's memory of a website it saw in training.

The Vault skills here are written against the general shape rather than any one server, so they work whether tools are unprefixed (`search_vault`) or namespaced (`acme_search_vault`), and whether the Vault serves one company or a roster of clients.

---

## Contributing

`./validate-skills.sh` runs before every merge — it checks frontmatter, blocks private references, and catches cross-references to skills that don't exist. See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see [LICENSE](LICENSE).
