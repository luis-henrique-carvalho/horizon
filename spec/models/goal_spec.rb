require 'rails_helper'

RSpec.describe Goal, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:status) }
    it { should validate_numericality_of(:progress).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(100) }
  end

  describe 'enums' do
    it { should define_enum_for(:category).with_values(marketing: 0, product: 1, sales: 2, security: 3, other: 4) }
    it { should define_enum_for(:status).with_values(on_track: 0, behind: 1, completed: 2, at_risk: 3) }
  end

  describe 'defaults' do
    let(:user) { create(:user) }
    
    it 'sets default progress to 0' do
      goal = Goal.new(title: 'My Goal', category: :product, status: :on_track, user: user)
      expect(goal.progress).to eq(0)
    end
  end
end
