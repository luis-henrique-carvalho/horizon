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
  end

  it "allows a user to view, edit and delete their goal" do
    goal = create(:goal, user: user, title: "Original Goal")
    
    visit goals_path
    expect(page).to have_content("Original Goal")
    
    # View details
    click_on "View Details"
    expect(page).to have_content("Original Goal")
    expect(page).to have_content("Description")

    # Edit
    visit edit_goal_path(goal)
    
    fill_in "Goal Title", with: "Updated Goal"
    click_on "Save Goal"

    expect(page).to have_content("Goal was successfully updated.")
    expect(page).to have_content("Updated Goal")

    # Delete
    visit goal_path(goal)
    click_on "Delete"
    expect(page).to have_content("Goal was successfully destroyed.")
    expect(page).not_to have_content("Updated Goal")
  end
end
