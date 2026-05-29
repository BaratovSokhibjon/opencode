---
name: nginx
description: Checklist for Nginx routing — reverse proxy, TLS, security headers, upstreams, caching, and static assets.
---

## Routing

- [ ] Server names and environments match existing domain conventions.
- [ ] Specific `location` blocks are not shadowed by broad matches.
- [ ] Redirects are intentional, correct (301 vs 302), and do not loop.
- [ ] Static assets and application routes are separated clearly.
- [ ] Internal-only endpoints (admin, debug, metrics) are blocked from external access.

## Proxying

- [ ] Upstreams point to the intended Compose service name and port — not host ports.
- [ ] Proxy headers preserve host, real client IP, scheme, and request ID:
  - `proxy_set_header Host $host;`
  - `proxy_set_header X-Real-IP $remote_addr;`
  - `proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;`
  - `proxy_set_header X-Forwarded-Proto $scheme;`
- [ ] Timeouts and `client_max_body_size` fit the application's requirements.
- [ ] WebSocket/SSE upgrades (`Upgrade`, `Connection`) configured when needed.

## Security

- [ ] TLS configuration is not weakened — no SSLv3/TLS 1.0/1.1; prefer TLS 1.2+.
- [ ] HSTS set for HTTPS-only services: `Strict-Transport-Security: max-age=31536000; includeSubDomains; preload`.
- [ ] Security headers present for public apps:
  - `X-Content-Type-Options: nosniff`
  - `X-Frame-Options: DENY`
  - `Referrer-Policy: strict-origin-when-cross-origin`
  - `Permissions-Policy: camera=(), microphone=(), geolocation=()`
- [ ] Authenticated/private content is not cached publicly (`Cache-Control: no-store`).
- [ ] File upload endpoints have `client_max_body_size` limits.

## Verification

- [ ] `nginx -t` syntax validation passes.
- [ ] Routing checked with `curl -v` or browser against expected host/path behavior.
- [ ] HTTP → HTTPS redirect confirmed when applicable.
- [ ] Security headers verified with `curl -I` response headers.
