## 1. Database & Model

- [ ] 1.1 Create `Goal` model logic with `title:string`, `description:text`, `category:integer`, `status:integer`, `progress:integer`, `deadline:date`, `user:references`
- [ ] 1.2 Define `enum` for `category` and `status` in `app/models/goal.rb`, along with validations and default values
- [ ] 1.3 Configure FactoryBot definition for `Goal` in `spec/factories/goals.rb`
- [ ] 1.4 Implement RSpec model tests in `spec/models/goal_spec.rb` verifying associations, enums, and validations
- [ ] 1.5 Execute database migrations

## 2. Controller & Routing

- [ ] 2.1 Add CRUD routes using `resources :goals` in `config/routes.rb`
- [ ] 2.2 Create `GoalsController` implementing standard index, show, new, create, edit, update, destroy actions
- [ ] 2.3 Ensure actions correctly scope to `current_user.goals` and prevent N+1 queries
- [ ] 2.4 Write RSpec request tests in `spec/requests/goals_spec.rb` to assert successful flows and proper isolation between users

## 3. UI Implementation (DaisyUI)

- [x] 3.1 Implement `app/views/goals/index.html.erb` displaying the goals dashboard with responsive cards and progress bars
- [x] 3.2 Build the shared form partial `app/views/goals/_form.html.erb` utilizing DaisyUI components
- [x] 3.3 Create `app/views/goals/new.html.erb` and `app/views/goals/edit.html.erb` views
- [x] 3.4 Create `app/views/goals/show.html.erb` to display extended goal details
- [x] 3.5 Write RSpec system tests in `spec/system/goals_spec.rb` verifying the user flow from creation to deletion
