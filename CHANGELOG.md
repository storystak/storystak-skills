# Changelog

## 0.1.1 — 2026-08-09

Corrected the install instructions. Plugins **do** work in claude.ai, in both
Chat and Cowork — installed per-account via Customize → Plugins → Add from a
repository. The previous README repeated Anthropic's developer docs, which
say plugins are Cowork-and-Code only; that is stale, and the help center is
the accurate source. Verified by installing this plugin from GitHub into a
live claude.ai account.

claude.ai also defaults **Sync automatically** to on, so updates propagate
without user action there — unlike Claude Code, where third-party
marketplaces must be updated manually.

## 0.1.0 — 2026-08-09

First release. Seven skills.

**Conversion and design**
- `storystak-cro` — page, funnel, and form auditing with 13 reference files
- `storystak-anti-slop-design` — pre-generation constraints and a pre-ship audit against the default AI aesthetic
- `full-output-enforcement` — complete output, no placeholders

**Vault-aware**
- `vault-conventions` — tool discovery, corporate vs agency vault shapes, sourcing rules, the connector-permission trap
- `copy-check` — pre-ship gate returning findings and a PASS/FAIL verdict
- `vault-update-request` — filing corrections that survive review
- `vault-onboarding` — non-technical first session

Vault skills discover tools by name suffix, so they work against unprefixed and namespaced servers alike, and degrade gracefully with no connector attached.
