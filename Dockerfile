# Static site served by nginx. No build step, no runtime deps.
FROM nginx:alpine

LABEL org.opencontainers.image.title="gaza-1000-days-later" \
      org.opencontainers.image.description="Gaza in 1,000 Days — bilingual data page (static)"

# Replace the default server block with ours (port 80, cache + geojson mime)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Web root: everything under public/ (index.html, fonts, favicon, data)
COPY public/ /usr/share/nginx/html/

EXPOSE 80
