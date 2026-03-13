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

    fill_in "Title", with: "System Test Goal"
    select "Product", from: "Category"
    select "On Track", from: "Status"
    fill_in "Progress", with: "50"
    fill_in "Description", with: "Testing the flow"
    click_on "Save Goal"

    expect(page).to have_content("Goal was successfully created.")
    expect(page).to have_content("System Test Goal")
    expect(page).to have_content("50%")
  end

  it "allows a user to view, edit and delete their goal" do
    goal = create(:goal, user: user, title: "Original Goal", progress: 10)
    
    visit goals_path
    expect(page).to have_content("Original Goal")
    
    # View details
    click_on "View Details"
    expect(page).to have_content("Original Goal")
    expect(page).to have_content("Description")

    # Edit
    click_on "Edit Goal"
    fill_in "Title", with: "Updated Goal"
    fill_in "Progress", with: "80"
    click_on "Save Goal"

    expect(page).to have_content("Goal was successfully updated.")
    expect(page).to have_content("Updated Goal")
    expect(page).to have_content("80%")

    # Delete (needs driver support for js confirm if used, but we use button_to which creates a form in rack_test)
    visit goal_path(goal)
    click_button "Delete"
    expect(page).to have_content("Goal was successfully destroyed.")
    expect(page).not_to have_content("Updated Goal")
  end
end
