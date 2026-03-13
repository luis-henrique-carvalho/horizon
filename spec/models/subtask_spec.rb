require 'rails_helper'

RSpec.describe Subtask, type: :model do
  describe 'associations' do
    it { should belong_to(:milestone) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
  end

  describe 'completion logic' do
    let(:user) { User.create!(email: 'test@example.com', password: 'password') }
    let(:goal) { Goal.create!(title: 'G1', user: user, category: :other, status: :on_track) }
    let(:milestone) { Milestone.create!(title: 'M1', order: 1, goal: goal) }
    let(:subtask) { Subtask.create!(title: 'Task 1', milestone: milestone) }

    it 'is not completed by default' do
      expect(subtask.completed).to be_falsey
      expect(subtask.completed_at).to be_nil
    end

    it 'sets completed_at when marked as completed' do
      subtask.update(completed: true)
      expect(subtask.completed_at).to be_present
    end

    it 'clears completed_at when marked as uncompleted' do
      subtask.update(completed: true)
      subtask.update(completed: false)
      expect(subtask.completed_at).to be_nil
    end
  end
end
