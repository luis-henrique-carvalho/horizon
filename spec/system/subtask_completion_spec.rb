require 'rails_helper'

RSpec.describe "Subtask Completion", type: :system do
  include ActionView::RecordIdentifier
  let(:user) { create(:user) }
  let(:goal) { create(:goal, user: user, title: "Learn Hotwire") }
  let(:milestone) { create(:milestone, goal: goal, title: "Basics") }
  let!(:subtask) { create(:subtask, milestone: milestone, title: "Turbo Streams", completed: false) }

  before do
    driven_by(:rack_test)
    sign_in user
  end

  it "allows completing a subtask directly from the goal show page" do
    visit goal_path(goal)

    expect(page).to have_content("Turbo Streams")
    expect(page).to have_content("0%") # Initial milestone progress

    # In rack_test, the onchange won't trigger. 
    # We'll find the form and submit it via the hidden button.
    within "##{dom_id(subtask)}" do
      check "subtask_#{subtask.id}_completed"
      click_button "Update"
    end
    
    # The page should show updated progress and status
    expect(page).to have_content("100%") # Milestone progress
    expect(subtask.reload.completed).to be true
  end
end
