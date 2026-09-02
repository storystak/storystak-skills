#!/usr/bin/env bash
# Validate every skill in skills/ before it ships.
#
# Four classes of check:
#   1. Structure    — SKILL.md exists, has frontmatter, name matches its directory
#   2. Privacy      — no client, personal, or internal reference reaches a public repo
#   3. Containment  — no INTERNAL-marked skill or private-doctrine reference ships
#   4. References   — no skill points at a skill that isn't in this repo
#
# Exit 1 on any failure. Wired to CI on every PR.

set -uo pipefail
cd "$(dirname "$0")"

fail=0
err() { printf '  \033[31mFAIL\033[0m %s\n' "$1"; fail=1; }
ok()  { printf '  \033[32mok\033[0m   %s\n' "$1"; }

# Anything that would leak a client, a person, or internal infrastructure.
# Add to these lists; never remove from one without a reason in the commit message.
#
# Case-INSENSITIVE terms.
#
# The real list of client and personal names is deliberately NOT in this file.
# A public repo containing "block any mention of A, B, C, D" publishes the
# roster it was written to protect — a worse leak than the one it prevents.
#
# Supply the private terms one of two ways, both invisible to this repo:
#   - a .private-denylist file in the repo root (gitignored), one regex
#     alternation per line, blank lines and # comments ignored
#   - a PRIVATE_DENYLIST env var holding the same pattern (used in CI)
# Without either, the generic checks below still run.
#
# NOTE ON THE LIMIT OF THIS APPROACH: a keyword list only catches names it
# already knows. A real founder's name once shipped in a worked example here
# and passed every check, because the line named neither his company nor any
# other listed term. Company names are the easy half; PEOPLE and their
# biographical details are the half that gets through. Read the examples in a
# skill for identifiable real details rather than trusting a green run here.
DENYLIST='localhost:[0-9]|127\.0\.0\.1|api[_-]?key|secret[_-]?key|-----BEGIN'
if [ -n "${PRIVATE_DENYLIST:-}" ]; then
  DENYLIST="$DENYLIST|$PRIVATE_DENYLIST"
  private_source="PRIVATE_DENYLIST env var"
elif [ -f .private-denylist ]; then
  extra=$(grep -vE '^\s*(#|$)' .private-denylist | paste -sd'|' -)
  [ -n "$extra" ] && DENYLIST="$DENYLIST|$extra"
  private_source=".private-denylist"
else
  private_source=""
fi
# Case-SENSITIVE: local filesystem paths. Kept separate because a
# case-insensitive '/Users/' also matches ordinary prose like
# "customers/users/clients served".
DENYLIST_CS='/Users/|/home/[a-z]|~/\.claude'

echo "==> Structure"
shopt -s nullglob
dirs=(skills/*/)
[ ${#dirs[@]} -eq 0 ] && { err "no skills found under skills/"; exit 1; }

for d in "${dirs[@]}"; do
  slug=$(basename "$d")
  f="$d/SKILL.md"

  [ -f "$f" ] || { err "$slug: no SKILL.md"; continue; }
  head -1 "$f" | grep -qx -- '---' || { err "$slug: SKILL.md does not open with frontmatter"; continue; }

  name=$(awk '/^---$/{n++; next} n==1 && /^name:/{sub(/^name:[[:space:]]*/,""); print; exit}' "$f")
  desc=$(awk '/^---$/{n++; next} n==1 && /^description:/{print "y"; exit}' "$f")

  [ "$name" = "$slug" ] || err "$slug: frontmatter name is '$name', must match directory"
  [ -n "$desc" ]        || err "$slug: frontmatter has no description"
  ok "$slug"
done

echo "==> Privacy"
privacy_clean=1
if hits=$(grep -rniE "$DENYLIST" skills/ 2>/dev/null); then
  err "client or personal reference(s) found:"
  printf '%s\n' "$hits" | sed 's/^/       /'
  privacy_clean=0
fi
if hits=$(grep -rnE "$DENYLIST_CS" skills/ 2>/dev/null); then
  err "local filesystem path(s) found:"
  printf '%s\n' "$hits" | sed 's/^/       /'
  privacy_clean=0
fi
if [ $privacy_clean -eq 1 ]; then
  if [ -n "$private_source" ]; then
    ok "no client, personal, or internal references (private terms from $private_source)"
  else
    ok "generic checks pass"
    printf '  \033[33mWARN\033[0m no private denylist found — client and personal\n'
    printf '       names are NOT being checked. See .private-denylist.example\n'
  fi
fi

echo "==> Internal containment"
# Some skills are internal procedure and must never reach a client surface.
# The convention marking them is the all-caps word INTERNAL in the frontmatter
# description ("INTERNAL — never ship..."), and internal skills reference
# private doctrine by path. A marking enforced by nothing is a label, not a
# control (assessed 2026-08-15; the 2026-08-09 vendored-skill leak is the
# precedent) — this check is the enforcement.
#
# Case-SENSITIVE on purpose: prose "Internal linking" is legitimate; the
# all-caps marking and `doctrine/` paths are not. The private OS-repo names
# this check also needs to block are carried by the private denylist above,
# NOT written here — this file is public, and naming the repos it protects
# would publish the reference it exists to prevent.
containment_clean=1
if hits=$(grep -rnE '\bINTERNAL\b|\bdoctrine/' skills/ 2>/dev/null); then
  err "INTERNAL-marked content or doctrine reference(s) found — this content"
  err "is internal procedure and must not ship to any consumer:"
  printf '%s\n' "$hits" | sed 's/^/       /'
  containment_clean=0
fi
[ $containment_clean -eq 1 ] && ok "no INTERNAL-marked skills or doctrine references"

echo "==> Version parity"
# The plugin version is the ONLY update signal an installed copy receives.
# It went unbumped through two releases (0.2.0 and the 2026-08-25 rename), so
# every plugin installed from this repo kept serving Vault-named skills for a
# week. Three places state a version; they must agree, or the release is a
# label on nothing.
pj_version=$(python3 -c 'import json;print(json.load(open(".claude-plugin/plugin.json"))["version"])' 2>/dev/null)
vm_version=$(grep -oE '^Plugin version: \*\*[0-9.]+\*\*' VERSIONS.md | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
[ -n "$pj_version" ] || err "plugin.json has no readable version"
[ -n "$vm_version" ] || err "VERSIONS.md has no 'Plugin version: **x.y.z**' line"
if [ -n "$pj_version" ] && [ -n "$vm_version" ]; then
  [ "$pj_version" = "$vm_version" ] && ok "plugin.json $pj_version == VERSIONS.md $vm_version" \
    || err "plugin.json says $pj_version but VERSIONS.md says $vm_version — bump both, or nobody gets the release"
fi
grep -q "^## $pj_version " CHANGELOG.md \
  && ok "CHANGELOG.md has a $pj_version entry" \
  || err "CHANGELOG.md has no '## $pj_version' entry — a version with no changelog is a number, not a release"
parity_clean=1
for d in "${dirs[@]}"; do
  slug=$(basename "$d")
  fm=$(awk '/^---$/{n++; next} n==1 && /^[[:space:]]*version:/{sub(/^[[:space:]]*version:[[:space:]]*/,""); print; exit}' "$d/SKILL.md")
  tbl=$(grep -E "^\| $slug \|" VERSIONS.md | awk -F'|' '{gsub(/ /,"",$3); print $3}')
  if [ -z "$tbl" ]; then err "$slug: not in the VERSIONS.md table"; parity_clean=0
  elif [ "$fm" != "$tbl" ]; then err "$slug: SKILL.md says $fm, VERSIONS.md says $tbl"; parity_clean=0
  fi
done
[ $parity_clean -eq 1 ] && ok "every skill's frontmatter version matches the VERSIONS.md table"

echo "==> Cross-references"
# Every `skill-name` in backticks that looks like one of ours must exist.
known=$(for d in "${dirs[@]}"; do basename "$d"; done)
dangling=$(grep -rhoE '`(stak|copy|storystak|full)-[a-z-]+`' skills/ 2>/dev/null \
  | tr -d '`' | sort -u \
  | while read -r ref; do grep -qx "$ref" <<<"$known" || echo "$ref"; done)
if [ -n "$dangling" ]; then
  err "reference(s) to skills not in this repo:"
  printf '%s\n' "$dangling" | sed 's/^/       /'
else
  ok "all skill cross-references resolve"
fi

echo
[ $fail -eq 0 ] && echo "PASS — ${#dirs[@]} skills" || echo "FAILED"
exit $fail
