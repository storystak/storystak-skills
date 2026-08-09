#!/usr/bin/env bash
# Push skills/ from this repo out to every consumer, and bump their versions.
#
# This repo is canonical. Consumers vendor a copy: client plugin repos ship it
# to clients, vault MCP repos serve it over list_skills/get_skill. Each copy is
# a drift surface, and the version string is the ONLY update signal an
# installed client receives — a consumer that gets new skills without a version
# bump silently keeps serving the old ones.
#
# So syncing and bumping are one operation here, not two things to remember.
#
#   ./sync-consumers.sh              # dry run — show what would change
#   ./sync-consumers.sh --apply      # sync, bump, commit locally
#   ./sync-consumers.sh --apply --push
#   ./sync-consumers.sh --apply --minor
#
# Consumers are listed in `.consumers` (gitignored — see .consumers.example).
# That file names client repos, and a public file listing who the clients are
# would leak the roster this repo is careful not to publish.

set -uo pipefail
cd "$(dirname "$0")"
CANON=$(pwd)

APPLY=0; PUSH=0; BUMP="patch"
for a in "$@"; do
  case "$a" in
    --apply) APPLY=1 ;;
    --push)  PUSH=1 ;;
    --minor) BUMP="minor" ;;
    --patch) BUMP="patch" ;;
    -h|--help) sed -n '2,22p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown option: $a" >&2; exit 2 ;;
  esac
done
[ $PUSH -eq 1 ] && [ $APPLY -eq 0 ] && { echo "--push requires --apply" >&2; exit 2; }

bold() { printf '\033[1m%s\033[0m\n' "$1"; }
warn() { printf '  \033[33m%s\033[0m\n' "$1"; }
ok()   { printf '  \033[32m%s\033[0m\n' "$1"; }
err()  { printf '  \033[31m%s\033[0m\n' "$1"; }

# ---------------------------------------------------------------- preflight
#
# Never propagate a state this repo would not itself ship. A broken skill
# copied to three consumers is three times the cleanup.

bold "==> Preflight"
[ -f .consumers ] || { err "No .consumers file. Copy .consumers.example and fill it in."; exit 1; }

if [ -n "$(git status --porcelain -- skills/ 2>/dev/null)" ]; then
  err "skills/ has uncommitted changes. Commit them first — consumers must"
  err "vendor a committed state, or you cannot tell what they are running."
  exit 1
fi

if [ -f .private-denylist ]; then
  export PRIVATE_DENYLIST="$(grep -vE '^\s*(#|$)' .private-denylist | paste -sd'|' -)"
fi
if ! ./validate-skills.sh >/dev/null 2>&1; then
  err "validate-skills.sh fails here. Fix it before pushing to consumers:"
  ./validate-skills.sh 2>&1 | sed 's/^/     /' | tail -12
  exit 1
fi
CANON_SHA=$(git rev-parse --short HEAD)
ok "skills/ clean, validator passes, canonical at $CANON_SHA"
[ $APPLY -eq 0 ] && warn "DRY RUN — nothing will be written. Re-run with --apply."

# ------------------------------------------------------------------ consumers

bump_version() {  # $1 = plugin.json path
  python3 - "$1" "$BUMP" <<'PY'
import json, pathlib, sys
p, kind = pathlib.Path(sys.argv[1]), sys.argv[2]
d = json.loads(p.read_text())
major, minor, patch = (int(x) for x in d.get("version", "0.0.0").split("."))
if kind == "minor": minor, patch = minor + 1, 0
else: patch += 1
old, d["version"] = d.get("version"), f"{major}.{minor}.{patch}"
p.write_text(json.dumps(d, indent=2) + "\n")
print(f"{old} -> {d['version']}")
PY
}

TOTAL=0; CHANGED=0; DEPLOYERS=()
while IFS= read -r line; do
  line="${line%%#*}"; line="$(echo "$line" | xargs)"
  [ -z "$line" ] && continue
  REL="${line%%|*}"; FLAGS="${line#*|}"; [ "$FLAGS" = "$REL" ] && FLAGS=""
  DIR="$CANON/$REL"
  TOTAL=$((TOTAL+1))

  echo
  bold "==> $REL"
  [ -d "$DIR/.git" ] || { err "not a git repo — skipped"; continue; }
  [ -d "$DIR/skills" ] || warn "no existing skills/ — will be created"

  if [ -n "$(git -C "$DIR" status --porcelain 2>/dev/null)" ]; then
    err "working tree dirty — skipped (commit or stash there first)"
    continue
  fi

  if diff -rq "$CANON/skills" "$DIR/skills" >/dev/null 2>&1; then
    ok "skills already identical"
    SKILLS_CHANGED=0
  else
    SKILLS_CHANGED=1
    diff -rq "$CANON/skills" "$DIR/skills" 2>/dev/null | sed 's/^/     /' | head -8
  fi

  PJ="$DIR/.claude-plugin/plugin.json"
  IS_PLUGIN=0; [ -f "$PJ" ] && IS_PLUGIN=1

  if [ $SKILLS_CHANGED -eq 0 ]; then
    [ $IS_PLUGIN -eq 1 ] && ok "version left alone (nothing changed to signal)"
    continue
  fi
  CHANGED=$((CHANGED+1))

  case "$FLAGS" in *deploys*) DEPLOYERS+=("$REL") ;; esac

  if [ $APPLY -eq 0 ]; then
    warn "would sync skills/$( [ $IS_PLUGIN -eq 1 ] && echo ' and bump version' )"
    case "$FLAGS" in *deploys*) warn "NOTE: pushing this one redeploys production" ;; esac
    continue
  fi

  rm -rf "$DIR/skills"; mkdir -p "$DIR/skills"
  cp -R "$CANON/skills/." "$DIR/skills/"
  find "$DIR/skills" -name '.DS_Store' -delete
  ok "synced $(find "$DIR/skills" -name SKILL.md | wc -l | tr -d ' ') skills"

  MSG="Sync skills from canonical $CANON_SHA"
  if [ $IS_PLUGIN -eq 1 ]; then
    V=$(bump_version "$PJ")
    ok "version $V"
    MSG="$MSG; v${V##*> }"
  fi

  git -C "$DIR" add -A
  git -C "$DIR" -c user.name="Zach Worley" -c user.email="zach@storystak.com" \
    commit -q -m "$MSG

Vendored copy refreshed from storystak/storystak-skills at $CANON_SHA.
$( [ $IS_PLUGIN -eq 1 ] && echo "Version bumped in the same commit: it is the only update signal an
installed client receives, so new skills without a bump would silently never
reach them." )

Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>"
  ok "committed $(git -C "$DIR" rev-parse --short HEAD)"

  if [ $PUSH -eq 1 ]; then
    case "$FLAGS" in
      *deploys*) warn "NOT pushed — this repo redeploys production on push. Push it yourself:"
                 warn "  git -C $REL push" ;;
      *) git -C "$DIR" push -q && ok "pushed" || err "push failed" ;;
    esac
  fi
done < .consumers

# -------------------------------------------------------------------- summary
echo
bold "==> Summary"
echo "  $TOTAL consumer(s), $CHANGED needed a sync"
if [ $APPLY -eq 0 ]; then
  warn "dry run — re-run with --apply to write"
elif [ $PUSH -eq 0 ] && [ $CHANGED -gt 0 ]; then
  warn "committed locally, nothing pushed. Add --push, or push each yourself."
fi
if [ ${#DEPLOYERS[@]} -gt 0 ] && [ $CHANGED -gt 0 ]; then
  echo
  warn "These redeploy production when pushed — push them deliberately:"
  for d in "${DEPLOYERS[@]}"; do warn "  $d"; done
fi
