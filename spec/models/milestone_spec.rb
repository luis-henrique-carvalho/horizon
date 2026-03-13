require 'rails_helper'

RSpec.describe Milestone, type: :model do
  let(:goal) { create(:goal) }

  it "is valid with a title, order and at least one subtask" do
    milestone = Milestone.new(title: "Milestone", order: 0, goal: goal)
    milestone.subtasks.build(title: "Subtask")
    expect(milestone).to be_valid
  end

  it "is invalid without subtasks" do
    milestone = Milestone.new(title: "Milestone", order: 0, goal: goal)
    expect(milestone).not_to be_valid
    expect(milestone.errors[:base]).to include("Each milestone must have at least one subtask")
  end

  it "is invalid if all subtasks are marked for destruction" do
    milestone = create(:milestone, goal: goal)
    milestone.subtasks.each(&:mark_for_destruction)
    expect(milestone).not_to be_valid
  end
end
