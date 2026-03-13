## Why

The current Devise views lack a cohesive and modern user interface, potentially relying on default Rails scaffolding or inconsistent utility classes. Refactoring these views using DaisyUI and Tailwind CSS will align the authentication flows with the project's central design system, improving the user experience, maintainability, and aesthetic quality of the application.

## What Changes

- Refactor `app/views/devise/sessions/new.html.erb` (Login) to use DaisyUI semantic components (e.g., `form-control`, `input`, `btn-primary`).
- Refactor `app/views/devise/registrations/new.html.erb` (Sign up) and `edit.html.erb` (Edit profile) using DaisyUI.
- Refactor passwords (`new.html.erb`, `edit.html.erb`), confirmations, and unlocks views similarly if they are used.
- Update Devise shared links (`app/views/devise/shared/_links.html.erb`) to use styled buttons and links from DaisyUI.
- Ensure all views respect the "Frank" philosophy by avoiding "utility soup" in favor of semantic DaisyUI classes.

## Capabilities

### New Capabilities
- `auth-ui`: Modernized authentication user interface utilizing DaisyUI for standard Devise flows.

### Modified Capabilities

## Impact

- Visually impacts all authentication pages (login, registration, password recovery).
- Improves the frontend codebase maintainability by standardizing on DaisyUI components.
- No changes to the underlying Devise routing, controllers, or database schema—only UI/UX modifications.
