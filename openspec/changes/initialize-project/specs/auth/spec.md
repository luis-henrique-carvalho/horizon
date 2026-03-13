## ADDED Requirements

### Requirement: User Authentication Backbone
The system MUST implement user authentication using the Devise gem, providing standard functionalities like signup, sign-in, sign-out, and password recovery.

#### Scenario: User signs up
- **WHEN** a new user provides a valid email and password in the signup form
- **THEN** a new User record is created in the database and the user is logged in

#### Scenario: User signs in
- **WHEN** an existing user provides their correct credentials
- **THEN** the user is authenticated and redirected to the home page

### Requirement: Strict Session Management
The system MUST require authentication by default for all routes using a global `before_action :authenticate_user!`, except for explicitly excluded pages like landing or login.

#### Scenario: Accessing protected page
- **WHEN** an unauthenticated visitor attempts to access a protected route
- **THEN** the visitor is redirected to the login page with an alert

### Requirement: DaisyUI Styled Auth Views
The system SHALL have all Devise-generated views (login, signup, etc.) refactored to use DaisyUI component semantics (`form-control`, `input-bordered`, `btn-primary`).

#### Scenario: Sign-in form styling
- **WHEN** viewing the sign-in page
- **THEN** all input fields and buttons have consistent DaisyUI component classes applied
