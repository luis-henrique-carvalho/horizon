## Why

Bootstrap Project Horizon with a modern, production-ready Ruby on Rails foundation. We need a solid starting point that adheres to the project's "Frank" philosophy: Zero Guesswork (YAGNI), Extreme Programming (TDD), and Baby Steps. This establishes the architectural boundaries and basic authentication before we implement the core "Goal Engine" and "Oracle".

## What Changes

- **Infrastructure:** Initialize a new Rails 8 application using the modern "Solid Stack" (Solid Queue, Solid Cache, Solid Cable) and configure **Docker** for development and production parity.
- **Database:** Configure **SQLite** with separate databases for app, queue, and cache (Rails 8 defaults), optimized for development and small-scale production.
- **Containerization:** Create a multi-stage `Dockerfile` and a `docker-compose.yml` to orchestrate the Rails app and its persistent SQLite volumes.
- **Authentication:** Install **Devise** and configure it to be required by default across the entire application.
- **Frontend:** Setup **Tailwind CSS** and **DaisyUI** with **Importmaps**.
- **Testing:** Configure **RSpec**, **Capybara**, **FactoryBot**, and **Shoulda Matchers**.
- **Linting:** Setup **RuboCop** with project-specific rules to enforce clean code from day one.
- **Base UI:** Create a standard application layout using DaisyUI's layout components (Navbar, Flash alerts, and Footer).

## Capabilities

### New Capabilities
- `project-foundation`: A ready-to-work Rails 8 environment with a full TDD suite and linting.
- `auth`: User authentication (signup, login, logout) with DaisyUI-styled views and strict session management.

## Impact

- New repository structure including `app/`, `config/`, `db/`, `spec/`, `.rubocop.yml`, `Dockerfile`, and `docker-compose.yml`.
- Initial `Gemfile` with the full Rails 8 stack and testing gems.
- `User` model and initial database schema.
- Ready-to-use containerized development environment.
