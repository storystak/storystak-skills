# Versions

Current version of every skill in this repo. Machine-readable on purpose — an
agent can compare these against its local copies to check for updates.

Plugin version: **0.1.2**

| Skill | Version | Last updated |
|---|---|---|
| copy-check | 1.0.0 | 2026-08-09 |
| full-output-enforcement | 1.0.0 | 2026-08-09 |
| storystak-anti-slop-design | 1.0.0 | 2026-08-09 |
| storystak-cro | 1.0.0 | 2026-08-09 |
| vault-conventions | 1.1.0 | 2026-08-09 |
| vault-onboarding | 1.0.0 | 2026-08-09 |
| vault-update-request | 1.0.0 | 2026-08-09 |

Skill versions move independently of the plugin version. The plugin version in
`.claude-plugin/plugin.json` is the **only** update signal installed users
receive — bump it on every release or nobody gets the change.
