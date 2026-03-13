## 1. Preparation

- [x] 1.1 Run existing authentication tests to ensure a green baseline

## 2. Shared Views

- [x] 2.1 Refactor `app/views/devise/shared/_links.html.erb` to use `btn` classes
- [x] 2.2 Refactor `app/views/devise/shared/_error_messages.html.erb` to use DaisyUI alerts or text-error classes

## 3. Core Authentication Views

- [x] 3.1 Refactor `app/views/devise/sessions/new.html.erb` (Login) form controls and buttons
- [x] 3.2 Refactor `app/views/devise/registrations/new.html.erb` (Sign up) form controls and buttons
- [x] 3.3 Refactor `app/views/devise/registrations/edit.html.erb` (Edit profile) form controls and buttons

## 4. Password Recovery Views

- [x] 4.1 Refactor `app/views/devise/passwords/new.html.erb` (Forgot password) form controls
- [x] 4.2 Refactor `app/views/devise/passwords/edit.html.erb` (Change password) form controls

## 5. Secondary Authentication Views (If used)

- [x] 5.1 Refactor `app/views/devise/confirmations/new.html.erb` form controls
- [x] 5.2 Refactor `app/views/devise/unlocks/new.html.erb` form controls

## 6. Verification

- [x] 6.1 Run all RSpec authentication and system tests to ensure they remain green
