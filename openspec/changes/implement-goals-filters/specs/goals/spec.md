## ADDED Requirements

### Requirement: Filter by Status
The system SHALL allow users to filter the goals list by their status (`active`, `completed`, `on_hold`, `archived`).

#### Scenario: Filter by Active status
- **WHEN** the user selects the "Active" filter tab
- **THEN** the system SHALL display only goals with statuses that are considered active (e.g., `on_track`, `behind`, `at_risk`)

#### Scenario: Filter by Archived status
- **WHEN** the user selects the "Archived" filter tab
- **THEN** the system SHALL display only goals that are `completed` or explicitly `archived`

### Requirement: Filter by Category
The system SHALL allow users to filter the goals list by their category (Marketing, Product, Sales, Security, Other).

#### Scenario: Filter by specific category
- **WHEN** the user selects "Product" from the category filter dropdown
- **THEN** the system SHALL display only goals belonging to the "Product" category

### Requirement: Sort by Deadline
The system SHALL allow users to sort the goals list by their deadline/target date.

#### Scenario: Sort by soonest deadline
- **WHEN** the user selects "Deadline: Soonest"
- **THEN** the system SHALL display goals ordered by deadline in ascending order

### Requirement: Sort by Progress
The system SHALL allow users to sort the goals list by their completion progress percentage.

#### Scenario: Sort by highest progress
- **WHEN** the user selects "Progress: High to Low"
- **THEN** the system SHALL display goals ordered by progress in descending order
