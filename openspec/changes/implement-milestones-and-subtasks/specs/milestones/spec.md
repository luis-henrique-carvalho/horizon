## ADDED Requirements

### Requirement: Milestone Association
The system MUST allow a Goal to have multiple Milestones.

#### Scenario: Goal with Milestones
- **WHEN** a user views a goal
- **THEN** the system SHALL display all associated milestones in their logical order

### Requirement: Milestone Attributes
Each Milestone MUST have a title (required) and an order (integer, required for sorting).

#### Scenario: Creating a Milestone
- **WHEN** a user provides a title and order for a milestone
- **THEN** the system SHALL save the milestone successfully
