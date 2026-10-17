#!/usr/bin/env bash
# fit.sh: put a cut-out part back exactly where it sits in the still.
#
# A "keep ONLY <part>" edit keeps the part close to its place in the still,
# within a few percent, but not exactly. This searches scale and centre for the
# placement that best matches the still inside the part (at half resolution,
# coarse then fine), then writes the part on a transparent canvas the size of
# the still, ready for finish.sh with the still's --crop and --gain.
#
# usage: bash fit.sh STILL.png CUT.png OUT.png [options]
#
#   STILL   the raw, uncropped render the part was edited from
#   CUT     the part after background removal (transparent PNG, any size)
#   OUT     the fitted part, the still's size, transparent elsewhere
#
#   --range R   scale searched is the starting scale +/- R (default 0.06)
#   --shift PX  centre searched is the start +/- PX in still pixels (default 16)
#
# Also writes OUT-check.png: the still with the fitted part laid over it at
# half opacity. Any ghosting there is misalignment; look before you ship.
#
# Bash only: run it as `bash fit.sh ...`, never source it into zsh.

if [ -z "${BASH_VERSION:-}" ]; then
  echo "fit.sh: run this with bash (bash fit.sh ...), not zsh" >&2
  return 2 2>/dev/null || exit 2
fi
set -euo pipefail

die() { echo "fit.sh: $*" >&2; exit 1; }
calc() { awk "BEGIN { printf \"%.6f\", $1 }"; }
int() { awk "BEGIN { v = $1; printf \"%d\", (v < 0) ? v - 0.5 : v + 0.5 }"; }
is()  { awk "BEGIN { exit !($1) }"; }
steps() { awk -v a="$1" -v b="$2" -v s="$3" 'BEGIN { for (v = a; v <= b + s / 2; v += s) printf "%.4f ", v }'; }

command -v magick >/dev/null 2>&1 || die "needs ImageMagick 7 (the magick command)"

[ $# -ge 3 ] || { sed -n '2,22p' "$0" | sed 's/^# \{0,1\}//'; exit 2; }
still=$1; cut=$2; out=$3; shift 3
[ -f "$still" ] || die "no such file: $still"
[ -f "$cut" ] || die "no such file: $cut"

range=0.06; shift_px=16
while [ $# -gt 0 ]; do
  case "$1" in
    --range) range=$2; shift 2 ;;
    --shift) shift_px=$2; shift 2 ;;
    *) die "unknown option: $1" ;;
  esac
done

T=$(mktemp -d "${TMPDIR:-/tmp}/fit.XXXXXX")
trap 'rm -rf "$T"' EXIT

read -r SW SH < <(magick "$still" -format '%w %h\n' info:)
read -r CW CH opaque < <(magick "$cut" -format '%w %h %[opaque]\n' info:)
[ "$opaque" = "False" ] || die "$cut has no transparency: run it through background removal first"

# The part's own box, padded, is what gets scaled and placed.
bbox=$(magick "$cut" -alpha extract -threshold 50% -format '%@' info:)
bw=${bbox%%x*}; rest=${bbox#*x}; bh=${rest%%+*}; rest=${rest#*+}; bx=${rest%%+*}; by=${rest#*+}
[ "$bw" -gt 0 ] && [ "$bh" -gt 0 ] || die "$cut is empty after background removal"
pad=6
magick "$cut" -background none -extent "$((CW + 2 * pad))x$((CH + 2 * pad))-$pad-$pad" \
  -crop "$((bw + 2 * pad))x$((bh + 2 * pad))+$bx+$by" +repage "$T/piece.png"

# Start where the part already is, mapped into the still's frame.
s0=$(calc "$SW / $CW")
cx0=$(calc "($bx + $bw / 2) * $s0"); cy0=$(calc "($by + $bh / 2) * $s0")

magick "$still" -alpha off -resize 50% "$T/still.png"
magick "$T/piece.png" -resize 50% "$T/half.png"
read -r HW HH < <(magick "$T/still.png" -format '%w %h\n' info:)

best=""; bs=$s0; bx_=$cx0; by_=$cy0
scaled_for=""
try() { # scale, centre x, centre y (still pixels)
  local s=$1 cx=$2 cy=$3
  if [ "$scaled_for" != "$s" ]; then
    magick "$T/half.png" -resize "$(calc "$s * 100")%" "$T/pp.png"
    read -r pw ph am < <(magick "$T/pp.png" -format '%w %h %[fx:mean.a]\n' info:)
    scaled_for=$s
  fi
  local ox oy
  ox=$(int "$cx / 2 - $pw / 2"); oy=$(int "$cy / 2 - $ph / 2")
  # A placement that runs off the still cannot be scored; skip it.
  [ "$ox" -ge 0 ] && [ "$oy" -ge 0 ] && [ $((ox + pw)) -le "$HW" ] && [ $((oy + ph)) -le "$HH" ] || return 0
  local m e
  m=$(magick "$T/still.png" -crop "${pw}x${ph}+${ox}+${oy}" +repage \
    \( "$T/pp.png" -alpha off \) -compose difference -composite -colorspace gray \
    \( "$T/pp.png" -alpha extract \) -compose multiply -composite -format '%[fx:mean]' info:)
  e=$(calc "$m / $am")
  if [ -z "$best" ] || is "$e < $best"; then best=$e; bs=$s; bx_=$cx; by_=$cy; fi
}

# Coarse: 7 scales x 5 x 5 centres. Fine: 3 scales x 7 x 7 around the best.
c=$(calc "$shift_px / 2")
for s in $(steps "$(calc "$s0 - $range")" "$(calc "$s0 + $range")" 0.02); do
  for dx in $(steps "-$shift_px" "$shift_px" "$c"); do
    for dy in $(steps "-$shift_px" "$shift_px" "$c"); do
      try "$s" "$(calc "$cx0 + $dx")" "$(calc "$cy0 + $dy")"
    done
  done
done
[ -n "$best" ] || die "every placement ran off the still; is CUT from this still?"
s1=$bs; x1=$bx_; y1=$by_
for s in $(steps "$(calc "$s1 - 0.01")" "$(calc "$s1 + 0.01")" 0.01); do
  for dx in -6 -4 -2 0 2 4 6; do
    for dy in -6 -4 -2 0 2 4 6; do
      try "$s" "$(calc "$x1 + $dx")" "$(calc "$y1 + $dy")"
    done
  done
done

# Place the full-resolution part at the best scale and centre.
magick "$T/piece.png" -resize "$(calc "$bs * 100")%" "$T/final.png"
read -r fw fh < <(magick "$T/final.png" -format '%w %h\n' info:)
ox=$(int "$bx_ - $fw / 2"); oy=$(int "$by_ - $fh / 2")
gx=$( [ "$ox" -ge 0 ] && echo "+$ox" || echo "$ox" ); gy=$( [ "$oy" -ge 0 ] && echo "+$oy" || echo "$oy" )
magick -size "${SW}x${SH}" xc:none "$T/final.png" -geometry "$gx$gy" -compose over -composite "$out"

check="${out%.*}-check.png"
magick "$still" \( "$out" -channel A -evaluate multiply 0.5 +channel \) -compose over -composite "$check"

printf 'scale=%s centre=(%s,%s) err=%s -> %s (check: %s)\n' \
  "$(calc "$bs" | cut -c1-6)" "$(int "$bx_")" "$(int "$by_")" "$(calc "$best" | cut -c1-6)" "$out" "$check"
