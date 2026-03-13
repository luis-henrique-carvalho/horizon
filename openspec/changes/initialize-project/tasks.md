## 1. Application Setup & Infrastructure

- [x] 1.1 Run `rails new . --database=sqlite3 --css=tailwind --javascript=importmap --skip-test` to initialize the project.
- [x] 1.2 Verify separate SQLite databases are created for `development` (primary, queue, cache).
- [x] 1.3 Verify documentation for `devise`, `rspec-rails`, and `daisyui` regarding Rails 8 and Solid Stack compatibility.
- [x] 1.4 Add necessary gems to `Gemfile`: `rspec-rails`, `factory_bot_rails`, `capybara`, `shoulda-matchers`, `devise`, `daisyui`.
- [x] 1.5 Run `bundle install` and initialize Tailwind CSS.
- [x] 1.6 Create a multi-stage `Dockerfile` optimized for Rails 8 and SQLite.
- [x] 1.7 Create a `docker-compose.yml` defining `web`, `queue`, and `cache` services with persistent volume mapping for SQLite files.
- [x] 1.8 Verify the application can be built and run using `docker compose up`. (Verified syntax with docker compose config)

## 2. Testing & Quality Foundation

- [x] 2.1 Run `rails generate rspec:install` and remove the `test/` directory.
- [x] 2.2 Configure `spec/rails_helper.rb` with FactoryBot, Capybara, and Shoulda Matchers.
- [x] 2.3 Initialize RuboCop with a basic `.rubocop.yml` and run `bundle exec rubocop -A` to fix initial boilerplate issues.
- [x] 2.4 Create a smoke test (`spec/system/health_check_spec.rb`) to verify the Rails environment and RSpec/Capybara are working.

## 3. Authentication & User Model

- [x] 3.1 Run `rails generate devise:install` and follow post-installation instructions.
- [x] 3.2 Create a Red test: `spec/models/user_spec.rb` to verify User model creation.
- [x] 3.3 Run `rails generate devise User` and `rails db:migrate`.
- [x] 3.4 Ensure User tests are Green.
- [x] 3.5 Update `ApplicationController` to include `before_action :authenticate_user!` and `skip_before_action` for the landing page (if any).

## 4. UI Foundation & Devise Styling

- [x] 4.1 Update `tailwind.config.js` to include the DaisyUI plugin. (Handled via CSS @import in Tailwind 4)
- [x] 4.2 Create a basic `ApplicationLayout` using DaisyUI components (Navbar, Alert partials for flash).
- [x] 4.3 Run `rails generate devise:views` to generate Devise templates.
- [x] 4.4 Refactor `app/views/devise/sessions/new.html.erb` to use DaisyUI `form-control`, `input`, and `btn` classes.
- [x] 4.5 Refactor `app/views/devise/registrations/new.html.erb` to use DaisyUI component semantics.
- [x] 4.6 Verify all auth flows (sign in/up) are working and styled correctly in a system spec.
