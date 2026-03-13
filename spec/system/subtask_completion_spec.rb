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

    # Milestone has 2 subtasks now (Turbo Streams + Default Subtask)
    expect(page).to have_content("0%")

    within "##{dom_id(subtask)}" do
      check "subtask_#{subtask.id}_completed"
      click_button "Update"
    end

    expect(page).to have_content("50%")
    expect(subtask.reload.completed).to be true
    expect(subtask.completed_at).to be_present
  end

  it "updates milestone and goal progress when multiple subtasks are completed" do
    # Já temos a subtask "Turbo Streams" e a "Default Subtask"
    visit goal_path(goal)

    expect(page).to have_content("0%")

    within "##{dom_id(subtask)}" do
      check "subtask_#{subtask.id}_completed"
      click_button "Update"
    end
    expect(page).to have_content("50%")

    within "##{dom_id(milestone.subtasks.find_by(title: "Default Subtask"))}" do
      check "subtask_#{milestone.subtasks.find_by(title: "Default Subtask").id}_completed"
      click_button "Update"
    end
    expect(page).to have_content("100%")
  end

  it "allows uncompleting a subtask and resets progress" do
    # Completar todas as subtasks (2 no total)
    milestone.subtasks.update_all(completed: true)
    visit goal_path(goal)

    expect(page).to have_content("100%")

    within "##{dom_id(subtask)}" do
      uncheck "subtask_#{subtask.id}_completed"
      click_button "Update"
    end

    expect(page).to have_content("50%")
    expect(subtask.reload.completed).to be false
    expect(subtask.completed_at).to be_nil
  end

  it "automatically completes the goal when all milestones reach 100%" do
    visit goal_path(goal)

    expect(page).to have_content("On Track")

    # Marcar todas as subtasks visíveis
    # No rack_test, cada submissão de formulário recarrega a página.
    # Vamos pegar os IDs das checkboxes no início e iterar.
    checkbox_ids = all('input[type="checkbox"]').map { |c| c[:id] }

    checkbox_ids.each do |id|
      # Re-visitar se necessário ou apenas checar se o estado mudou
      check id
      find("##{id}").find(:xpath, "./ancestor::form").find('input[type="submit"]', visible: false).click
    end

    expect(page).to have_content("Completed")
    expect(goal.reload.status).to eq("completed")
  end

  it "calculates progress correctly across multiple milestones" do
    m2 = build(:milestone, goal: goal, title: "Advanced", order: 1)
    m2.subtasks = [ build(:subtask, milestone: m2, title: "Turbo Frames", completed: false) ]
    m2.save!

    visit goal_path(goal)

    # Pegar as subtasks do primeiro milestone apenas
    within "##{dom_id(milestone)}" do
      ids = all('input[type="checkbox"]').map { |c| c[:id] }
      ids.each do |id|
        check id
        find("##{id}").find(:xpath, "./ancestor::form").find('input[type="submit"]', visible: false).click
      end
    end

    # Milestone 1 should be 100%
    within "##{dom_id(milestone)}" do
      expect(page).to have_content("100%")
    end

    # Milestone 2: 0% progress. Goal average: (100 + 0) / 2 = 50%
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
