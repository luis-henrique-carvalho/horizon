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

  describe 'scopes' do
    let!(:active_goal) { Goal.create!(title: 'Active', user: user, category: :marketing, status: :on_track) }
    let!(:behind_goal) { Goal.create!(title: 'Behind', user: user, category: :product, status: :behind) }
    let!(:completed_goal) { Goal.create!(title: 'Completed', user: user, category: :sales, status: :completed) }
    let!(:at_risk_goal) { Goal.create!(title: 'At Risk', user: user, category: :security, status: :at_risk) }

    describe '.by_status' do
      it 'filters goals by status' do
        expect(Goal.by_status(:on_track)).to include(active_goal)
        expect(Goal.by_status(:on_track)).not_to include(behind_goal)
      end
    end

    describe '.by_category' do
      it 'filters goals by category' do
        expect(Goal.by_category(:marketing)).to include(active_goal)
        expect(Goal.by_category(:marketing)).not_to include(behind_goal)
      end
    end

    describe '.active' do
      it 'includes goals that are not completed' do
        expect(Goal.active).to include(active_goal, behind_goal, at_risk_goal)
        expect(Goal.active).not_to include(completed_goal)
      end
    end

    describe '.archived' do
      it 'includes goals that are completed' do
        expect(Goal.archived).to include(completed_goal)
        expect(Goal.archived).not_to include(active_goal)
      end
    end

    describe 'sorting' do
      let!(:goal_soon) { Goal.create!(title: 'Soon', user: user, category: :other, status: :on_track, deadline: 1.day.from_now) }
      let!(:goal_later) { Goal.create!(title: 'Later', user: user, category: :other, status: :on_track, deadline: 1.week.from_now) }

      it 'sorts by deadline' do
        expect(Goal.order_by_deadline(:asc).first).to eq(goal_soon)
      end

      it 'sorts by progress' do
        # Create a goal with 100% progress
        m_full = completed_goal.milestones.build(title: 'M', order: 1)
        m_full.subtasks.build(title: 'S', completed: true)
        m_full.save!

        # active_goal has 0%
        expect(Goal.order_by_progress(:desc).first).to eq(completed_goal)
      end
    end
  end
end
