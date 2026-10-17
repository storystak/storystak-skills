#!/usr/bin/env bash
# finish.sh: turn a raw paper render into a page-ready WebP.
#
#   1. crop wide, so the subject fills no more than --fill of the frame
#   2. scale each channel so the crop's top strip matches the page ground
#   3. export WebP at twice the displayed width
#
# usage: bash finish.sh IN.png OUT.webp [options]
#
#   --display PX   width the image is shown at, in CSS px; output is 2x that
#                  (never upscaled past the crop). Default: the crop's own width.
#   --aspect W:H   crop aspect, e.g. 16:9, 4:3, 1:1 (default 16:9)
#   --fill F       the subject spans at most F of the crop's width and height
#                  (default 0.70; the page's edge fade eats anything wider)
#   --crop GEOM    explicit crop WxH+X+Y in source pixels; skips subject detection
#   --match C      ground colour the top strip is matched to: a hex like EFE8E0,
#                  "white" (for pieces that sit on white with multiply), or
#                  "none" (default EFE8E0, the page cream)
#   --gain R,G,B   apply this per-channel gain instead of measuring one
#   --quality Q    WebP quality (default 84)
#
# Prints the crop and gain it used. A cut-out (an image with transparency) has
# no ground to measure, so it needs --crop and --gain: pass the still's values
# and the part lands in the still's frame and colour.
#
# Bash only: run it as `bash finish.sh ...`, never source it into zsh.

if [ -z "${BASH_VERSION:-}" ]; then
  echo "finish.sh: run this with bash (bash finish.sh ...), not zsh" >&2
  return 2 2>/dev/null || exit 2
fi
set -euo pipefail

die() { echo "finish.sh: $*" >&2; exit 1; }
calc() { awk "BEGIN { printf \"%.6f\", $1 }"; }
int() { awk "BEGIN { printf \"%d\", ($1) + 0.5 }"; }
is()  { awk "BEGIN { exit !($1) }"; }

command -v magick >/dev/null 2>&1 || die "needs ImageMagick 7 (the magick command)"

[ $# -ge 2 ] || { sed -n '2,26p' "$0" | sed 's/^# \{0,1\}//'; exit 2; }
in=$1; out=$2; shift 2
[ -f "$in" ] || die "no such file: $in"

display=""; aspect="16:9"; fill="0.70"; crop=""; match="EFE8E0"; gain=""; quality=84
while [ $# -gt 0 ]; do
  case "$1" in
    --display) display=$2; shift 2 ;;
    --aspect)  aspect=$2;  shift 2 ;;
    --fill)    fill=$2;    shift 2 ;;
    --crop)    crop=$2;    shift 2 ;;
    --match)   match=$2;   shift 2 ;;
    --gain)    gain=$2;    shift 2 ;;
    --quality) quality=$2; shift 2 ;;
    *) die "unknown option: $1" ;;
  esac
done

read -r W H opaque < <(magick "$in" -format '%w %h %[opaque]\n' info:)
alpha=0; [ "$opaque" = "True" ] || alpha=1
if [ "$alpha" = 1 ]; then
  [ -n "$crop" ] && [ -n "$gain" ] || die "$in has transparency: pass the still's --crop and --gain"
fi

# 1. Crop. Find the subject by its difference from the ground, then grow the
#    box to the aspect with the subject at --fill, centred, kept inside the frame.
if [ -z "$crop" ]; then
  aw=${aspect%%:*}; ah=${aspect##*:}
  ground=$(magick "$in" -crop 100%x6%+0+0 +repage -scale '1x1!' -format '%[hex:p{0,0}]' info:)
  bbox=$(magick "$in" -blur 0x3 \( +clone -fill "#$ground" -colorize 100 \) \
    -compose difference -composite -colorspace gray -threshold 7% -format '%@' info:)
  bw=${bbox%%x*}; rest=${bbox#*x}; bh=${rest%%+*}; rest=${rest#*+}; bx=${rest%%+*}; by=${rest#*+}
  if is "$bw * $bh > 0.9 * $W * $H"; then
    echo "finish.sh: warning: could not separate the subject from the ground; cropping the whole frame" >&2
    bw=$W; bh=$H; bx=0; by=0
  fi
  cw=$(calc "$bw / $fill"); ch=$(calc "$bh / $fill")
  if is "$cw / $ch > $aw / $ah"; then ch=$(calc "$cw * $ah / $aw"); else cw=$(calc "$ch * $aw / $ah"); fi
  # The frame bounds the crop; shrink it (keeping the aspect) if it will not fit.
  k=$(calc "($cw > $W || $ch > $H) ? (($W / $cw < $H / $ch) ? $W / $cw : $H / $ch) : 1")
  if is "$k < 0.999"; then
    echo "finish.sh: warning: the subject is too big for --fill $fill at $aspect; it will fill $(calc "$fill / $k" | cut -c1-4) of the crop" >&2
    cw=$(calc "$cw * $k"); ch=$(calc "$ch * $k")
  fi
  cw=$(int "$cw"); ch=$(int "$ch")
  x=$(int "$bx + $bw / 2 - $cw / 2"); y=$(int "$by + $bh / 2 - $ch / 2")
  x=$(int "($x < 0) ? 0 : (($x + $cw > $W) ? $W - $cw : $x)")
  y=$(int "($y < 0) ? 0 : (($y + $ch > $H) ? $H - $ch : $y)")
  crop="${cw}x${ch}+${x}+${y}"
fi
cw=${crop%%x*}

# 2. Gain. Measure the top strip of the crop against the target ground.
if [ -z "$gain" ]; then
  case "$match" in
    none)  gain="1,1,1" ;;
    white) target="FFFFFF" ;;
    *)     target=${match#\#} ;;
  esac
  if [ -z "$gain" ]; then
    [[ "$target" =~ ^[0-9A-Fa-f]{6}$ ]] || die "--match wants a 6-digit hex, white or none"
    tr=$(calc "$((16#${target:0:2})) / 255"); tg=$(calc "$((16#${target:2:2})) / 255"); tb=$(calc "$((16#${target:4:2})) / 255")
    read -r mr mg mb < <(magick "$in" -crop "$crop" +repage -crop 100%x14%+0+0 +repage \
      -format '%[fx:mean.r] %[fx:mean.g] %[fx:mean.b]\n' info:)
    gain="$(calc "$tr / $mr"),$(calc "$tg / $mg"),$(calc "$tb / $mb")"
  fi
fi
IFS=, read -r kr kg kb <<<"$gain"

# 3. Export at 2x the displayed width, never upscaling.
width=$cw
if [ -n "$display" ]; then
  width=$((display * 2))
  if [ "$width" -gt "$cw" ]; then
    echo "finish.sh: warning: 2x of --display $display is ${width}px but the crop is ${cw}px; exporting at ${cw}px (render at 2K for larger)" >&2
    width=$cw
  fi
fi

magick "$in" -crop "$crop" +repage \
  -channel R -evaluate multiply "$kr" -channel G -evaluate multiply "$kg" \
  -channel B -evaluate multiply "$kb" +channel \
  -resize "${width}x" -quality "$quality" -define webp:method=6 "$out"

read -r ow oh < <(magick "$out" -format '%w %h\n' info:)
printf 'crop=%s gain=%s -> %s (%sx%s, %s KB)\n' "$crop" "$gain" "$out" "$ow" "$oh" \
  "$(( $(wc -c <"$out") / 1024 ))"
