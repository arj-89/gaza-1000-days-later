# Gaza in 1,000 Days — static site

Single self-contained bilingual (Arabic RTL / English LTR) data page documenting Gaza across
roughly 1,000 days. Deployed at **https://gaza1000.bixet.tech**.

## Structure

```
public/
  index.html              # the page (was gaza-1000-days.html)
  thmanyah-fonts.css      # bundled Thmanyah @font-face (self-hosted, same-origin)
  fonts/*.woff2           # 15 Thmanyah files (3 families x 5 weights)
  icon.svg                # Palestine-flag favicon (drawn)
  favicon.ico             # 16/32/48 raster fallback
  apple-icon.png          # 180x180 apple-touch-icon
  data/*.geojson          # source geometry (occupied / remaining Palestine) — data only, not yet wired into the map
Dockerfile                # nginx:alpine, serves public/ on port 80
nginx.conf                # server block (cache headers + geojson mime)
```

## Build / run

No build step. The Docker image is just nginx serving `public/`:

```bash
docker build -t gaza1000 .
docker run --rm -p 8080:80 gaza1000   # http://localhost:8080
```

Coolify uses the committed `Dockerfile` (build pack = Dockerfile), exposed port **80**.

## Assets & standards

- **Fonts** — Thmanyah, self-hosted per BIXET Base Resources §1 (proprietary; bundle per-app,
  served same-origin — never a shared host).
- **Icons** — Font Awesome **Pro kit `f982182577`**, hosted script per BIXET Base Resources §3.B
  (the standard path for plain HTML). The kit is **domain-locked**: `gaza1000.bixet.tech`
  (or `*.bixet.tech`) must be authorized on the Font Awesome dashboard or icons render blank.
- **Favicon** — Palestine flag (not the BIXET mark): black/white/green bands + red hoist triangle.

## Data note

The three `data/*.geojson` files (Occupied Palestine, Remaining Palestine, Remaining
Palestine-detailed) are included as source assets. The page's map is still the original embedded
SVG geometry — these files are **not** yet used to regenerate it.
