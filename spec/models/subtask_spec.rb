require 'rails_helper'

RSpec.describe Subtask, type: :model do
  describe 'associations' do
    it { should belong_to(:milestone) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
  end

  describe 'completion logic' do
    let(:user) { create(:user) }
    let(:goal) { create(:goal, user: user) }
    # FactoryBot already handles milestone with subtask
    let(:milestone) { create(:milestone, goal: goal) }
    let(:subtask) { milestone.subtasks.first }

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
