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

    within "##{dom_id(subtask)}" do
      check "subtask_#{subtask.id}_completed"
      click_button "Update"
    end

    expect(page).to have_content("100%")
    expect(subtask.reload.completed).to be true
    expect(subtask.completed_at).to be_present
  end

  it "updates milestone and goal progress when multiple subtasks are completed" do
    create(:subtask, milestone: milestone, title: "Second Task", completed: false)
    visit goal_path(goal)

    expect(page).to have_content("0%")

    within "##{dom_id(Subtask.first)}" do
      check "subtask_#{Subtask.first.id}_completed"
      click_button "Update"
    end
    expect(page).to have_content("50%")

    within "##{dom_id(Subtask.last)}" do
      check "subtask_#{Subtask.last.id}_completed"
      click_button "Update"
    end
    expect(page).to have_content("100%")
  end

  it "allows uncompleting a subtask and resets progress" do
    subtask.update!(completed: true)
    visit goal_path(goal)

    expect(page).to have_content("100%")

    within "##{dom_id(subtask)}" do
      uncheck "subtask_#{subtask.id}_completed"
      click_button "Update"
    end

    expect(page).to have_content("0%")
    expect(subtask.reload.completed).to be false
    expect(subtask.completed_at).to be_nil
  end

  it "automatically completes the goal when all milestones reach 100%" do
    visit goal_path(goal)

    expect(page).to have_content("On Track")

    within "##{dom_id(subtask)}" do
      check "subtask_#{subtask.id}_completed"
      click_button "Update"
    end

    expect(page).to have_content("Completed")
    expect(goal.reload.status).to eq("completed")
  end

  it "calculates progress correctly across multiple milestones" do
    m2 = create(:milestone, goal: goal, title: "Advanced", order: 1)
    create(:subtask, milestone: m2, title: "Turbo Frames", completed: false)

    visit goal_path(goal)

    # Milestone 1: 0%, Milestone 2: 0%, Goal Progress: 0%
    # Complete subtask in Milestone 1
    within "##{dom_id(subtask)}" do
      check "subtask_#{subtask.id}_completed"
      click_button "Update"
    end

    # Milestone 1 should be 100%, Milestone 2 should be 0%, Goal should be 50%
    expect(page).to have_content("100%")
    # The overall progress card should show 50%
    within ".card", text: "Progress" do
      expect(page).to have_content("50%")
    end
  end

  it "shows the completion timestamp when a subtask is done" do
    visit goal_path(goal)

    within "##{dom_id(subtask)}" do
      check "subtask_#{subtask.id}_completed"
      click_button "Update"
    end

    expect(page).to have_content(/Done on [A-Z][a-z]{2} \d{2}/)
  end

  context "unauthorized access" do
    let(:other_user) { create(:user) }
    let(:other_goal) { create(:goal, user: other_user) }
    let(:other_milestone) { create(:milestone, goal: other_goal) }
    let(:other_subtask) { create(:subtask, milestone: other_milestone) }

    it "does not display subtasks from other users" do
      visit goal_path(goal)
      expect(page).not_to have_selector("##{dom_id(other_subtask)}")
    end
  end
end
