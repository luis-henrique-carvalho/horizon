## Why

As the number of goals increases, users need a way to efficiently find and manage specific objectives. Currently, the goals index page displays all goals without functional filtering or sorting, making it difficult to track active vs. completed tasks or prioritize by deadline and category.

## What Changes

- **Backend Filtering**: Implement a filtering system in `GoalsController` (or a dedicated service object) to handle query parameters.
- **Status Tabs**: Make the "Active Goals" and "Archived" tabs functional, filtering by the `status` attribute.
- **Category Filter**: Implement the category dropdown to filter goals by their assigned category (Marketing, Product, etc.).
- **Sorting**: Implement sorting functionality for "Deadline" and "Progress".
- **Dynamic UI**: Update the index view to reflect the active filters and show accurate counts in the tabs.
- **TDD Validation**: All filtering logic and UI interactions will be verified via RSpec (model scopes and system tests).

## Capabilities

### New Capabilities
- None

### Modified Capabilities
- `goals`: Add requirements for list filterability and sorting in the collection view.

## Impact

- `GoalsController#index`: Will now handle params for filtering and sorting.
- `Goal` model: New scopes or class methods for filtering logic.
- `goals/index.html.erb`: UI components will be connected to form submissions or link-based filtering.
