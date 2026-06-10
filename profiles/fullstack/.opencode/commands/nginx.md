---
description: Nginx routing, reverse proxy, TLS, security headers, caching, and upstreams.
agent: nginx
---

Load Nginx and security guidance. Work on this Nginx request: $ARGUMENTS

Check server blocks, upstreams (Compose service name:port), proxy headers (`Host`, `X-Real-IP`, `X-Forwarded-For`, `X-Forwarded-Proto`), TLS (no SSLv3/TLS 1.0/1.1), security headers (`Strict-Transport-Security`, `X-Content-Type-Options`, `X-Frame-Options`), cache rules for authenticated content, internal route exposure, and `nginx -t` syntax verification.
