## Context

The current `app/views/devise` views use default or disparate styling, which causes the authentication flows to look inconsistent with the rest of the application. The system currently uses Tailwind CSS and DaisyUI for the frontend, but the Devise views haven't been fully integrated into this design system.

## Goals / Non-Goals

**Goals:**
- Refactor all Devise views (sessions, registrations, passwords, etc.) to use DaisyUI semantic components.
- Standardize forms using `form-control`, `label`, `input input-bordered`, and `btn btn-primary`.

**Non-Goals:**
- Do not change Devise controllers or routing logic.
- Do not change the underlying User model or authentication mechanisms.
- Do not introduce SPAs or separate API endpoints for authentication.

## Decisions

- **Use DaisyUI semantic classes over Tailwind utility soup:** `btn btn-primary` instead of long strings of Tailwind color and padding classes to maintain readability and consistency, adhering to the project's Golden Rules.
- **Form Structure:** Use DaisyUI's `form-control` wrapper for each input field to easily handle labels and inputs consistently.

## Risks / Trade-offs

- **Risk:** Existing custom CSS or JavaScript might target the old class names.
  - **Mitigation:** Test all flows (login, signup, password reset) manually and via integration tests to ensure no functionality is broken and styling applies correctly.
