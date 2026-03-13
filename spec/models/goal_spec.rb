require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:user) { User.create!(email: 'goal@test.com', password: 'password') }
  let(:goal) { Goal.create!(title: 'Goal 1', user: user, category: :other, status: :on_track) }

  describe 'progress calculation' do
    it 'returns 0 if no milestones' do
      expect(goal.progress).to eq(0)
    end

    it 'calculates average progress of milestones' do
      # Create milestones with subtasks using nested attributes or manual build to satisfy validation
      m1 = goal.milestones.build(title: 'M1', order: 1)
      m1.subtasks.build(title: 'S1', completed: true)
      m1.subtasks.build(title: 'S2', completed: false)
      m1.save!

      m2 = goal.milestones.build(title: 'M2', order: 2)
      m2.subtasks.build(title: 'S3', completed: true)
      m2.save!

      # M1 with 50% (1/2 subtasks)
      # M2 with 100% (1/1 subtask)
      # Goal progress = (50 + 100) / 2 = 75
      expect(goal.progress).to eq(75)
    end
  end
end
