## Context

The Project Horizon is a "life GPS" and achievement manager. We are starting with a blank canvas and need a robust, modern foundation in Ruby on Rails. The project prioritizes simplicity (YAGNI), reliability (TDD), and incremental progress (Baby Steps).

## Goals / Non-Goals

**Goals:**
- Initialize a Rails 8+ monolith with modern standards.
- Establish a complete TDD-ready environment with RSpec.
- Configure Devise as the authentication backbone.
- Setup DaisyUI as the component framework to avoid "utility soup".
- Implement the "Solid Stack" (Queue, Cache, Cable) to avoid Redis.
- Enforce code quality via RuboCop from the first commit.
- Containerize the application for consistent development and deployment.

**Non-Goals:**
- Implementing any logic related to the "Oracle" or "Goals" engines.
- Designing complex UI layouts or specialized dashboard components.
- Setting up multi-tenancy beyond simple user scoping.

## Decisions

### 1. Stack: Rails 8 + SQLite (Solid Stack)
- **Rationale:** Rails 8 defaults (SQLite with separate DBs for app, queue, and cache) are more than enough for the project's start. It simplifies deployment and local setup significantly while providing strong performance and reliability.
- **Decision:** Use standard Rails 8 "Solid Stack" (Solid Queue, Solid Cache, Solid Cable) to remove the need for Redis. Every gem added must be verified for compatibility with this stack (especially Rails 8) through its official documentation.

### 2. Frontend: Tailwind CSS + DaisyUI + Importmaps
- **Rationale:** Importmaps avoid the complexity of JS transpilation. DaisyUI provides semantic component classes (`btn`, `card`, `alert`) that keep the HTML cleaner than raw Tailwind (adhering to the project's styling rules).
- **Decision:** Avoid esbuild/webpack; use Propshaft and Importmaps for asset management.

### 3. Testing: RSpec & Capybara
- **Rationale:** RSpec's descriptive syntax is superior for TDD. Capybara is required for the "Red" phase of integration tests (Baby Steps).
- **Decision:** Disable the default Rails `test` folder and generators for `test-unit`.

### 4. Code Quality: RuboCop
- **Rationale:** Enforcing a consistent style is critical for long-term maintainability.
- **Decision:** Setup RuboCop with standard Rails rules and custom exclusions for common boilerplate.

### 5. Deployment & Dev Env: Docker
- **Rationale:** Containerization ensures that everyone on the team has the same environment, regardless of their OS. It also simplifies the deployment pipeline by using the same image for CI and Production.
- **Decision:** Provide a production-ready `Dockerfile` and a `docker-compose.yml` that mounts the SQLite databases as persistent volumes.

## Risks / Trade-offs

- **[Risk] SQLite concurrency limitations** → **Mitigation:** Rails 8's separate databases for jobs and cache mitigate most contention issues. If we hit limits, migration to PostgreSQL is straightforward.
- **[Risk] DaisyUI view customization** → **Mitigation:** Focus on standard DaisyUI components first. Avoid custom CSS unless absolutely necessary to keep things simple (YAGNI).
- **[Risk] Devise view styling overhead** → **Mitigation:** Refactor all Devise views to use DaisyUI `form-control`, `input`, and `btn` classes as a dedicated task.
