# Contributing

## Before you open a PR

```bash
./validate-skills.sh
```

It must pass. CI runs the same script on every PR.

## What it checks

**Structure** — every skill is a directory under `skills/` containing `SKILL.md` with YAML frontmatter. The frontmatter `name` must match the directory name exactly.

**Privacy** — this repo is public. The validator blocks internal infrastructure and local filesystem paths, plus a private list of client and personal names supplied out-of-band: copy `.private-denylist.example` to `.private-denylist` (gitignored), or set `PRIVATE_DENYLIST` in the environment. The names are deliberately not in the tree, because a public file saying "block any mention of A, B, C" publishes the roster it exists to protect.

If you hit a false positive, tighten the pattern rather than dropping the term. The path checks are case-sensitive on purpose: a case-insensitive `/Users/` also matches prose like "customers/users/clients."

**A green run is not proof.** A keyword list only catches names it already knows, and the leak that got furthest through this repo was a real founder's name in a worked example — no company name on the line, nothing for the list to match. Company names are the easy half. Read every example for identifiable real people, quotes, and biographical detail before you ship it.

**Cross-references** — a skill referencing `` `some-skill` `` fails the build if `some-skill` isn't in this repo. Skills that point at things which don't exist are worse than skills that point at nothing.

## Writing a skill

**The description is the trigger.** It's how the model decides whether to load the skill at all, so write it as a long list of the situations and phrasings that should activate it — including the ways a frustrated user actually phrases the problem, not just the formal term. Cross-reference sibling skills so the model can route to the right one.

**Keep `SKILL.md` under ~500 lines.** Longer material belongs in `references/`, loaded on demand.

**Version independently.** Each skill carries `metadata.version` in frontmatter. Bump it when you change the skill and update `VERSIONS.md`.

**Assume no Vault.** The Vault skills must degrade gracefully when no connector is attached — say so once and do what's possible unaided. Strangers install this plugin.

**Never hardcode a Vault tool name.** Match on the suffix. Tools are unprefixed on some servers and namespaced on others.

## Releasing

Bump `version` in `.claude-plugin/plugin.json` — **only** there, never also in the marketplace entry, since `plugin.json` silently wins. That string is the sole update signal installed users receive; push without bumping it and nobody gets the change. Update `CHANGELOG.md` and `VERSIONS.md` in the same commit.
