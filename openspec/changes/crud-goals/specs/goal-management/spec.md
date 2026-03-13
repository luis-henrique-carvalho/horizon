## ADDED Requirements

### Requirement: Goal Management (CRUD)
The system SHALL allow authenticated users to manage their strategic goals, including creation, visualization, modification, and deletion.

#### Scenario: User creates a new strategic goal
- **WHEN** the authenticated user submits the new goal form with a valid title, category, status, progress level, and deadline
- **THEN** a new `Goal` record is created associated with the user
- **THEN** the system redirects the user to the goals index (or the goal details) with a success notification

#### Scenario: User views the goals dashboard
- **WHEN** the authenticated user accesses the goals index page
- **THEN** the system displays all goals that belong strictly to that user, formatted as responsive cards
- **THEN** the underlying database query uses strict_loading or includes to avoid N+1 queries

#### Scenario: User edits an existing goal
- **WHEN** the user modifies the existing goal's progress or status and submits the edit form
- **THEN** the goal is updated in the database
- **THEN** the updated information accurately reflects on the goals dashboard

#### Scenario: User deletes a goal
- **WHEN** the user initiates the deletion of one of their goals
- **THEN** the goal is permanently removed from the database
- **THEN** the goal no longer appears on the dashboard

#### Scenario: Security cross-access prevention
- **WHEN** a user attempts to access, modify or delete a goal belonging to a different `user_id`
- **THEN** the system SHALL reject the operation (e.g. by throwing an ActiveRecord::RecordNotFound exception via scoping `.where(user: current_user)`)
