# Gaza in 1,000 Days — static site

Bilingual (Arabic / English) data record of Gaza across ~1,000 days. Live at
**https://gaza1000.bixet.tech** (`/ar/` and `/en/`).

## Structure

```
public/
  index.html              # root: redirects to /ar/ or /en/ (Accept-Language; nginx server-side + JS fallback)
  ar/index.html           # Arabic page  — <html lang="ar" dir="rtl">, Arabic-only, no toggle
  en/index.html           # English page — <html lang="en" dir="ltr">, English-only, no toggle
  thmanyah-fonts.css      # bundled Thmanyah @font-face (self-hosted, same-origin)
  fonts/*.woff2           # 15 Thmanyah files (3 families x 5 weights)
  icon.svg                # Palestine-flag favicon (drawn)
  favicon.ico             # 16/32/48 raster fallback
  apple-icon.png          # 180x180 apple-touch-icon
  og-image.jpg            # social share image, 1024x1024
  robots.txt              # allows all + points to sitemap
  sitemap.xml             # /ar/ + /en/ with xhtml:link hreflang alternates
  data/*.geojson          # source geometry (occupied / remaining Palestine) — data only, not wired into the map
Dockerfile                # nginx:alpine, serves public/ on port 80
nginx.conf                # Accept-Language root redirect + folder serving + cache/geojson mime
```

Each language is a **fully separate static page** (same shared design, fonts, icons, inline map SVGs,
CSS). No `.only-ar`/`.only-en` toggle machinery — each page renders only its own language natively, with
a single switch link (`EN` on the Arabic page, `ع` on the English page) pointing to the other.

Regenerated from a single source via a jsdom split script (kept out of the repo). To re-split, run that
script against a bilingual source; do not hand-edit `/ar/` and `/en/` in parallel.

## Build / run

No build step — nginx serves `public/`:

```bash
docker build -t gaza1000 .
docker run --rm -p 8080:80 gaza1000   # http://localhost:8080
```

Coolify uses the committed `Dockerfile` (build pack = Dockerfile), exposed port **80**.

## Assets & standards

- **Fonts** — Thmanyah, self-hosted per BIXET Base Resources §1 (bundle per-app, same-origin).
- **Icons** — Font Awesome **Pro kit `f982182577`**, hosted script (§3.B). Domain-locked; `*.bixet.tech`
  is authorized.
- **Favicon** — Palestine flag. **Social image** — `og-image.jpg` (1024x1024).
- **SEO** — per-language `<title>`/description, canonical + `ar`/`en`/`x-default` hreflang, Open Graph +
  Twitter cards, and Dataset + NewsArticle JSON-LD (each in its own language).
