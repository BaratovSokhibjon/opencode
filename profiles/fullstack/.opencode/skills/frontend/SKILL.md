---
name: frontend
description: Checklist for frontend implementation — UI, state, forms, API integration, loading/error/empty states, accessibility, security, and performance.
---

## Component Fit

- [ ] Uses existing components, design tokens, layout primitives, and styling conventions.
- [ ] Components are focused with clear props and single responsibility.
- [ ] No one-off abstractions unless immediately reused.
- [ ] Files organized by feature/domain, not by file type. All source code in `src/`.

## User States

- [ ] Loading, empty, error, success, disabled, and permission-denied states are explicit.
- [ ] API failures surface actionable messages — no raw error codes or stack traces shown to users.
- [ ] Destructive actions require clear affordance and confirmation where appropriate.

## State and Data Flow

- [ ] Single source of truth for server/client state.
- [ ] Server state managed with a data-fetching library (TanStack Query, SWR, or equivalent).
- [ ] Effects clean up subscriptions, timers, and inflight requests on unmount.
- [ ] Mutations invalidate or optimistically update cached data correctly.
- [ ] Forms prevent double submit and preserve validation errors across re-renders.
- [ ] Shareable state (filters, sort order, pagination, active tab, search query) persisted in URL query params.

## Security

- [ ] All user inputs validated client-side before submission; server always re-validates.
- [ ] No `innerHTML` or `dangerouslySetInnerHTML` with unsanitized content.
- [ ] External links with `target="_blank"` include `rel="noopener noreferrer"`.
- [ ] No API keys, tokens, or secrets hardcoded in frontend source or build artifacts.

## Accessibility

- [ ] Interactive elements are keyboard reachable and have visible focus styles.
- [ ] Inputs have associated `<label>` elements and validation messaging.
- [ ] Focus management works correctly for dialogs, drawers, and client-side route changes.
- [ ] ARIA attributes used only when semantic HTML is insufficient.
- [ ] Color contrast meets WCAG AA minimum (4.5:1 for normal text, 3:1 for large text).

## Performance

- [ ] Images have explicit `width` and `height` to prevent layout shifts (CLS < 0.1).
- [ ] Hero/above-the-fold assets use `fetchpriority="high"` and `loading="eager"`.
- [ ] Below-the-fold assets use `loading="lazy"`.
- [ ] Heavy libraries (charts, editors, rich UI) are dynamically imported.
- [ ] Only compositor-friendly properties animated (`transform`, `opacity`) — avoid `width`, `height`, `top`, `margin`.

## Verification

- [ ] Component/unit tests cover logic-heavy UI code.
- [ ] Critical user flows checked in a browser or E2E test.
- [ ] Responsive behavior verified at key breakpoints: 320, 768, 1024, 1440.
- [ ] Both light and dark themes tested when the project supports them.
