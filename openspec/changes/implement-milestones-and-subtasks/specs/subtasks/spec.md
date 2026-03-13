## ADDED Requirements

### Requirement: Subtask Association
The system MUST allow a Milestone to have multiple Subtasks.

#### Scenario: Milestone with Subtasks
- **WHEN** a user views a milestone
- **THEN** the system SHALL display all associated subtasks

### Requirement: Subtask Attributes
Each Subtask MUST have a title (required) and a completion status (default: false).

#### Scenario: Creating a Subtask
- **WHEN** a user provides a title for a subtask
- **THEN** the system SHALL save the subtask with completed=false

### Requirement: Subtask Completion Tracking
The system MUST record the `completed_at` timestamp when a subtask is marked as completed.

#### Scenario: Marking a Subtask as Complete
- **WHEN** a user marks a subtask as completed
- **THEN** the system SHALL update `completed_at` to the current time
