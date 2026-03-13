## Context

The `GoalsController#index` currently fetches all goals for the current user. The UI has placeholders for filters (tabs and dropdowns) that are not connected to any backend logic. We need to implement a robust filtering and sorting system using Rails conventions and DaisyUI.

## Goals / Non-Goals

**Goals:**
- Implement filtering by status (Active vs. Archived/Completed).
- Implement filtering by category.
- Implement sorting by deadline and progress.
- Maintain filter state across requests.
- Ensure 100% test coverage for the new logic using TDD.

**Non-Goals:**
- Full-text search (out of scope for now).
- Persistent filter preferences in the database (params-only).

## Decisions

### 1. ActiveRecord Scopes for Filtering
We will add scopes to the `Goal` model to handle filtering logic.
- `by_status(status)`: Filters goals by their status enum.
- `by_category(category)`: Filters goals by their category enum.
- `active`: Shortcut for goals that are not `completed`.
- `archived`: Shortcut for goals that are `completed`.

**Rationale**: Encapsulating query logic in the model keeps the controller clean and makes the logic reusable and testable.

### 2. Controller Params Handling
The `index` action will use a private method `filtering_params` to sanitize and apply filters.
- We will use `request.query_parameters` to build filter links in the view.

**Alternatives considered**: 
- A dedicated `Filter` service object: Overkill for the current complexity.
- Ransack gem: Adds a dependency we don't strictly need for these simple requirements.

### 3. TDD Strategy
- **Step 1**: Write RSpec model tests for the new scopes (expect failure).
- **Step 2**: Implement scopes.
- **Step 3**: Write a System Test for the filtering UI (expect failure).
- **Step 4**: Update Controller and View.

## Risks / Trade-offs

- **[Risk] URL Param Pollution** → **[Mitigation]** Use a clean structure for params (e.g., `?status=active&sort=deadline`).
- **[Trade-off] Simple vs. Complex Filtering** → We are choosing a simple approach first (YAGNI). If we need more complex logic later (AND/OR, multiple categories), we will refactor to a Service Object.
