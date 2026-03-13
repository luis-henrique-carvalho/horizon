require 'rails_helper'

RSpec.describe "Goals", type: :system do
  let(:user) { create(:user) }

  before do
    driven_by(:rack_test)
    sign_in user
  end

  it "allows a user to create a new goal" do
    visit goals_path

    expect(page).to have_content("My Goals")
    click_on "Create New Goal"

    fill_in "Goal Title", with: "System Test Goal"
    select "Product", from: "Category"
    select "On Track", from: "Status"
    fill_in "Target End Date", with: "2024-12-31"
    fill_in "Description", with: "Testing the flow"
    click_on "Save Goal"

    expect(page).to have_content("Goal was successfully created.")
    expect(page).to have_content("System Test Goal")
    expect(page).to have_content("0%")

    expect(Goal.count).to eq(1)
  end

  it "shows errors when creating a goal with invalid data" do
    visit new_goal_path
    click_on "Save Goal"

    expect(page).to have_content("1 error prohibited this goal from being saved")
    expect(page).to have_content("Title can't be blank")
  end

  it "allows a user to view their goal" do
    goal = create(:goal, user: user, title: "Original Goal")
    visit goals_path
    click_on "View Details"

    expect(page).to have_content("Original Goal")
    expect(page).to have_current_path(goal_path(goal))
  end

  it "allows a user to edit their goal" do
    goal = create(:goal, user: user, title: "Original Goal")
    visit edit_goal_path(goal)

    fill_in "Goal Title", with: "Updated Goal"
    click_on "Save Goal"

    expect(page).to have_content("Goal was successfully updated.")
    expect(page).to have_content("Updated Goal")
  end

  it "shows errors when updating a goal with invalid data" do
    goal = create(:goal, user: user)
    visit edit_goal_path(goal)

    fill_in "Goal Title", with: ""
    click_on "Save Goal"

    expect(page).to have_content("1 error prohibited this goal from being saved")
    expect(page).to have_content("Title can't be blank")
  end

  it "allows a user to delete their goal" do
    goal = create(:goal, user: user, title: "Original Goal")
    visit goal_path(goal)

    click_on "Delete"
    expect(page).to have_content("Goal was successfully destroyed.")
    expect(page).not_to have_content("Original Goal")
    expect(Goal.count).to eq(0)
  end

  it "displays milestones and subtasks with clear hierarchy" do
    goal = create(:goal, user: user)
    milestone = create(:milestone, goal: goal, title: "Design Phase")
    create(:subtask, milestone: milestone, title: "Wireframes")

    visit edit_goal_path(goal)

    expect(page).to have_selector(".milestone-card")
    within ".milestone-card" do
      expect(page).to have_field(with: "Design Phase")
      expect(page).to have_selector(".subtask-section")

      within ".subtask-section" do
        expect(page).to have_field(with: "Wireframes")
      end
    end
  end

  it "shows errors when milestone title is missing" do
    goal = create(:goal, user: user)
    create(:milestone, goal: goal, title: "Design Phase")

    visit edit_goal_path(goal)
    fill_in with: "", placeholder: "Milestone Title"
    click_on "Save Goal"

    expect(page).to have_content("Milestones title can't be blank")
  end

  it "shows errors when subtask title is missing" do
    goal = create(:goal, user: user)
    milestone = create(:milestone, goal: goal)
    create(:subtask, milestone: milestone, title: "Initial Task")

    visit edit_goal_path(goal)
    fill_in with: "", placeholder: "Subtask Name"
    click_on "Save Goal"

    expect(page).to have_content("Milestones subtasks title can't be blank")
  end

  it "updates goal progress correctly when subtasks are completed" do
    goal = create(:goal, user: user)
    milestone = create(:milestone, goal: goal)
    create(:subtask, milestone: milestone, completed: true)
    create(:subtask, milestone: milestone, completed: false)

    visit goal_path(goal)
    expect(page).to have_content("50%")
  end

  it "verifies that creating a goal creates a new record in the database" do
    visit new_goal_path

    fill_in "Goal Title", with: "DB Persistence Test"
    select "Sales", from: "Category"
    select "Behind", from: "Status"
    click_on "Save Goal"

    expect(Goal.last.title).to eq("DB Persistence Test")
    expect(Goal.last.category).to eq("sales")
    expect(Goal.last.status).to eq("behind")
  end

  it "allows updating a subtask title" do
    goal = create(:goal, user: user)
    milestone = create(:milestone, goal: goal)
    subtask = create(:subtask, milestone: milestone, title: "Old Title")

    visit edit_goal_path(goal)
    fill_in with: "New Title", placeholder: "Subtask Name"
    click_on "Save Goal"

    expect(subtask.reload.title).to eq("New Title")
  end

  context "when unauthorized" do
    let(:other_user) { create(:user) }
    let(:other_goal) { create(:goal, user: other_user) }

    it "prevents a user from viewing another user's goal" do
      # In system tests with rack_test, ActiveRecord::RecordNotFound might be caught by Rails
      # and show the 404 page
      visit goal_path(other_goal)
      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end
