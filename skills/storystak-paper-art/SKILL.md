---
name: storystak-paper-art
description: Make images in the Storystak house style, isometric shapes built as tactile handmade paper and clay and photographed in soft light, in the brand palette. Use for any new Storystak image, including site section art, article header art, a hub or feature illustration, social or share cards, deck visuals, or a paper version of the Stak logo. Trigger on requests like "make an image for this section", "header art for the article", "paper version of the logo", "an illustration of kits, workflows and systems", "match the paper style", "make it look like the home page art", or "explode the Stak into parts", even when the user never says "paper" or "isometric", because this is the default look for Storystak imagery. Covers the fixed STYLE block, palette, subject vocabulary, the logo-reference step, the model and route, finishing (wide crop, colour-match to the page cream, WebP at 2x), and splitting a still into separable parts that reassemble exactly. Not for client brands, which carry their own look, and never for proof imagery such as a real client, result or person.
metadata:
  version: 1.0.0
---

# Storystak paper art

The house image style: the plates, cubes, strips and the logo-shaped Stak from Storystak's flat isometric line art, rendered as a photographed miniature built from thick cardstock and modelling clay. Storystak is software; paper makes it feel like a real object. The flat line art stays the blueprint, and paper is the finish.

Every piece is a still unless a page needs motion. The method below makes new pieces match the shipped ones. The constant parts (STYLE block, palette, finishing) stay constant: change only the subject.

`examples/stak-sheets.webp` is a finished piece made with exactly this method: the Stak with a stack of sheets on its front panel, joined by a strip to a cube on the right panel. Compare new renders against it.

## When to use it, and when not

Use it for any new Storystak image: page sections, article headers, hub icons, share cards, deck art.

Do not use it for:

- **Client work.** A client's imagery follows the client's brand.
- **Proof.** No piece may stand in for a real client, a real result, a screenshot or a person. It shows an idea, never evidence.
- **Anything that needs words in the image.** Text goes in the page, never in the render.

## The look

| Role | Hex | Where it goes |
|---|---|---|
| Ground | `#EFE8E0` | the seamless backdrop, and the page cream the finished image is matched to |
| Tops | `#FCF7F5` | the top face of every plain piece |
| Sides | `#EAD9CE` | the cut sides of plain pieces |
| Focal | `#C45D2C` | terracotta, **one** focal piece per image (the Stak's slab when the Stak is in it) |
| Accent | `#210F07` | coffee brown, for strips and small accents only |

Strict isometric (30-degree axes, no perspective), soft daylight from the upper left, soft contact shadows, generous empty space. No text, no letters, no people, no faces, no logos other than the Stak itself.

## The prompt: STYLE + SUBJECT + FRAME

### STYLE (word for word, every image)

> Tactile handmade miniature diorama, photographed. Every object is built from thick matte cardstock and soft modelling clay: visible paper fibre texture, slightly rounded hand-cut edges, tiny imperfections, thin paper laminations visible on the cut sides. Strict isometric view (30-degree axes, no perspective distortion). Soft diffuse studio daylight from the upper left, gentle ambient occlusion and soft contact shadows on the ground. Palette strictly limited to: warm cream ground #EFE8E0, off-white tops #FCF7F5, pale blush sides #EAD9CE, terracotta #C45D2C for the single focal piece, deep coffee brown #210F07 accents. Plain seamless cream backdrop, generous empty space around the subject. No text, no letters, no logos, no people, no faces.

**When the logo reference is attached**, replace the last sentence with `No outlines, no black lines, no text, no letters, no people.` "No logos" fights the reference and the model draws the logo's outline instead of the object.

Do not paraphrase, shorten or "improve" the block. Matching the shipped set depends on it being identical.

### SUBJECT (the only part you write)

Plain shapes only, from this vocabulary (the same primitives the flat line art uses):

| Shape | How to say it |
|---|---|
| plate / slab | "a thin off-white plate", "a terracotta slab" |
| block, tower | "an off-white block", "a tower of three stacked blocks" |
| cube | "a small off-white cube" |
| sheet | "a stack of three loose off-white paper sheets" |
| record, archive | "a short off-white cylinder" |
| tray | "an off-white open tray" |
| strip | "a thin coffee-brown strip running from A across the groove to B": strips join pieces into one system |
| the Stak | always the logo mark, built from the reference (below) |

Rules for the subject:

- **One terracotta piece.** Everything else is off-white with blush sides, and coffee only for strips and small accents.
- **Say what sits on what.** "On the square front panel rests...", "a small gap above an open tray". Position words are what the model holds onto.
- **End with "Nothing else."** It stops the model from decorating.
- Never ask for screens, devices, charts with numbers, buildings, plants or people. They break the vocabulary.

### The Stak (the logo, as a paper object)

The Stak is never invented. Attach the real logo, `https://storystak.com/apple-touch-icon.png`, as a reference image and say:

> Build the object shown in the reference logo as a real, physical paper model, keeping its shape faithfully: a terracotta upper slab whose top is split by grooves into three panels (a long panel along the back-left edge, a square panel at the front, a small panel on the right), floating a small gap above an off-white open tray.

Then put things on the panels. When a scene shows kits, workflows and systems, workflows go on the long back panel, kits on the square front panel and systems on the small right panel, joined by coffee strips that meet across the grooves, so the three read as one system.

**Check every render against the logo.** A mirrored panel layout (the long panel on the right, say) is wrong, however good the paper looks. Regenerate rather than ship it.

### FRAME

Say the aspect in words, and ask for room:

> FRAME: Wide 16:9 landscape frame, subject centred and small, taking up about half the frame width, lots of plain cream space all around it.

The finishing crop needs that space (see below). A subject that fills the render cannot be cropped wide.

## Model and route

**GPT Image 2.5 (Sunburst)**, model id `gpt-image-2.5-sunburst`, through the **ElevenLabs** connector's creative tools. In head-to-head tests it beat GPT Image 2 (true isometric, visible grain, laminations, palette held), Nano Banana (lower camera, smooth clay, and it read "plates" as dinner plates) and FLUX 3 (perspective, and it misdrew the logo).

The tools are matched by suffix, since the prefix differs by host:

1. `creative_create_flow`: one flow per piece, so the reference and every edit can be wired together.
2. `creative_attach_reference_file` with the logo URL and the `flow_id` (Stak pieces only). It returns a `node_id`.
3. `creative_generate_image` with `model_id: gpt-image-2.5-sunburst`, the prompt, `generations_count` 1 or 2 (the default is 4, which bills 4), and `connect_from: [<reference node_id>]` when the logo is attached.
4. `creative_get_flow_run_status` with the `flow_id` and `session_ids` until it completes. The result carries a signed download URL, valid for about 2 hours.
5. Download it right away: `curl -sf -o renders/<name>.png "<url>"`. **Quote the URL.** It contains `?` and `&`, and unquoted it fails in zsh ("no matches found") or gets cut at the `&`.

The model returns 16:9 at 1280x720 unless told otherwise; the node's `aspect_ratio` and `resolution` parameters change that (`creative_update_node`). Ask for `2K` when the image will be shown wider than about 640 CSS px, since finishing exports at 2x and never upscales.

**Cost:** about $0.07 per image, about $0.16 with the logo reference attached. Estimate first (`estimate_only: true`) for anything over a handful.

Another host's GPT Image 2.5 Sunburst gives the same output, since it is the same model. Higgsfield's matched the shipped set in a side-by-side test (isometric, grain, palette, logo layout) for about a third of the per-image cost. The STYLE block, reference step and finishing do not change. Only the ElevenLabs route has been tested end to end, including the edit and background-removal steps.

## Finishing

`scripts/finish.sh` does all three steps, and prints the crop and gain it used:

```bash
bash scripts/finish.sh renders/stak.png assets/stak.webp --display 480
```

1. **Crop wide.** The subject fills at most 70% of the crop's width and height (`--fill`), at the aspect you pass (`--aspect`, default 16:9). A page's soft edge fade eats anything tighter. If the subject is too big for that, the script says how much it will fill instead. Re-render with more space rather than ship a cramped crop.
2. **Colour-match.** It scales each channel so the crop's top strip equals the page cream `#EFE8E0`, so the image's ground disappears into the page. For a piece that sits on white (a disc or card, with `mix-blend-mode: multiply`), pass `--match white`.
3. **WebP at 2x.** Quality 84, at twice `--display` (the CSS width it is shown at). It never upscales; it warns instead.

Run the script with `bash`, from this skill's directory or by full path. It is bash, not zsh: calling it with `bash` works from any shell, and pasting its body into a zsh prompt does not (zsh does not word-split, and treats `=word` and `?` specially).

## Separable parts (an exploded view)

When a page needs the pieces of a still to move independently (the Stak coming apart like a watch, say), each part becomes its own clean cut-out, put back exactly where it sits in the still.

1. **Isolate by edit, one part at a time.** Attach the still as a reference on the same flow (`creative_attach_reference_file`, or the still's own node id) and run `creative_edit_image` with `gpt-image-2.5-sunburst`:
   > Keep ONLY the <part>, exactly where it is, same size, same angle, same light. Replace everything else with plain cream. No ground, no shadow, no other objects.

   Say what to **keep**, never what to remove: a "remove X" edit can silently drop other features (one lost a groove). For the slab, keep its strips (ending in small pads) and both grooves; for the tray, show its empty floor. The model keeps each part within a few percent of its place, never exactly.
2. **Cut out with a real model.** Run each edit through background removal: `creative_edit_image` with `model_id: birefnet-v2-bg-removal`, `connect_from` the edit's node. **Never cut parts out of the still with colour or difference masks.** Small pieces come out ragged, and no amount of feathering saves them.
3. **Fit back onto the still:**

   ```bash
   bash scripts/fit.sh renders/still.png renders/cut-kits.png renders/fit-kits.png
   ```

   It searches scale and centre for the best match to the still inside the part (half resolution, coarse then fine) and writes the part on a transparent canvas the still's size. It also writes `fit-kits-check.png`, the still with the part at half opacity. Look at it: any ghosting is misalignment.
4. **Finish each part exactly like the still.** Use the crop and gain finish.sh printed for the still:

   ```bash
   bash scripts/finish.sh renders/fit-kits.png assets/stak-x-kits.webp \
     --crop 1016x720+210+0 --gain 1.0125,1.0227,1.0277 --display 480
   ```

   Every part then sits in the same frame as the still and overlays it pixel for pixel. On the page, crossfade from the still to the parts as they start to move, so the assembled Stak keeps its real contact shadows.

## Before you ship

- [ ] STYLE block identical to the one above (logo variant if the reference was attached)
- [ ] One terracotta piece; no text, letters, people, faces or stray logos in the render
- [ ] Stak pieces checked against the logo: long panel back-left, square panel front, small panel right
- [ ] Finished with `finish.sh`: subject within about 70% of the crop, ground matched, WebP at 2x
- [ ] Separable parts: cut by edit plus background removal, fitted, check image looked at
- [ ] Nothing in the image is presented as a real client, result or person

## Requirements

ImageMagick 7 (`magick`), bash 3.2 or later (the macOS default is fine), `awk`, `curl`. Image generation needs the ElevenLabs connector with its image tools authorised; without it, write the full prompt (STYLE, SUBJECT, FRAME) for whoever has access, and finish their render with the scripts.
