require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:user) { User.create!(email: 'goal@test.com', password: 'password') }
  let(:goal) { Goal.create!(title: 'Goal 1', user: user, category: :other, status: :on_track) }

  describe 'progress calculation' do
    it 'returns 0 if no milestones' do
      expect(goal.progress).to eq(0)
    end

    it 'calculates average progress of milestones' do
      m1 = goal.milestones.create!(title: 'M1', order: 1)
      m2 = goal.milestones.create!(title: 'M2', order: 2)
      
      # M1 with 50% (1/2 subtasks)
      m1.subtasks.create!(title: 'S1', completed: true)
      m1.subtasks.create!(title: 'S2', completed: false)
      
      # M2 with 100% (1/1 subtask)
      m2.subtasks.create!(title: 'S3', completed: true)
      
      # Goal progress = (50 + 100) / 2 = 75
      expect(goal.progress).to eq(75)
    end
  end
end
