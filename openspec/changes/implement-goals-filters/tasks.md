## 1. Model & Data Layer (TDD)

- [x] 1.1 Create RSpec model tests for `Goal` scopes (`by_status`, `by_category`, `active`, `archived`)
- [x] 1.2 Implement filtering scopes in `Goal` model to satisfy tests
- [x] 1.3 Add sorting logic for deadline and progress in `Goal` model

## 2. Controller & Logic

- [x] 2.1 Update `GoalsController#index` to apply filters and sorting from params
- [x] 2.2 Refactor params handling into a private method for security and cleanliness

## 3. UI & System Tests (TDD)

- [x] 3.1 Create System Test (Capybara) for filtering and sorting interactions
- [x] 3.2 Update `goals/index.html.erb` to implement functional Status Tabs using active filters
- [x] 3.3 Replace static dropdowns with functional filter/sort forms using DaisyUI components
- [x] 3.4 Ensure filter state (params) is preserved when switching between filters

## 4. Validation

- [x] 4.1 Run `bundle exec rspec` to verify all new features
- [x] 4.2 Run `bundle exec rubocop -A` to ensure code style compliance
