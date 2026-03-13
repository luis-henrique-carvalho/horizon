require 'rails_helper'

RSpec.describe "Goal creation with nested attributes", type: :model do
  let(:user) { create(:user) }

  it "does not raise FloatDomainError during creation with nested milestones and subtasks" do
    params = {
      title: "New Goal",
      user: user,
      category: "marketing",
      status: "on_track",
      milestones_attributes: [
        {
          title: "M1",
          order: 0,
          subtasks_attributes: [
            { title: "S1", completed: false }
          ]
        }
      ]
    }

    expect { Goal.create!(params) }.not_to raise_error
    
    goal = Goal.last
    expect(goal.progress).to eq(0)
  end

  it "sets status to completed if progress is 100% during creation" do
    params = {
      title: "Completed Goal",
      user: user,
      category: "marketing",
      status: "on_track",
      milestones_attributes: [
        {
          title: "M1",
          order: 0,
          subtasks_attributes: [
            { title: "S1", completed: true }
          ]
        }
      ]
    }

    goal = Goal.create!(params)
    expect(goal.status).to eq("completed")
    expect(goal.progress).to eq(100)
  end
end
